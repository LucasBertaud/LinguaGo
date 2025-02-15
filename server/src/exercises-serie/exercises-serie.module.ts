import { forwardRef, Module } from '@nestjs/common';
import { ExercisesSerieService } from './exercises-serie.service';
import { ExercisesSerieController } from './exercises-serie.controller';
import { PrismaService } from 'src/prisma.service';
import { RolesGuard } from 'src/role/roles.guard';
import { APP_GUARD } from '@nestjs/core';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [ExercisesSerieController],
  providers: [
    ExercisesSerieService,
    PrismaService,
  ],
})
export class ExercisesSerieModule {}
