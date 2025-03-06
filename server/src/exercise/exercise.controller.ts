import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { CreateExerciseDto } from './dto/create-exercise.dto';
import { UpdateExerciseDto } from './dto/update-exercise.dto';
import { Exercise } from './entities/exercise.entity';
import { GenericService } from 'src/utils/generic.service';
import { Roles } from 'src/user/role/roles.decorator';
import { Role } from 'src/user/role/role.enum';
import { AuthGuard } from 'src/auth/auth.guard';
import { RolesGuard } from 'src/user/role/roles.guard';
import { ApiCookieAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';

@Controller('exercise')
export class ExerciseController {
  constructor(private readonly genericService: GenericService<Exercise>) {}

  @Post()
  @ApiCookieAuth('access_token')
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Create a new exercice' })
  @ApiResponse({ status: 200, description: 'The exercice has been successfully created.', type: Exercise })
  @ApiResponse({ status: 400, description: 'Bad Request.' })
  create(@Body() createExerciseDto: CreateExerciseDto) {
    createExerciseDto.answer = createExerciseDto.answer.toLowerCase().replace(/[.,!?;:'"]/g, '').trim();
    return this.genericService.create("exercise", createExerciseDto);
  }

  @Post('multiple')
  @ApiCookieAuth('access_token')
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Create a list of new exercises' })
  @ApiResponse({ status: 200, description: 'The exercices has been successfully created.', type: Exercise })
  @ApiResponse({ status: 400, description: 'Bad Request.' })
  createMultiple(@Body() createExerciseDto: CreateExerciseDto[]) {
    try {
      createExerciseDto.forEach((exercise) => {
        exercise.answer = exercise.answer.toLowerCase().replace(/[.,!?;:'"]/g, '').trim();
      });
      return this.genericService.createMany("exercise", createExerciseDto);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Get()
  @ApiOperation({ summary: 'Get all exercices' })
  @ApiResponse({ status: 200, description: 'Return all exercices.', type: [Exercise] })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  findAll() {
    return this.genericService.findAll("exercise", {});
  }

  @Get('serie/:id')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get all exercices by serie ID' })
  @ApiResponse({ status: 200, description: 'Return all exercices.', type: [Exercise] })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  findBySerieId(@Request() req, @Param('id') id: string) {
    return this.genericService.findAll("exercise", {
      where: { serieId: Number(id) },
      include: {
        usersCompleted: {
          where: { 
            userId: String(req.user?.id) 
          }
        },
        serie: {
          select: {
            level: {
              select: {
                pointsPerExo: true
              }
            },
            completedUsers: {
              where: {
                userId: String(req.user?.id)
              }
            }
          }
        }
      }
    });
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get an exercice by ID' })
  @ApiResponse({ status: 200, description: 'Return the exercice.', type: Exercise })
  @ApiResponse({ status: 404, description: 'Exercice not found.' })
  findOne(@Param('id') id: string) {
    return this.genericService.findOne("exercise", {
      where: { id: Number(id) },
    });
  }

  @Patch(':id')
  @ApiCookieAuth('access_token')
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Update the exercice' })
  @ApiResponse({ status: 200, description: 'The exercice has been successfully updated.', type: Exercise })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  update(@Param('id') id: string, @Body() updateExerciseDto: UpdateExerciseDto) {
    return this.genericService.update("exercise", {
      where: { id: Number(id) },
      data: updateExerciseDto,
    });
  }

  @Delete(':id')
  @ApiCookieAuth('access_token')
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Delete the exercice' })
  @ApiResponse({ status: 200, description: 'The exercice has been successfully deleted.', type: Exercise })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  remove(@Param('id') id: string) {
    return this.genericService.remove("exercise", { 
      where: { id: Number(id) }
     });
  }
}
