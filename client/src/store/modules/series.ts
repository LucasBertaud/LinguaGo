import ExercisesSerie from "../../interface/exercises-serie.interface";
import Database from "../../utils/database.utils";

interface ExercisesSerieState {
    exercisesSeries: ExercisesSerie[];
}

const state: ExercisesSerieState = {
    exercisesSeries: [],
};

const mutations = {
    setExercisesSeries(state: ExercisesSerieState, exercisesSeries: ExercisesSerie[]) {
        state.exercisesSeries = exercisesSeries;
    },
    updateExercisesSerie(state: ExercisesSerieState, updatedExercisesSerie: ExercisesSerie) {
        state.exercisesSeries = state.exercisesSeries.map((exercisesSerie) =>
            exercisesSerie.id === updatedExercisesSerie.id ? updatedExercisesSerie : exercisesSerie
        );
    }
}

const getters = {
    getExercisesSeries: (state: ExercisesSerieState) => state.exercisesSeries,
    getExercisesSerieById: (state: ExercisesSerieState) => (id: number) => state.exercisesSeries.find((exercisesSerie) => exercisesSerie.id === id),
}

const actions = {
    async updateSerie({ commit }: any, serieId: number) {
        const serie: ExercisesSerie = await Database.getAll(`exercises-serie/${serieId}`);
        commit('updateExercisesSerie', serie);
    }
}

const series = {
    state,
    mutations,
    actions,
    getters,
  };
  
  export default series;