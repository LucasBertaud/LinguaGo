import { Controller, Get, Param, UseGuards, Request, Query } from '@nestjs/common';
import { ApiCookieAuth, ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { GenericService } from 'src/utils/generic.service';
import { Level } from './entities/level.entity';
import { AuthGuard } from 'src/auth/auth.guard';
import { ExercisesSerieType } from '@prisma/client';

@ApiTags('Levels')
@Controller('level')
export class LevelController {
  constructor(private readonly genericService: GenericService<Level>) { }

  @Get()
  @ApiOperation({ summary: 'Get all levels', description: 'Retrieves all available levels' })
  @ApiResponse({ status: 200, description: 'List of all levels', type: [Level] })
  findAll() {
    return this.genericService.findAll("level", {});
  }

  @Get('favorites')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({
    summary: 'Get user favorites',
    description: 'Retrieves all levels containing series marked as favorites by the authenticated user'
  })
  @ApiResponse({
    status: 200,
    description: 'List of favorite levels with their series and exercises',
    type: [Level]
  })
  @ApiResponse({ status: 401, description: 'Unauthorized' })
  findByFavoritesOfUser(@Request() req) {
    return this.genericService.findAll("level", {
      where: {
        exercisesSeries: {
          some: {
            favoriteUsers: {
              some: {
                userId: String(req.user?.id)
              }
            }
          }
        }
      },
      include: {
        exercisesSeries: {
          include: {
            favoriteUsers: {
              where: { userId: String(req.user?.id) }
            },
            exercises: {
              include: {
                usersCompleted: {
                  where: { userId: String(req.user?.id) }
                },
              }
            }
          },
          where: {
            favoriteUsers: {
              some: {
                userId: String(req.user?.id)
              }
            }
          }
        }
      }
    });
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get level by ID' })
  @ApiParam({ name: 'id', description: 'Level ID', type: 'number' })
  @ApiResponse({ status: 200, description: 'The level', type: Level })
  @ApiResponse({ status: 404, description: 'Level not found' })
  findOne(@Param('id') id: string) {
    return this.genericService.findOne("level", {
      where: { id: Number(id) },
      include: { exercisesSeries: true },
    });
  }

  @Get('title/:title')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({
    summary: 'Get level by title',
    description: 'Retrieves a level by its title including series and exercises with user progress'
  })
  @ApiParam({ name: 'title', description: 'Level title', type: 'string' })
  @ApiResponse({ status: 200, description: 'The level with details', type: Level })
  @ApiResponse({ status: 401, description: 'Unauthorized' })
  @ApiResponse({ status: 404, description: 'Level not found' })
  async findOneByTitle(@Request() req, @Param('title') title: string, @Query('type') type?: string) {
    return await this.genericService.findOne("level", {
      where: { title: String(title) },
      include: {
        exercisesSeries: {
          where: {
            type: type as ExercisesSerieType ?? "DEFAULT"
          },
          include: {
            completedUsers: {
              where: { userId: String(req.user?.id) }
            },
            favoriteUsers: {
              where: { userId: String(req.user?.id) }
            },
            exercises: {
              include: {
                usersCompleted: {
                  where: { userId: String(req.user?.id) }
                },
              }
            }
          }
        }
      }
    });
  }
}
