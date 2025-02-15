import { ApiProperty } from '@nestjs/swagger';
import { ExerciseType } from "../exercise.enum"

export class Exercise {
    @ApiProperty({ type: 'number', example: 1, description: 'Id of the exercise' })
    id: number
    @ApiProperty({ type: 'string', example: 'Comment dit-on "Bonjour" en anglais ?', description: 'Question of the exercise' })
    question: string
    @ApiProperty({ type: 'string', example: 'hello', description: 'Answer of the exercise' })
    answer: string
    @ApiProperty({ type: 'array', example: ["Hello", "Goodbye", "Morning", "Hi"], description: 'Choices for the exercise' })
    choices: string[]
    @ApiProperty({ type: 'string', example: 'MULTIPLE_CHOICE', description: 'Type of the exercise', enum: ['MULTIPLE_CHOICE', 'TRANSLATION', 'TRUE_FALSE'] })
    type: ExerciseType
    @ApiProperty({ type: 'number', example: 1, description: 'Id of the serie' })
    serieId: number
}
