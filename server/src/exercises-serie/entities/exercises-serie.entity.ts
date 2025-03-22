import { Exercise } from "src/exercise/entities/exercise.entity";

export class ExercisesSerie {
    id: number;
    title: string;
    description?: string;
    exercises: Exercise[];
    levelId: number;
    createdAt: Date;
}
