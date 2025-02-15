import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsInt, IsNumber } from 'class-validator';
import { ExerciseType } from '../exercise.enum';

export class CreateExerciseDto {
    @ApiProperty({
        type: 'string',
        example: 'Comment dit-on "Bonjour" en anglais ?',
        description: 'Question of the exercise',
    })
    @IsNotEmpty()
    @IsString()
    question: string;
    @ApiProperty({
        type: 'string',
        example: 'hello',
        description: 'Answer of the exercise',
    })
    @IsNotEmpty()
    @IsString()
    answer: string;
    @ApiProperty({
        type: 'array',
        example: ["Hello", "Goodbye", "Morning", "Hi"],
        description: 'Choices for the exercise',
    })
    @IsNotEmpty()
    @IsString({ each: true })
    choices: string[];
    @ApiProperty({
        type: 'string',
        example: 'MULTIPLE_CHOICE',
        description: 'Type of the exercise',
        enum: ['MULTIPLE_CHOICE', 'TRANSLATION', 'TRUE_FALSE'],
    })
    @IsNotEmpty()
    type: ExerciseType;
    @ApiProperty({
        type: 'number',
        example: 1,
        description: 'Id of the serie',
    })
    @IsNotEmpty()
    @IsNumber()
    serieId: number;
}
