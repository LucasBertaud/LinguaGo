import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsNumber } from 'class-validator';

export class CreateExercisesSerieDto {
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
        type: 'number',
        example: 1,
        description: 'Id of the level',
    })
    @IsNotEmpty()
    @IsNumber()
    levelId: number;
}
