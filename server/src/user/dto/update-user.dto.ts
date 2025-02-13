import { IsEmail, IsString, IsNotEmpty, Length, MinLength, MaxLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateUserDto {
    @IsEmail()
    @MinLength(6)
    @MaxLength(255)
    @ApiProperty({ required: true, minLength: 6, maxLength: 255, example: "test@gmail.com" })
    email: string;

    @IsString()
    @IsNotEmpty()
    @Length(8, 100)
    @ApiProperty({ required: true, minLength: 8, maxLength: 20, example: "password123" })
    password: string;
}