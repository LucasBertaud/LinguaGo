import { PartialType } from '@nestjs/swagger';
import { CreateUserCompletedExercisesSerieDto } from './create-user-completed-exercises-serie.dto';

export class UpdateUserCompletedExercisesSerieDto extends PartialType(CreateUserCompletedExercisesSerieDto) {}
