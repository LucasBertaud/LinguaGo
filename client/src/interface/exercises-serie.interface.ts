import type Exercise from "./exercise.interface";
import type Level from "./level.interface";
import type UserCompletedExercisesSerie from "./user-completed-exercises-serie.interface";
import type UserFavoriteSerie from "./user-favorite-serie.interface";

export default interface ExercisesSerie {
    id: number;
    title: string;
    description?: string;
    levelId: number;
    createdAt: string;
    exercises: Exercise[];
    favoriteUsers: UserFavoriteSerie[];
    level?: Level;
    completedUsers?: UserCompletedExercisesSerie[];
}
