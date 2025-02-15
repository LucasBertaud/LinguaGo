import { forwardRef, Module } from '@nestjs/common';
import { ExercisesSerieController } from './exercises-serie.controller';
import { PrismaService } from 'src/utils/prisma.service';
import { AuthModule } from 'src/auth/auth.module';
import { GenericService } from 'src/utils/generic.service';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [ExercisesSerieController],
  providers: [
    PrismaService,
    GenericService,
  ],
})
export class ExercisesSerieModule {}
