import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsNumber, IsOptional } from 'class-validator';

export class UpdateUserDto {
  @IsOptional()
  @IsString({ message: 'Le pseudo doit être une chaîne de caractères.' })
  @IsNotEmpty({ message: 'Le pseudo ne doit pas être vide.' })
  @ApiProperty({ description: 'The pseudo of the user', example: 'user123', required: false })
  pseudo?: string;

  @IsOptional()
  @IsNumber({}, { message: 'L\'avatarId doit être un nombre.' })
  @ApiProperty({ description: 'The avatar ID', example: 1, required: false })
  avatarId?: number;
}