import { forwardRef, Module } from '@nestjs/common';
import { UserCompletedExerciseController } from './user-completed-exercise.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';
import { AuthModule } from 'src/auth/auth.module';
import { UserService } from '../user.service';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [UserCompletedExerciseController],
  providers: [GenericService, PrismaService, UserService],
})
export class UserCompletedExerciseModule {}
