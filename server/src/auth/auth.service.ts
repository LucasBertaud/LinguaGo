import { Injectable, UnauthorizedException, Res } from '@nestjs/common';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from 'src/utils/prisma.service';
import AuthPayload from 'src/interface/auth-payload.interface';
import { User } from '@prisma/client';
import { Response } from 'express';
import { CryptoService } from './crypto/crypto.service';

@Injectable()
export class AuthService {
  private readonly cookieSecure: boolean;

  constructor(
    private userService: UserService,
    private jwtService: JwtService,
    private prisma: PrismaService,
    private cryptoService: CryptoService
  ) {
    this.cookieSecure = process.env.COOKIE_SECURE === 'true';
  }

  async signIn(email: string, pass: string, @Res() res: Response): Promise<void> {
    const user = await this.userService.findOneForAuth({ email });
    if (!user) {
      throw new UnauthorizedException('Adresse email ou mot de passe incorrect.');
    }

    const isMatch = await bcrypt.compare(pass, user.password);
    if (!isMatch) {
      throw new UnauthorizedException('Adresse email ou mot de passe incorrect.');
    }

    const payload: AuthPayload = {
      id: user.id,
      email: user.email,
      role: user.role,
      pseudo: user.pseudo,
      firstTimeConnection: user.firstTimeConnection,
      avatarId: user.avatarId || undefined
    };

    // Utilise le CryptoService pour chiffrer le payload
    const { encryptedData, iv } = this.cryptoService.encryptPayload(payload);
    const tokenPayload = { data: encryptedData, iv };

    const [access_token, refresh_token] = await Promise.all([
      this.jwtService.signAsync(tokenPayload, {
        algorithm: 'HS512',
        issuer: 'LinguaGo',
        audience: 'LinguaGo-client',
      }),
      this.jwtService.signAsync(payload, {
        expiresIn: '1d',
        algorithm: 'HS512'
      })
    ]);

    await this.prisma.refreshToken.create({
      data: {
        token: refresh_token,
        userId: user.id,
        expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000),
      },
    });

    await this.cleanUpOldSessions(user.id);

    res.cookie('access_token', access_token, {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict',
    });

    res.cookie('user', JSON.stringify(payload), {
      secure: this.cookieSecure,
      sameSite: 'strict',
    });

    res.send({ message: 'User successfully logged in.', payload });
  }

  async refreshToken(userId: string, @Res() res: Response): Promise<void> {
    const user = await this.userService.findOne({ id: userId });
    if (!user) {
      throw new UnauthorizedException('User not found');
    }

    const payload = {
      id: user.id,
      email: user.email,
      role: user.role,
      pseudo: user.pseudo,
      firstTimeConnection: user.firstTimeConnection,
      avatarId: user.avatarId || undefined
    };

    const { encryptedData, iv } = this.cryptoService.encryptPayload(payload);
    const tokenPayload = { data: encryptedData, iv };

    const access_token = await this.jwtService.signAsync(tokenPayload, {
      algorithm: 'HS512',
      issuer: 'LinguaGo',
      audience: 'LinguaGo-client',
    });

    res.cookie('access_token', access_token, {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict'
    });

    res.cookie('user', JSON.stringify(payload), {
      secure: this.cookieSecure,
      sameSite: 'strict'
    });
  }

  async firstTimeConnected(userId: string): Promise<User> {
    return await this.prisma.user.update({
      where: {
        id: userId
      },
      data: {
        firstTimeConnection: false
      }
    })
  }

  async logout(userId: string, @Res() res: Response): Promise<void> {
    await this.prisma.refreshToken.deleteMany({
      where: { userId },
    });

    res.clearCookie('access_token', {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict'
    });

    res.clearCookie('user', {
      secure: this.cookieSecure,
      sameSite: 'strict'
    });

    res.send({ message: 'Déconnexion réussie' });
  }

  private async cleanUpOldSessions(userId: string): Promise<void> {
    const sessions = await this.prisma.refreshToken.findMany({
      where: { userId },
      orderBy: { createdAt: 'asc' },
    });

    if (sessions.length > 1) {
      const sessionsToDelete = sessions.slice(0, -1); // Garde la session la plus récente
      const sessionIdsToDelete = sessionsToDelete.map(session => session.id);

      await this.prisma.refreshToken.deleteMany({
        where: { id: { in: sessionIdsToDelete } },
      });
    }
  }
}