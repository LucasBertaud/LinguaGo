import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma.service';
import { User, Prisma, Avatar } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { UpdateUserDto } from './dto/update-user.dto';

type UserWithAvatar = User & {
  avatar: Avatar | null;
};

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) { }

  async create(data: Prisma.UserCreateInput): Promise<User> {
    const existingUser = await this.prisma.user.findUnique({
      where: { email: data.email },
    });

    if (existingUser) {
      throw new BadRequestException('Un utilisateur avec cet email existe déjà.');
    }

    const hash: string = await bcrypt.hash(data.password, 10);

    const avatars = await this.prisma.avatar.findMany();

    if (avatars.length === 0) {
      throw new Error('Aucun avatar disponible.');
    }

    // Sélectionne un avatar par défaut au hasard
    const randomAvatar = avatars[Math.floor(Math.random() * avatars.length)];

    const user: User = await this.prisma.user.create({
      data: {
        pseudo: data.pseudo,
        email: data.email,
        password: hash,
        avatarId: randomAvatar.id,
      },
    });

    await this.prisma.userStats.create({
      data: {
        userId: user.id,
      }
    });

    return user;
  }

  async findOne(userWhereUniqueInput: Prisma.UserWhereUniqueInput): Promise<Partial<UserWithAvatar> | null> {
    const user = await this.prisma.user.findUnique({
      where: userWhereUniqueInput,
      omit: {
        password: true,
      },
      include: {
        avatar: true
      }
    });

    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé.');
    }

    return user;
  }

  async findOneForAuth(userWhereUniqueInput: Prisma.UserWhereUniqueInput): Promise<UserWithAvatar> {
    const user = await this.prisma.user.findUnique({
      where: userWhereUniqueInput,
      include: {
        avatar: true
      }
    });

    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé.');
    }

    return user as UserWithAvatar;
  }

  async update(params: {
    where: Prisma.UserWhereUniqueInput;
    data: UpdateUserDto;
  }): Promise<Partial<User>> {
    const { where, data } = params;
  
    const user = await this.prisma.user.findUnique({
      where,
    });
  
    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé.');
    }
  
    if (data.pseudo) {
      const existingPseudo = await this.prisma.user.findFirst({
        where: { pseudo: data.pseudo },
      });
  
      if (existingPseudo && existingPseudo.id !== user.id) {
        throw new BadRequestException('Un utilisateur avec ce pseudo existe déjà.');
      }
    }
  
    return this.prisma.user.update({
      data: {
        ...(data.pseudo && { pseudo: data.pseudo }),
        ...(data.avatarId && { avatarId: data.avatarId }),
      },
      where,
      include: {
        avatar: true
      }
    });
  }
}