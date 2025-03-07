import ExercisesSerie from "../interface/exercises-serie.interface";

const getCompletedExercisesLength = (serie: ExercisesSerie) => {
    return serie.exercises.filter((exercise) => exercise.usersCompleted.length > 0).length;
  };
  
export const getPercentageCompleted = async (serie: ExercisesSerie) => {
    return (getCompletedExercisesLength(serie) / serie.exercises.length) * 100 || 0;
};