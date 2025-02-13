import { ApiProperty } from '@nestjs/swagger';

export class UserEntity {
  @ApiProperty({ example: 1, description: 'The unique identifier of the user' })
  id: number;

  @ApiProperty({ example: 'test@gmail.com', description: 'The email of the user' })
  email: string;

  @ApiProperty({ example: 'password123', description: 'The password of the user' })
  password: string;

  @ApiProperty({ example: 'USER', description: 'The role of the user' })
  role: string;

  @ApiProperty({ example: '2023-01-01T00:00:00.000Z', description: 'The date the user was created' })
  createdAt: Date;
}