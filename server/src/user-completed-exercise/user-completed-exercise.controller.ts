import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CreateUserCompletedExerciseDto } from './dto/create-user-completed-exercise.dto';
import { UpdateUserCompletedExerciseDto } from './dto/update-user-completed-exercise.dto';
import { GenericService } from 'src/utils/generic.service';
import { UserCompletedExercise } from './entities/user-completed-exercise.entity';

@Controller('user-completed-exercise')
export class UserCompletedExerciseController {
  constructor(private readonly genericService: GenericService<UserCompletedExercise>) {}

  @Post()
  create(@Body() createUserCompletedExerciseDto: CreateUserCompletedExerciseDto) {
    return this.genericService.create("userCompletedExercise", createUserCompletedExerciseDto);
  }

  @Get()
  findAll() {
    return this.genericService.findAll("userCompletedExercise", {});
  }

  @Get('user/:userId')
  findAllByUser(@Param('userId') userId: string) {
    return this.genericService.findAll("userCompletedExercise", {
      where: { userId: String(userId) },
    });
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserCompletedExerciseDto: UpdateUserCompletedExerciseDto) {
    return this.genericService.update("userCompletedExercise", {
      where: { id: Number(id) },
      data: updateUserCompletedExerciseDto,
    });
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.genericService.remove("userCompletedExercise", { 
      id: Number(id) 
    });
  }
}
