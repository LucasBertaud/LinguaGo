import { Role } from 'src/role/role.enum';
import { IsEmail, IsEnum, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateUserDto { 
    @ApiProperty({ required: true, minLength: 6, maxLength: 255, example: "test@gmail.com"})
    @IsEmail()
    email: string;
    @ApiProperty({ required: true, minLength: 8, maxLength: 20, example: "password123" })
    @IsString()
    password: string;
    @ApiProperty({ enum: Role })
    @IsEnum(Role, { message: "Role must be either ADMIN or USER" })
    role: Role;
}