import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
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
    return this.prisma.user.create({
      data: {
        email: data.email,
        password: hash,
      },
    });
  }

  async findOne(userWhereUniqueInput: Prisma.UserWhereUniqueInput): Promise<User | null> {
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
  }): Promise<User[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.user.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async update(params: {
    where: Prisma.UserWhereUniqueInput;
    data: Prisma.UserUpdateInput;
  }): Promise<User> {
    const { where, data } = params;

    const user = await this.prisma.user.findUnique({
      where,
    });

    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé.');
    }

    if (data.email) {
      const existingUser = await this.prisma.user.findUnique({
        where: { email: data.email as string },
      });

      if (existingUser && existingUser.id !== user.id) {
        throw new BadRequestException('Un utilisateur avec cet email existe déjà.');
      }
    }

    const hash: string = await bcrypt.hash(data.password as string, 10);
    return this.prisma.user.update({
      data: {
        email: data.email,
        password: hash,
      },
      where,
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
