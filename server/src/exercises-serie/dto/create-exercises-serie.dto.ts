import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty } from 'class-validator';
import { DtoInterface } from 'src/interface/dto.interface';
import { Level } from 'src/level/level.enum';

export class CreateExercisesSerieDto implements DtoInterface {
    @ApiProperty({
        type: 'string',
        example: 'Serie 1',
        description: 'Title of the serie',
    })
    @IsNotEmpty()
    @IsString()
    title: string;
    @ApiProperty({
        type: 'string',
        example: 'This is a description for the series',
        description: 'Description of the serie',
    })
    @IsString()
    description: string | null;
    @ApiProperty({
        type: 'string',
        example: 'A1',
        description: 'Level of the serie',
        enum: ['A1', 'A2', 'B1', 'B2', 'C1'],
    })
    @IsNotEmpty()
    @IsString()
    level: Level;
}
