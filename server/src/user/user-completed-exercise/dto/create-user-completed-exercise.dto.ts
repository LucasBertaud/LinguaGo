import { ApiProperty } from "@nestjs/swagger";
import { IsInt, IsNotEmpty, IsString } from "class-validator";

export class CreateUserCompletedExerciseDto {
    @ApiProperty({
        type: 'string',
        example: '1',
        description: 'Id of the user',
    })
    @IsNotEmpty()
    @IsString()
    userId: string;

    @ApiProperty({
        type: 'number',
        example: 1,
        description: 'Id of the exercise',
    })
    @IsNotEmpty()
    @IsInt()
    exerciseId: number;
    
    @ApiProperty({
        example: 1,
        description: 'Id of the exercise series'
    })
    @IsNotEmpty()
    @IsInt()
    serieId: number;

    @ApiProperty({
        type: 'number',
        example: 1,
        description: 'Points won by the user',
    })
    @IsNotEmpty()
    @IsInt()
    pointsWon: number;
}