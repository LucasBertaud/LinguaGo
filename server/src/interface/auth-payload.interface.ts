import { $Enums } from "@prisma/client"

export default interface AuthPayload {
    id: string
    email: string
    pseudo: string
    role: $Enums.Role
    avatarId?: number
}