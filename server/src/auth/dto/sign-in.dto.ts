import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString, IsNotEmpty, MinLength, MaxLength, Length } from 'class-validator';

export class SignInDto {
  @IsEmail()
  @MinLength(6)
  @MaxLength(255)
  @ApiProperty({ description: 'The email of the user', example: 'test@gmail.com' })
  email: string;

  @IsString()
  @IsNotEmpty()
  @Length(8, 100)
  @ApiProperty({ description: 'The password of the user', example: 'password123' })
  password: string;
}