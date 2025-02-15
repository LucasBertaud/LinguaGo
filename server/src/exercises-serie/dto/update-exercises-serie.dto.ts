import { PartialType } from '@nestjs/swagger';
import { CreateExercisesSerieDto } from './create-exercises-serie.dto';

export class UpdateExercisesSerieDto extends PartialType(CreateExercisesSerieDto) {
    
}
