import type ExercisesSerie from "./exercises-serie.interface";

export default interface UserFavoriteSerie {
    userId: string;
    serieId: number;
    createdAt: string;
    serie?: ExercisesSerie;
}