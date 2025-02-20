import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CreateUserCompletedExercisesSerieDto } from './dto/create-user-completed-exercises-serie.dto';
import { UpdateUserCompletedExercisesSerieDto } from './dto/update-user-completed-exercises-serie.dto';
import { GenericService } from 'src/utils/generic.service';
import { UserCompletedExercisesSerie } from '@prisma/client';

@Controller('user-completed-exercises-serie')
export class UserCompletedExercisesSerieController {
  constructor(private readonly genericService: GenericService<UserCompletedExercisesSerie>) {}

  @Post()
  create(@Body() createUserCompletedExercisesSerieDto: CreateUserCompletedExercisesSerieDto) {
    return this.genericService.create("userCompletedExercisesSerie", createUserCompletedExercisesSerieDto);
  }

  @Get()
  findAll() {
    return this.genericService.findAll("userCompletedExercisesSerie", {});
  }

  @Get(':userId/:serieId')
  findOne(@Param('userId') userId: string, @Param('serieId') serieId: number) {
    return this.genericService.findOne("userCompletedExercisesSerie", {
      where: {
        idUserCompletedExercisesSerie: {
          serieId: serieId,
          userId: userId
        }
      }
    });
  }

  @Patch(':userId/:serieId')
  update(@Param('userId') userId: string, @Param('serieId') serieId: number, @Body() updateUserCompletedExercisesSerieDto: UpdateUserCompletedExercisesSerieDto) {
    return this.genericService.update("userCompletedExercisesSerie", {
      data: updateUserCompletedExercisesSerieDto,
      where: {
        idUserCompletedExercisesSerie: {
          serieId: serieId,
          userId: userId
        }
      }
    });
  }

  @Delete(':userId/:serieId')
  remove(@Param('userId') userId: string, @Param('serieId') serieId: number) {
    return this.genericService.remove("userCompletedExercisesSerie", {
      where: {
        idUserCompletedExercisesSerie: {
          serieId: serieId,
          userId: userId
        }
      }
    });
  }
}
