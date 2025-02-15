import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { ExercisesSerie } from './entities/exercises-serie.entity';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class ExercisesSerieService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.ExercisesSerieCreateInput): Promise<ExercisesSerie> {
    return this.prisma.exercisesSerie.create({
      data,
    });
  }

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.ExercisesSerieWhereUniqueInput;
    where?: Prisma.ExercisesSerieWhereInput;
    orderBy?: Prisma.ExercisesSerieOrderByWithRelationInput;
  }): Promise<ExercisesSerie[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.exercisesSerie.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async findOne(
    where: Prisma.ExercisesSerieWhereUniqueInput,
  ): Promise<ExercisesSerie | null> {
    return this.prisma.exercisesSerie.findUnique({
      where,
    });
  }

  async update(params: {
    where: Prisma.ExercisesSerieWhereUniqueInput;
    data: Prisma.ExercisesSerieUpdateInput;
  }): Promise<ExercisesSerie> {
    const { where, data } = params;
    return this.prisma.exercisesSerie.update({
      data,
      where,
    });
  }

  async remove(where: Prisma.ExercisesSerieWhereUniqueInput): Promise<ExercisesSerie> {
    return this.prisma.exercisesSerie.delete({
      where,
    });
  }
}
