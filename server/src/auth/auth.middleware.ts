import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { JwtService } from '@nestjs/jwt';
import { AuthService } from './auth.service';

@Injectable()
export class AuthMiddleware implements NestMiddleware {
  constructor(
    private jwtService: JwtService,
    private authService: AuthService
  ) {}

  async use(req: Request, res: Response, next: NextFunction) {
    const accessToken = req.cookies['access_token'];
    
    if (!accessToken) {
      return next();
    }

    try {
      await this.jwtService.verifyAsync(accessToken);
      next();
    } catch (error) {
      const refreshToken = req.cookies['refresh_token'];
      if (refreshToken) {
        try {
          await this.authService.refreshToken(refreshToken, res);
        } catch (refreshError) {
          next();
        }
      } else {
        next();
      }
    }
  }
}