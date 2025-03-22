import { forwardRef, Module } from '@nestjs/common';
import { ExerciseController } from './exercise.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [ExerciseController],
  providers: [PrismaService, GenericService],
})
export class ExerciseModule {}
