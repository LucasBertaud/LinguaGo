import type Exercise from "./exercise.interface";

export default interface ExercisesSerie {
    id: number;
    title: string;
    description?: string;
    levelId: number;
    createdAt: string;
    exercises: Exercise[];
}
