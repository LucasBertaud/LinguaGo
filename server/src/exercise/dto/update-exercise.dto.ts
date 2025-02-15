import { PartialType } from '@nestjs/swagger';
import { CreateExerciseDto } from './create-exercise.dto';
import { DtoInterface } from 'src/interface/dto.interface';

export class UpdateExerciseDto extends PartialType(CreateExerciseDto) implements DtoInterface {}
