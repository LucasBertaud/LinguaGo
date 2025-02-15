import { Module } from '@nestjs/common';
import { LevelController } from './level.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';

@Module({
  controllers: [LevelController],
  providers: [GenericService, PrismaService],
})
export class LevelModule {}
