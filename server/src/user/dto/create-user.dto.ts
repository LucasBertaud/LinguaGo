import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString, IsNotEmpty, MinLength, Matches } from 'class-validator';

export class CreateUserDto {
  @IsEmail({}, { message: 'L\'adresse email doit être valide.' })
  @ApiProperty({ description: 'The email of the user', example: 'test@gmail.com' })
  email: string;

  @IsString({ message: 'Le mot de passe doit être une chaîne de caractères.' })
  @IsNotEmpty({ message: 'Le mot de passe ne doit pas être vide.' })
  @MinLength(12, { message: 'Le mot de passe doit contenir au moins 12 caractères.' })
  @Matches(/^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{12,}$/, {
    message: 'Le mot de passe doit contenir une majuscule, un chiffre et un symbole.',
  })
  @ApiProperty({ description: 'The password of the user', example: 'Password123!' })
  password: string;
}