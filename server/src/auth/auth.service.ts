import { Injectable, UnauthorizedException, Res } from '@nestjs/common';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from 'src/utils/prisma.service';
import AuthPayload from 'src/interface/auth-payload.interface';
import { User } from '@prisma/client';
import { Response } from 'express';

@Injectable()
export class AuthService {
  private readonly cookieSecure: boolean;

  constructor(
    private userService: UserService,
    private jwtService: JwtService,
    private prisma: PrismaService,
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

    const access_token = await this.jwtService.signAsync(payload);
    const refresh_token = await this.jwtService.signAsync(payload, { expiresIn: '1d' });

    await this.prisma.refreshToken.create({
      data: {
        token: refresh_token,
        userId: user.id,
        expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000), // 1 jour
      },
    });

    // Supprime les anciennes sessions
    await this.cleanUpOldSessions(user.id);

    // Défini les cookies HTTP-only
    res.cookie('access_token', access_token, {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict',
    });
    res.cookie('refresh_token', refresh_token, {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict',
    });

    res.send({ message: 'User successfully logged in.', payload });
  }

  async getCurrentUser(userId: string): Promise<any> {
    const user = await this.userService.findOne({ id: userId });
    if (!user) {
      throw new UnauthorizedException('Utilisateur non trouvé');
    }

    return {
      user
    };
  }

  async refreshToken(refreshToken: string, @Res() res: Response): Promise<void> {
    if (!refreshToken) {
      throw new UnauthorizedException('Refresh token non fourni');
    }

    const storedToken = await this.prisma.refreshToken.findFirst({
      where: { token: refreshToken },
      include: { user: true },
    });
  
    if (!storedToken || storedToken.expiresAt < new Date()) {
      throw new UnauthorizedException('Le token de rafraîchissement est expiré ou invalide.');
    }

    const payload = { 
      id: storedToken.userId, 
      email: storedToken.user.email, 
      role: storedToken.user.role,
      AuthService: storedToken.user.pseudo,
      firsttimeconnection: storedToken.user.firstTimeConnection
    };
    
    const newAccessToken = await this.jwtService.signAsync(payload);
    const newRefreshToken = await this.jwtService.signAsync(payload, { expiresIn: '1d' });

    await this.prisma.refreshToken.update({
      where: { id: storedToken.id },
      data: {
        token: newRefreshToken,
        expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000),
      },
    });

    res.cookie('access_token', newAccessToken, {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict',
    });
    res.cookie('refresh_token', newRefreshToken, {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict',
    });

    res.send({
      message: 'Token rafraîchi avec succès',
      payload
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

  async logout(refreshToken: string, @Res() res: Response): Promise<void> {
    if (refreshToken) {
      await this.prisma.refreshToken.deleteMany({
        where: { token: refreshToken },
      });
    }

    res.clearCookie('access_token', {
      httpOnly: true,
      secure: this.cookieSecure,
      sameSite: 'strict'
    });

    res.clearCookie('refresh_token', {
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