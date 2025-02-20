import { Module } from '@nestjs/common';
import { SiteStatsController } from './site-stats.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';

@Module({
  controllers: [SiteStatsController],
  providers: [GenericService, PrismaService],
})
export class SiteStatsModule {}
