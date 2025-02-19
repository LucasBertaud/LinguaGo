import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { CreateUserFavoriteSerieDto } from './dto/create-user-favorite-serie.dto';
import { UpdateUserFavoriteSerieDto } from './dto/update-user-favorite-serie.dto';
import { UserFavoriteSerie } from './entities/user-favorite-serie.entity';

@Controller('user-favorite-serie')
export class UserFavoriteSerieController {
  constructor(private readonly genericService: GenericService<UserFavoriteSerie>) {}

  @Post()
  create(@Body() createUserFavoriteSerieDto: CreateUserFavoriteSerieDto) {
    return this.genericService.create("userFavoriteSerie", createUserFavoriteSerieDto);
  }

  @Get()
  findAll() {
    return this.genericService.findAll("userFavoriteSerie", {});
  }

  @Get('user/:userId')
  findAllByUser(@Param('userId') userId: string) {
    return this.genericService.findAll("userFavoriteSerie", {
      where: { 
        userId: String(userId) 
      },
    });
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserFavoriteSerieDto: UpdateUserFavoriteSerieDto) {
    return this.genericService.update("userFavoriteSerie", {
      where: { id: Number(id) },
      data: updateUserFavoriteSerieDto,
    });
  }

  @Delete(':userId/:serieId')
  remove(@Param('userId') userId: string, @Param('serieId') serieId: number) {
    return this.genericService.remove("userFavoriteSerie", {
      where: {
        idUserFavoriteSerie: {
          userId: String(userId),
          serieId: Number(serieId),
        }
      },
    });
  }
}
