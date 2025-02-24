import { $Enums } from "@prisma/client"

export default interface AuthPayload {
    id: string
    email: string
    pseudo: string
    role: $Enums.Role
<<<<<<< HEAD
=======
    firstTimeConnection: boolean
>>>>>>> d783c89a694dac33c9156fcc7b2200c063cf6f4e
    avatarId?: number
}