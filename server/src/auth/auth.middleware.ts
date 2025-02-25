import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { JwtService } from '@nestjs/jwt';
import { AuthService } from './auth.service';
import { PrismaService } from 'src/utils/prisma.service';

@Injectable()
export class AuthMiddleware implements NestMiddleware {
  private readonly cookieSecure: boolean;

  constructor(
    private jwtService: JwtService,
    private authService: AuthService,
    private prisma: PrismaService
  ) {
    this.cookieSecure = process.env.COOKIE_SECURE === 'true';
  }

  async use(req: Request, res: Response, next: NextFunction) {
    const accessToken = req.cookies['access_token'];
    
    if (!accessToken) {
      return next();
    }

    try {
      const decodedToken = await this.jwtService.verifyAsync(accessToken);
      req['user'] = decodedToken;
      return next();
    } catch (error) {
      try {
        const decodedExpiredToken = this.jwtService.decode(accessToken);
        if (decodedExpiredToken && typeof decodedExpiredToken === 'object' && 'id' in decodedExpiredToken) {
          // Vérifier si un refresh token valide existe
          const validRefreshToken = await this.prisma.refreshToken.findFirst({
            where: {
              userId: decodedExpiredToken.id,
              expiresAt: { gt: new Date() }
            }
          });

          if (!validRefreshToken) {
            // Supprime tous les refresh tokens de l'utilisateur
            await this.prisma.refreshToken.deleteMany({
              where: { userId: decodedExpiredToken.id }
            });

            // Supprime le cookie access_token
            res.clearCookie('access_token', {
              httpOnly: true,
              secure: this.cookieSecure,
              sameSite: 'strict'
            });

            return next();
          }

          // Si un refresh token valide existe, on rafraîchit
          await this.authService.refreshToken(decodedExpiredToken.id, res);
          return;
        }
      } catch (refreshError) {
        return next();
      }
    }
  }
}