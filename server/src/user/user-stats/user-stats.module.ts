import { forwardRef, Module } from '@nestjs/common';
import { UserStatsController } from './user-stats.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [UserStatsController],
  providers: [GenericService, PrismaService],
})
export class UserStatsModule {}
