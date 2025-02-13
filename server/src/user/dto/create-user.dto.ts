import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString } from 'class-validator';

export class CreateUserDto {
    @ApiProperty({ required: true, minLength: 6, maxLength: 255, example: "test@gmail.com"})
    @IsEmail()
    email: string;
    @ApiProperty({ required: true, minLength: 8, maxLength: 20, example: "password123" })
    @IsString()
    password: string;
}