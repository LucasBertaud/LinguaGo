import Exercise from "../interface/exercise.interface";
import Database from "../utils/database.utils";
import { networkObserver } from "./network-observer";
import { methods, OfflineStorageService } from "./offline-storage.service";

export class ExercisesService {
    private pointsPerExo: number;
    constructor(
        private userId: string,
        private serieId: number,
    ){}

    public async fetchExercises (): Promise<Exercise[]> {
        try {
            const response = await Database.getAll(`exercise/serie/${this.serieId}`);
            this.setPointsPerExo(response[0].serie.level.pointsPerExo);
            return response;
        } catch (error) {
            console.error('Erreur lors de la récupération des exercices:', error);
        }
    }

    public setPointsPerExo(points: number): void {
        this.pointsPerExo = points;
    }

    public async markExerciseAsCompleted(currentExercise: Exercise, completedExercises: Exercise[]): Promise<void> {
        const exerciseId = currentExercise.id;

        if (this.findExerciseInCompletedExercises(completedExercises, exerciseId)) {
            // Pas besoin de sauvegarder l'exercise si il est déjà complété en base de données
            return
        };

        if(networkObserver.isOffline()) {
            const data: object = {
                exerciseId: exerciseId,
                userId: this.userId,
                serieId: this.serieId,
                pointsWon: this.pointsPerExo
            }
            OfflineStorageService.store('user-completed-exercise', data, methods.POST);
            return;
        }

        await this.saveExerciseCompleted(exerciseId);
    }

    public async markExerciseAsFailed(currentExercise: Exercise, completedExercises: Exercise[]): Promise<void> {
        const exerciseId = currentExercise.id;

        if(networkObserver.isOffline()) {
            OfflineStorageService.store('user-stats/failed-exercises', {exerciseId: exerciseId}, methods.PATCH);
        } else {
            this.incrementFailedExercises();
        }

        if (!this.findExerciseInCompletedExercises(completedExercises, exerciseId)) {
            // Pas besoin de supprimer l'exercise si il n'est pas complété en base de données
            return
        };

        if(networkObserver.isOffline()) {
            OfflineStorageService.store(`user-completed-exercise/${this.userId}/${exerciseId}`, {}, methods.DELETE);
            return;
        }
        this.removeExerciseCompleted(exerciseId);
    } 

    // Méthodes privées

    private findExerciseInCompletedExercises(completedExercises: Exercise[], exerciseId: number): Exercise {
        return completedExercises.find((exercise) => exercise.id === exerciseId);
    }

    private async saveExerciseCompleted(exerciseId: number): Promise<void> {
        try {
            console.log('saving exercise completed', exerciseId, this.userId, this.serieId, this.pointsPerExo);
            await Database.create('user-completed-exercise', {
                userId: this.userId,
                exerciseId: exerciseId,
                serieId: this.serieId,
                pointsWon: this.pointsPerExo,
            });
        } catch (error) {
            console.error('Erreur lors de l\'enregistrement de la complétion de l\'exercice:', error);
        }
    }

    private async removeExerciseCompleted(exerciseId: number): Promise<void> {
        try {
            await Database.delete(`user-completed-exercise/${this.userId}/${exerciseId}`);
        } catch (error) {
            console.error('Erreur lors de l\'enregistrement de la complétion de l\'exercice:', error);
        }
    }

    private async incrementFailedExercises(): Promise<void> {
        try {
            await Database.patch('user-stats/failed-exercises');
        } catch (error) {
            console.error('Erreur lors de l\'enregistrement de l\'échec de l\'exercice:', error);
        }
    }
}