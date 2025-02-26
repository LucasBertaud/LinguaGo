import { Injectable, NestMiddleware, UnauthorizedException } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { JwtService } from '@nestjs/jwt';
import { AuthService } from './auth.service';
import { PrismaService } from 'src/utils/prisma.service';
import { CryptoService } from './crypto/crypto.service';

@Injectable()
export class AuthMiddleware implements NestMiddleware {
  private readonly cookieSecure: boolean;
  private readonly refreshThreshold = 10 * 60 * 1000; // 10 minutes avant expiration

  constructor(
    private jwtService: JwtService,
    private authService: AuthService,
    private prisma: PrismaService,
    private cryptoService: CryptoService
  ) {
    this.cookieSecure = process.env.COOKIE_SECURE === 'true';
  }

  private clearAuthCookies(res: Response): void {
    res.clearCookie('access_token', {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict'
    });
  }

  private shouldRefreshToken(decodedToken: any): boolean {
    const expirationTime = decodedToken.exp * 1000;
    const currentTime = Date.now();
    const timeUntilExpiry = expirationTime - currentTime;
    return timeUntilExpiry < this.refreshThreshold;
  }

  private async silentRefresh(userId: string, res: Response): Promise<void> {
    try {
      await this.authService.refreshToken(userId, res);
    } catch (error) {
      console.error('Erreur lors du rafraîchissement silencieux:', error);
    }
  }

  private async handleSessionExpiration(userId: string, res: Response): Promise<void> {
    // Nettoyage des tokens expirés
    await this.prisma.refreshToken.deleteMany({
      where: { 
        userId,
        OR: [
          { expiresAt: { lt: new Date() } }
        ]
      }
    });
    this.clearAuthCookies(res);
  }

  async use(req: Request, res: Response, next: NextFunction) {
    const accessToken = req.cookies['access_token'];
    
    if (!accessToken) {
      return next();
    }

    try {
      const decodedToken = await this.jwtService.verifyAsync(accessToken);
      if (decodedToken.data && decodedToken.iv) {
        const decryptedPayload = this.cryptoService.decryptPayload(
          decodedToken.data,
          decodedToken.iv
        );
        req['user'] = decryptedPayload;

        // Rafraîchissement proactif
        if (this.shouldRefreshToken(decodedToken)) {
          this.silentRefresh(decryptedPayload.id, res)
            .catch(error => console.error('Erreur lors du rafraîchissement:', error));
        }
        return next();
      }
    } catch (error) {
      try {
        const decodedExpiredToken = this.jwtService.decode(accessToken);
        if (decodedExpiredToken && typeof decodedExpiredToken === 'object' && 'data' in decodedExpiredToken) {
          const decryptedPayload = this.cryptoService.decryptPayload(
            decodedExpiredToken.data,
            decodedExpiredToken.iv
          );

          // Vérifier si un refresh token valide existe
          const validRefreshToken = await this.prisma.refreshToken.findFirst({
            where: {
              userId: decryptedPayload.id,
              expiresAt: { gt: new Date() }
            }
          });

          if (!validRefreshToken) {
            // Session expirée, nettoyer et déconnecter
            await this.handleSessionExpiration(decryptedPayload.id, res);
            return next();
          }

          try {
            // Vérifie si le refresh token est toujours valide
            await this.jwtService.verifyAsync(validRefreshToken.token);
            
            // Mettre à jour req.user et rafraîchir en arrière-plan
            req['user'] = decryptedPayload;
            this.silentRefresh(decryptedPayload.id, res)
              .catch(error => console.error('Erreur lors du rafraîchissement:', error));
            
            return next();
          } catch (tokenError) {
            // Refresh token invalide, nettoyer et déconnecter
            await this.handleSessionExpiration(decryptedPayload.id, res);
            return next();
          }
        }
      } catch (refreshError) {
        this.clearAuthCookies(res);
        return next();
      }
    }
    return next();
  }
}