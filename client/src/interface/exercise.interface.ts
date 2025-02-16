import type UsersCompletedExercise from "./users-completed-exercise.interface";

export default interface Exercise {
    id: number;
    question: string;
    answer: string;
    choices: string[];
    type: string;
    serieId: number;
    usersCompleted: UsersCompletedExercise[];
}