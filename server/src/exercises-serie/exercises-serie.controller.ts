import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { ExercisesSerieService } from './exercises-serie.service';
import { CreateExercisesSerieDto } from './dto/create-exercises-serie.dto';
import { UpdateExercisesSerieDto } from './dto/update-exercises-serie.dto';
import { ApiBearerAuth, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/role/roles.decorator';
import { Role } from 'src/role/role.enum';
import { ExercisesSerie } from './entities/exercises-serie.entity';
import { AuthGuard } from 'src/auth/auth.guard';
import { RolesGuard } from 'src/role/roles.guard';

@ApiTags('exercises-serie')
@ApiBearerAuth()
@Roles(Role.ADMIN)
@UseGuards(AuthGuard, RolesGuard)
@Controller('exercises-serie')
export class ExercisesSerieController {
  constructor(private readonly exercisesSerieService: ExercisesSerieService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new serie of exercices' })
  @ApiResponse({ status: 200, description: 'The exercices serie has been successfully created.', type: ExercisesSerie })
  @ApiResponse({ status: 400, description: 'Bad Request.' })
  async create(@Body() createExercisesSerieDto: CreateExercisesSerieDto): Promise<ExercisesSerie> {
    return this.exercisesSerieService.create(createExercisesSerieDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all exercices series' })
  @ApiResponse({ status: 200, description: 'Return all exercices series.', type: [ExercisesSerie] })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  async findAll(): Promise<ExercisesSerie[]> {
    return this.exercisesSerieService.findAll({});
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get an exercices serie by ID' })
  @ApiResponse({ status: 200, description: 'Return the exercices serie.', type: ExercisesSerie })
  @ApiResponse({ status: 404, description: 'Exercices serie not found.' })
  findOne(@Param('id') id: string): Promise<ExercisesSerie | null> {
    return this.exercisesSerieService.findOne({ id: Number(id) });
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update the exercices serie' })
  @ApiResponse({ status: 200, description: 'The exercices serie has been successfully updated.', type: ExercisesSerie })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  update(@Param('id') id: string, @Body() updateExercisesSerieDto: UpdateExercisesSerieDto): Promise<ExercisesSerie> {
    return this.exercisesSerieService.update({
      where: { id: Number(id) },
      data: updateExercisesSerieDto,
    });
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete the exercices serie' })
  @ApiResponse({ status: 200, description: 'The exercices serie has been successfully deleted.', type: ExercisesSerie })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  remove(@Param('id') id: string): Promise<ExercisesSerie> {
    return this.exercisesSerieService.remove({ id: Number(id) });
  }
}
