import { Controller, Get, Post, Body, Param, Delete, Request } from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { CreateUserFavoriteSerieDto } from './dto/create-user-favorite-serie.dto';
import { UserFavoriteSerie } from './entities/user-favorite-serie.entity';
import { ApiOperation, ApiResponse, ApiParam, ApiCookieAuth, ApiBody } from '@nestjs/swagger';

@Controller('user-favorite-serie')
export class UserFavoriteSerieController {
  constructor(
    private readonly genericService: GenericService<UserFavoriteSerie>
  ) { }

  @Post()
  @ApiCookieAuth('access_token')
  @ApiOperation({
    summary: 'Ajouter une série aux favoris',
    description: 'Permet à l\'utilisateur authentifié d\'ajouter une série à ses favoris'
  })
  @ApiBody({ type: CreateUserFavoriteSerieDto })
  @ApiResponse({
    status: 201,
    description: 'Série ajoutée aux favoris avec succès',
    type: UserFavoriteSerie
  })
  @ApiResponse({ status: 400, description: 'Données invalides fournies' })
  @ApiResponse({ status: 401, description: 'Non authentifié' })
  async create(@Request() req, @Body() createUserFavoriteSerieDto: CreateUserFavoriteSerieDto) {
    createUserFavoriteSerieDto.userId = req.user.id;
    return await this.genericService.create("userFavoriteSerie", createUserFavoriteSerieDto);
  }

  @Get('user/:userId')
  @ApiCookieAuth('access_token')
  @ApiOperation({
    summary: 'Récupérer les séries favorites d\'un utilisateur',
    description: 'Récupère toutes les séries favorites avec leurs exercices et niveaux pour l\'utilisateur spécifié'
  })
  @ApiParam({
    name: 'userId',
    description: 'Identifiant unique de l\'utilisateur',
    type: 'string'
  })
  @ApiResponse({
    status: 200,
    description: 'Liste des séries favorites avec détails',
    type: [UserFavoriteSerie]
  })
  @ApiResponse({ status: 401, description: 'Non authentifié' })
  @ApiResponse({ status: 403, description: 'Accès non autorisé' })
  async findAllByUser(@Request() req, @Param('userId') userId: string) {
    if (req.user.id !== userId) {
      throw new Error('Non autorisé à accéder aux favoris d\'un autre utilisateur');
    }

    return await this.genericService.findAll("userFavoriteSerie", {
      where: {
        userId: String(userId)
      },
      include: {
        serie: {
          include: {
            exercises: {
              include: {
                usersCompleted: {
                  where: {
                    userId: String(userId)
                  }
                }
              }
            },
            level: true
          }
        }
      }
    });
  }

  @Delete(':userId/:serieId')
  @ApiCookieAuth('access_token')
  @ApiOperation({
    summary: 'Supprimer une série des favoris',
    description: 'Permet à l\'utilisateur authentifié de retirer une série de ses favoris'
  })
  @ApiParam({
    name: 'userId',
    description: 'Identifiant unique de l\'utilisateur',
    type: 'string'
  })
  @ApiParam({
    name: 'serieId',
    description: 'Identifiant de la série',
    type: 'number'
  })
  @ApiResponse({ status: 200, description: 'Série supprimée des favoris avec succès' })
  @ApiResponse({ status: 401, description: 'Non authentifié' })
  @ApiResponse({ status: 403, description: 'Accès non autorisé' })
  async remove(@Request() req, @Param('userId') userId: string, @Param('serieId') serieId: number) {
    if (req.user.id !== userId) {
      throw new Error('Non autorisé à supprimer les favoris d\'un autre utilisateur');
    }

    return await this.genericService.remove("userFavoriteSerie", {
      where: {
        idUserFavoriteSerie: {
          userId: String(userId),
          serieId: Number(serieId),
        }
      },
    });
  }
}