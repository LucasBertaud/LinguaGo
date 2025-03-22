import { ApiProperty } from '@nestjs/swagger';
import { IsInt } from 'class-validator';

export class UpdateUserAvatarDto {
  @IsInt()
  @ApiProperty({ description: 'The ID of the avatar' })
  avatarId: number;
}