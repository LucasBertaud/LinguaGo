export interface User {
    id: string;
    pseudo: string;
    email: string;
    role: string;
    avatar?: {
        id: number;
        svg: string;
    } | null;
<<<<<<< HEAD
=======
    avatarId?: number | null;
    firstTimeConnection: boolean;
>>>>>>> d783c89a694dac33c9156fcc7b2200c063cf6f4e
}