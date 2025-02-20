import { forwardRef, Module } from '@nestjs/common';
import { UserCompletedExercisesSerieController } from './user-completed-exercises-serie.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [UserCompletedExercisesSerieController],
  providers: [GenericService, PrismaService],
})
export class UserCompletedExercisesSerieModule {}
