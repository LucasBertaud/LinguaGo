import { ApiProperty } from '@nestjs/swagger';
import { Level as LevelEnum } from '../level.enum';

export class Level {
  @ApiProperty({
    example: 1,
    description: 'Unique identifier of the level'
  })
  id: number;

  @ApiProperty({
    example: LevelEnum.A1,
    description: 'Title/difficulty of the level',
    enum: LevelEnum,
    enumName: 'Level'
  })
  title: LevelEnum;

  @ApiProperty({
    example: 'Débutant',
    description: 'Subtitle or level classification'
  })
  subtitle: string;

  @ApiProperty({
    example: 'Parfait pour débuter votre apprentissage',
    description: 'Optional description of the level',
    required: false
  })
  description?: string;

  @ApiProperty({
    example: 100,
    description: 'Total points that can be won in this level',
    default: 0
  })
  winablePoints: number;

  @ApiProperty({
    example: 1,
    description: 'Points awarded per exercise completion',
    default: 1
  })
  pointsPerExo: number;
}