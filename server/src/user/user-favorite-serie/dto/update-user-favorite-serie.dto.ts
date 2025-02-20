import { PartialType } from '@nestjs/swagger';
import { CreateUserFavoriteSerieDto } from './create-user-favorite-serie.dto';

export class UpdateUserFavoriteSerieDto extends PartialType(CreateUserFavoriteSerieDto) {}
