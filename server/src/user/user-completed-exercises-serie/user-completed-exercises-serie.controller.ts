import { Controller, Get, Post, Body, Patch, Param, Delete, Request, UseGuards } from '@nestjs/common';
import { CreateUserCompletedExercisesSerieDto } from './dto/create-user-completed-exercises-serie.dto';
import { UpdateUserCompletedExercisesSerieDto } from './dto/update-user-completed-exercises-serie.dto';
import { GenericService } from 'src/utils/generic.service';
import { AuthGuard } from 'src/auth/auth.guard';
import { ApiBearerAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { UserCompletedExercisesSerie } from './entities/user-completed-exercises-serie.entity';

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

  @Get('user')
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get user completed series.' })
  @ApiResponse({ status: 200, description: 'Return the user completed series.', type: UserCompletedExercisesSerie })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  findAllByUser(@Request() req) {
    return this.genericService.findAll("userCompletedExercisesSerie", {
      where: { 
        userId: String(req.user.id) 
      },
      include: {
        exercisesSerie: {
          include: {
            level: {
              select: {
                title: true
              }
            }
          },
          omit: {
            id: true,
            levelId: true,
            createdAt: true,
            title: true,
            description: true,
          }
        }
      }
    });
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
