import type ExercisesSerie from "./exercises-serie.interface";
import type UsersCompletedExercise from "./user-completed-exercise.interface";

export default interface Exercise {
    id: number;
    question: string;
    answer: string;
    choices: string[];
    type: string;
    serieId: number;
    usersCompleted: UsersCompletedExercise[];
    serie?: ExercisesSerie;
}