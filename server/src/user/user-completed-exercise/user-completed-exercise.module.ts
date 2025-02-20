import { Module } from '@nestjs/common';
import { UserCompletedExerciseController } from './user-completed-exercise.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';

@Module({
  controllers: [UserCompletedExerciseController],
  providers: [GenericService, PrismaService],
})
export class UserCompletedExerciseModule {}
