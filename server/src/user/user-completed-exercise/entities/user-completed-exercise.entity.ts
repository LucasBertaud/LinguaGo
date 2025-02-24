import { ApiProperty } from '@nestjs/swagger';
import { IsDate, IsInt, IsNotEmpty, IsString } from 'class-validator';

export class UserCompletedExercise {
    @ApiProperty({
        example: '1',
        description: 'User identifier'
    })
    @IsNotEmpty()
    @IsString()
    userId: string;

    @ApiProperty({
        example: 1,
        description: 'Exercise identifier'
    })
    @IsNotEmpty()
    @IsInt()
    exerciseId: string;

    @ApiProperty({
        example: 10,
        description: 'Points won for completing the exercise'
    })
    @IsNotEmpty()
    @IsInt()
    pointsWon: number;

    @ApiProperty({
        example: '2024-02-24T14:00:00Z',
        description: 'Date when the exercise was completed'
    })
    @IsDate()
    completedAt: Date;

    @ApiProperty({
        example: { pointsWon: 100 },
        description: 'Aggregated sum of points won'
    })
    _sum: {
        pointsWon: number;
    };
}