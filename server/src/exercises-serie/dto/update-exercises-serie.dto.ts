import { PartialType } from '@nestjs/swagger';
import { CreateExercisesSerieDto } from './create-exercises-serie.dto';
import { DtoInterface } from 'src/interface/dto.interface';

export class UpdateExercisesSerieDto extends PartialType(CreateExercisesSerieDto) implements DtoInterface {
    
}
