export interface User {
    id: string;
    pseudo: string;
    email: string;
    role: string;
    avatar?: {
        id: number;
        svg: string;
    } | null;
    avatarId?: number | null;
    firstTimeConnection: boolean;
}