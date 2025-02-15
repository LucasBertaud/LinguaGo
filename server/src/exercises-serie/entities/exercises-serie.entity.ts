import { Exercise } from "src/exercise/entities/exercise.entity";
import { Level } from "src/level/level.enum";

export class ExercisesSerie {
    id: number;
    title: string;
    description?: string;
    level: Level;
    exercises: Exercise[];
    createdAt: Date;
}
