import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Req } from '@nestjs/common';
import { CreateExercisesSerieDto } from './dto/create-exercises-serie.dto';
import { UpdateExercisesSerieDto } from './dto/update-exercises-serie.dto';
import { ApiCookieAuth, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/user/role/roles.decorator';
import { Role } from 'src/user/role/role.enum';
import { ExercisesSerie } from './entities/exercises-serie.entity';
import { AuthGuard } from 'src/auth/auth.guard';
import { RolesGuard } from 'src/user/role/roles.guard';
import { GenericService } from 'src/utils/generic.service';

@ApiTags('exercises-serie')
@Controller('exercises-serie')
export class ExercisesSerieController {
  constructor(private readonly genericService: GenericService<ExercisesSerie>) {}

  @Post()
  @ApiCookieAuth('access_token')
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Create a new serie of exercices' })
  @ApiResponse({ status: 200, description: 'The exercices serie has been successfully created.', type: ExercisesSerie })
  @ApiResponse({ status: 400, description: 'Bad Request.' })
  async create(@Body() createExercisesSerieDto: CreateExercisesSerieDto): Promise<ExercisesSerie> {
    return this.genericService.create("exercisesSerie", createExercisesSerieDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all exercices series' })
  @ApiResponse({ status: 200, description: 'Return all exercices series.', type: [ExercisesSerie] })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  async findAll(): Promise<ExercisesSerie[]> {
    return this.genericService.findAll("exercisesSerie", {
      include: {
        exercises: true,
      }
    });
  }

  @Get(':id')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get an exercices serie by ID' })
  @ApiResponse({ status: 200, description: 'Return the exercices serie.', type: ExercisesSerie })
  @ApiResponse({ status: 404, description: 'Exercices serie not found.' })
  findOne(@Param('id') id: string, @Req() request): Promise<ExercisesSerie | null> {
    return this.genericService.findOne("exercisesSerie", { 
      where: { id: Number(id) },
      include: {
        level: true,
        completedUsers: {
          where: {
            userId: String(request.user?.id)
          }
        },
        favoriteUsers: {
          where: {
            userId: String(request.user?.id)
          }
        },
        exercises: true,
      }
    });
  }

  @Patch(':id')
  @ApiCookieAuth('access_token')
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Update the exercices serie' })
  @ApiResponse({ status: 200, description: 'The exercices serie has been successfully updated.', type: ExercisesSerie })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  update(@Param('id') id: string, @Body() updateExercisesSerieDto: UpdateExercisesSerieDto): Promise<ExercisesSerie> {
    return this.genericService.update("exercisesSerie", {
      where: { id: Number(id) },
      data: updateExercisesSerieDto,
    });
  }

  @Delete(':id')
  @ApiCookieAuth('access_token')
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Delete the exercices serie' })
  @ApiResponse({ status: 200, description: 'The exercices serie has been successfully deleted.', type: ExercisesSerie })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  remove(@Param('id') id: string): Promise<ExercisesSerie> {
    return this.genericService.remove("exercisesSerie", {
      where: { id: Number(id) }
    });
  }
}
