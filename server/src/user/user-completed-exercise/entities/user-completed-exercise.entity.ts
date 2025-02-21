export class UserCompletedExercise {
    userId: string;
    exerciseId: string;
    pointsWon: number;
    completedAt: Date;
    _sum: {
        pointsWon: number;
    }
}
