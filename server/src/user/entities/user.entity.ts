import { Role } from 'src/role/role.enum';

export class User {
    id: number;
    email: string;
    password: string;
    role: Role;
    createdAt: Date;
}