import { PartialType } from '@nestjs/swagger';
import { CreateUserCompletedExerciseDto } from './create-user-completed-exercise.dto';

export class UpdateUserCompletedExerciseDto extends PartialType(CreateUserCompletedExerciseDto) {}
