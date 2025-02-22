import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma.service';
import { User, Prisma } from '@prisma/client';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.UserCreateInput): Promise<User> {
    const existingUser = await this.prisma.user.findUnique({
      where: { email: data.email },
    });

    if (existingUser) {
      throw new BadRequestException('Un utilisateur avec cet email existe déjà.');
    }

    const hash: string = await bcrypt.hash(data.password, 10);
    const user: User = await this.prisma.user.create({
      data: {
        pseudo: data.pseudo,
        email: data.email,
        password: hash,
      },
    });

    await this.prisma.userStats.create({
      data: {
        userId: user.id,
      }
    });

    return user;
  }

  async findOne(userWhereUniqueInput: Prisma.UserWhereUniqueInput): Promise<Partial<User> | null> {
    const user = await this.prisma.user.findUnique({
      where: userWhereUniqueInput,
      select: {
        pseudo: true,
        role: true,
        email: true,
        createdAt: true,
      },
    });

    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé.');
    }

    return user;
  }

  async findOneForAuth(userWhereUniqueInput: Prisma.UserWhereUniqueInput): Promise<User | null> {
    const user = await this.prisma.user.findUnique({
      where: userWhereUniqueInput,
    });

    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé.');
    }

    return user;
  }

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.UserWhereUniqueInput;
    where?: Prisma.UserWhereInput;
    orderBy?: Prisma.UserOrderByWithRelationInput;
  }): Promise<Partial<User>[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.user.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
      select: {
        pseudo: true,
        role: true,
        email: true,
        createdAt: true,
      },
    });
  }

  async update(params: {
    where: Prisma.UserWhereUniqueInput;
    data: { pseudo: string };
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
        pseudo: data.pseudo,
      },
      where,
      select: {
        pseudo: true,
        role: true,
        email: true,
        createdAt: true,
      },
    });
  }

  async remove(where: Prisma.UserWhereUniqueInput): Promise<User> {
    const user = await this.prisma.user.findUnique({
      where,
    });

    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé.');
    }

    return this.prisma.user.delete({
      where,
    });
  }
}