import type ExercisesSerie from "./exercises-serie.interface"

export default interface Level {
    id: string
    title: string
    subtitle?: string
    description?: string
    winablePoints: number
    exercisesSeries: ExercisesSerie[]
}