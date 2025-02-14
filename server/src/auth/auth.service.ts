import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UserService } from 'src/user/user.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
    private prisma: PrismaService,
  ) {}

  async signIn(email: string, pass: string): Promise<{ access_token: string, refresh_token: string }> {
    const user = await this.userService.findOne({ email });
    if (!user) {
      throw new UnauthorizedException();
    }

    const isMatch = await bcrypt.compare(pass, user.password);
    if (!isMatch) {
      throw new UnauthorizedException();
    }

    const payload = { id: user.id, email: user.email };
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

    return {
      access_token,
      refresh_token,
    };
  }

  async refreshToken(refreshToken: string): Promise<{ access_token: string }> {
    const storedToken = await this.prisma.refreshToken.findFirst({
      where: { token: refreshToken },
      include: { user: true },
    });

    if (!storedToken || storedToken.expiresAt < new Date()) {
      throw new UnauthorizedException('Refresh token is expired or invalid');
    }

    const payload = { id: storedToken.userId, email: storedToken.user.email };
    const newAccessToken = await this.jwtService.signAsync(payload);

    return { access_token: newAccessToken };
  }

  async logout(refreshToken: string): Promise<void> {
    await this.prisma.refreshToken.deleteMany({
      where: { token: refreshToken },
    });
  }

  private async cleanUpOldSessions(userId: number): Promise<void> {
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