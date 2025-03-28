import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/utils/prisma.service';
import { EntityName, PrismaModels } from './prisma.models';

@Injectable()
export class GenericService<T> {
    constructor(private prisma: PrismaService) {}

    async create<X extends EntityName>(
        entityName: string,
        data: PrismaModels[X]['create']
    ): Promise<T> {
        return this.prisma[entityName].create({
            data,
        });
    }

    async createMany<X extends EntityName>(
        entityName: string,
        data: PrismaModels[X]['createMany']
    ): Promise<T> {
        return this.prisma[entityName].createMany({
            data,
        });
    }

    async findAll<X extends EntityName>(
        entityName: string,
        params: {
            skip?: number;
            take?: number;
            cursor?: PrismaModels[X]['cursor'];
            where?: PrismaModels[X]['where'];
            orderBy?: PrismaModels[X]['orderBy'];
            include?: PrismaModels[X]['include'];
        }
    ): Promise<T[]> {
        const { skip, take, cursor, where, orderBy, include } = params;
        return this.prisma[entityName].findMany({
            skip,
            take,
            cursor,
            where,
            orderBy,
            include,
        });
    }

    async groupBy<X extends EntityName>(
        entityName: string,
        params: {
            by: string | string[];
            take?: number;
            _sum?: PrismaModels[X]['_sum'];
            where?: PrismaModels[X]['where'];
            include?: PrismaModels[X]['include'];
            orderBy?: PrismaModels[X]['orderBy'];
        }
    ): Promise<T[] | null> {
        const { by, where, include, orderBy, take, _sum } = params;
        return this.prisma[entityName].groupBy({
            by,
            where,
            include,
            orderBy,
            take,
            _sum
        });
    }

    async findOne<X extends EntityName>(
        entityName: string,
        params: {
            where: PrismaModels[X]['where'];
            include?: PrismaModels[X]['include'];
        },
    ): Promise<T | null> {
        const { where, include } = params;
        return this.prisma[entityName].findUnique({
            where,
            include
        });
    }

    async update<X extends EntityName>(
        entityName: string,
        params: {
            where: PrismaModels[X]['where'];
            data: PrismaModels[X]['update'];
        }
    ): Promise<T> {
        const { where, data } = params;
        return this.prisma[entityName].update({
        data,
        where,
        });
    }

    async remove<X extends EntityName>(
        entityName: string,
        params: {
            where: PrismaModels[X]['where']
        }
    ): Promise<T> {
        const { where } = params;
        return this.prisma[entityName].delete({
            where,
        });
    }
}
