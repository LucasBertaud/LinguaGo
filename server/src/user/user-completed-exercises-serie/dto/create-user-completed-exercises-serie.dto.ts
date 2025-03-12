import { ApiProperty } from "@nestjs/swagger";
import { IsInt, IsNotEmpty, IsString } from "class-validator";

export class CreateUserCompletedExercisesSerieDto {
    @ApiProperty({
        type: 'string',
        example: '1',
        description: 'Unique identifier of the user who completed the series',
        required: true
    })
    @IsNotEmpty()
    @IsString()
    userId: string;

    @ApiProperty({
        type: 'number',
        example: 1,
        description: 'Unique identifier of the completed exercise series',
        required: true
    })
    @IsNotEmpty()
    @IsInt()
    serieId: number;
}
