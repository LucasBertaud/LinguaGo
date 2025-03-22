import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { Request } from 'express';
import { CryptoService } from './crypto/crypto.service';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private jwtService: JwtService,
    private configService: ConfigService,
    private cryptoService: CryptoService
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const token = this.extractTokenFromCookies(request);

    if (!token) {
      throw new UnauthorizedException('Token not found');
    }

    try {
      const tokenPayload = await this.jwtService.verifyAsync(token, {
        secret: this.configService.get<string>('JWT_SECRET'),
        algorithms: ['HS512'],
        issuer: 'LinguaGo',
        audience: 'LinguaGo-client',
      });

      if (!tokenPayload.data || !tokenPayload.iv) {
        throw new UnauthorizedException('Invalid token payload');
      }

      const decryptedPayload = this.cryptoService.decryptPayload(
        tokenPayload.data,
        tokenPayload.iv
      );
      
      request['user'] = decryptedPayload;
      return true;
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }
      throw new UnauthorizedException('Invalid token');
    }
  }

  private extractTokenFromCookies(request: Request): string | undefined {
    return request.cookies['access_token'];
  }
}