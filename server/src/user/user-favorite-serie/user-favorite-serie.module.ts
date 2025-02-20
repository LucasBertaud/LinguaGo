import { Module } from '@nestjs/common';
import { UserFavoriteSerieController } from './user-favorite-serie.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';

@Module({
  controllers: [UserFavoriteSerieController],
  providers: [GenericService, PrismaService],
})
export class UserFavoriteSerieModule {}
