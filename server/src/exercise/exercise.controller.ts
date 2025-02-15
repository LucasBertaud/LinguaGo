import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { CreateExerciseDto } from './dto/create-exercise.dto';
import { UpdateExerciseDto } from './dto/update-exercise.dto';
import { Exercise } from './entities/exercise.entity';
import { GenericService } from 'src/utils/generic.service';
import { Roles } from 'src/role/roles.decorator';
import { Role } from 'src/role/role.enum';
import { AuthGuard } from 'src/auth/auth.guard';
import { RolesGuard } from 'src/role/roles.guard';
import { ApiBearerAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';

@Controller('exercise')
export class ExerciseController {
  constructor(private readonly genericService: GenericService<Exercise>) {}

  @Post()
  @ApiBearerAuth()
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Create a new exercice' })
  @ApiResponse({ status: 200, description: 'The exercice has been successfully created.', type: Exercise })
  @ApiResponse({ status: 400, description: 'Bad Request.' })
  create(@Body() createExerciseDto: CreateExerciseDto) {
    return this.genericService.create("exercise", createExerciseDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all exercices' })
  @ApiResponse({ status: 200, description: 'Return all exercices.', type: [Exercise] })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  findAll() {
    return this.genericService.findAll("exercise", {});
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
  @ApiBearerAuth()
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
  @ApiBearerAuth()
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Delete the exercice' })
  @ApiResponse({ status: 200, description: 'The exercice has been successfully deleted.', type: Exercise })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  remove(@Param('id') id: string) {
    return this.genericService.remove("exercise", { id: Number(id) });
  }
}
