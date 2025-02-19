import type ExercisesSerie from "./exercises-serie.interface"

export default interface Level {
    id: number
    title: string
    subtitle?: string
    description?: string
    winablePoints: number
    exercisesSeries: ExercisesSerie[]
}