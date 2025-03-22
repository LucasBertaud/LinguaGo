import type ExercisesSerie from "./exercises-serie.interface"

export default interface Level {
    id: number
    title: string
    subtitle?: string
    description?: string
    pointsPerExo: number
    winablePoints: number
    exercisesSeries: ExercisesSerie[]
}