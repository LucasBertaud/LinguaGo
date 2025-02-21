export default interface UserStats {
    id: number;
    userId: string;
    points: number;
    successfullExercises: number;
    failedExercises: number;
    completedSeries: number;
    timeSpentOnExercises: number;
    level: string;
}