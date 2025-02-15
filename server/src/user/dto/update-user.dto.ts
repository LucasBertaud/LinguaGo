import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString, IsNotEmpty, MinLength, Matches } from 'class-validator';

export class UpdateUserDto {
  @IsString({ message: 'Le pseudo doit être une chaîne de caractères.' })
  @IsNotEmpty({ message: 'Le pseudo ne doit pas être vide.' })
  @ApiProperty({ description: 'The pseudo of the user', example: 'user123' })
  pseudo: string;
}