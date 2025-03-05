import { Injectable, NestMiddleware, UnauthorizedException } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { JwtService } from '@nestjs/jwt';
import { AuthService } from './auth.service';
import { PrismaService } from 'src/utils/prisma.service';
import { CryptoService } from './crypto/crypto.service';

@Injectable()
export class AuthMiddleware implements NestMiddleware {
  private readonly cookieSecure: boolean;

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

    res.clearCookie('user', {
      secure: this.cookieSecure,
      sameSite: 'strict'
    });
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

          // Vérifie si un refresh token valide existe
          const validRefreshToken = await this.prisma.refreshToken.findFirst({
            where: {
              userId: decryptedPayload.id,
              expiresAt: { gt: new Date() }
            }
          });

          if (!validRefreshToken) {
            await this.handleSessionExpiration(decryptedPayload.id, res);
            return next();
          }

          // Set user data first
          req['user'] = decryptedPayload;
          
          // Modifie le token dans les cookies uniquements 
          const newToken = await this.authService.refreshToken(decryptedPayload.id, res);
          
          return next();
        }
      } catch (refreshError) {
        this.clearAuthCookies(res);
      }
    }
    return next();
  }
}