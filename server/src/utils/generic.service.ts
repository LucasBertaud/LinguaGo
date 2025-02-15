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

    async findOne<X extends EntityName>(
        entityName: string,
        where: PrismaModels[X]['where']
    ): Promise<T | null> {
        return this.prisma[entityName].findUnique({
        where,
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
        where: PrismaModels[X]['where']
    ): Promise<T> {
        return this.prisma[entityName].delete({
        where,
        });
    }
}
