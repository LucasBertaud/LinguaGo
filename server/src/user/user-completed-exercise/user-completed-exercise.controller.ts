import { Controller, Get, Post, Body, Patch, Param, Delete, Request, UseGuards } from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { CreateUserCompletedExerciseDto } from './dto/create-user-completed-exercise.dto';
import { UpdateUserCompletedExerciseDto } from './dto/update-user-completed-exercise.dto';
import { UserCompletedExercise } from './entities/user-completed-exercise.entity';
import { ApiBearerAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { UserService } from '../user.service';

@Controller('user-completed-exercise')
export class UserCompletedExerciseController {
  constructor(private readonly genericService: GenericService<UserCompletedExercise>, private readonly userService: UserService) {}

  @Post()
  create(@Body() createUserCompletedExerciseDto: CreateUserCompletedExerciseDto) {
    return this.genericService.create("userCompletedExercise", createUserCompletedExerciseDto);
  }

  @Get()
  findAll() {
    return this.genericService.findAll("userCompletedExercise", {});
  }

  @Get('top-users-of-week')
  async findAllByTopUsersOfWeek() {
    const response: { pseudo: string; pointsWon: number; }[] = [];

    const UsersCompletedExercises = await this.genericService.groupBy("userCompletedExercise", {
      by: ["userId"],
      take: 10,
      where: {
        completedAt: {
          gte: new Date(new Date().getTime() - 8 * 24 * 60 * 60 * 1000),
          lte: new Date(new Date().getTime() - 1 * 24 * 60 * 60 * 1000),
        }
      },
      _sum: {
        pointsWon: true,
      },
      orderBy: {
        _sum: {
          pointsWon: "desc",
        }
      }
    });

    if(!UsersCompletedExercises) return [];

    for (const UserCompletedExercises of UsersCompletedExercises) {
      const user = await this.userService.findOne({ id: UserCompletedExercises.userId });

      if (!user) continue;

      response.push({
          pseudo: String(user.pseudo),
          pointsWon: UserCompletedExercises._sum.pointsWon,
      });
  }
    
    return response;
  }

  @Get('user/:userId')
  findAllByUser(@Param('userId') userId: string) {
    return this.genericService.findAll("userCompletedExercise", {
      where: { 
        userId: String(userId) 
      },
    });
  }

  @Get('one-week')
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get user completed exercises.' })
  @ApiResponse({ status: 200, description: 'Return the user completed exercises.', type: UserCompletedExercise })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  findAllInOneWeek(@Request() req) {
    return this.genericService.findAll("userCompletedExercise", {
      where: {
        userId: String(req.user.id),
        completedAt: {
          gte: new Date(new Date().getTime() - 7 * 24 * 60 * 60 * 1000),
        }
      }
    })
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserCompletedExerciseDto: UpdateUserCompletedExerciseDto) {
    return this.genericService.update("userCompletedExercise", {
      where: { id: Number(id) },
      data: updateUserCompletedExerciseDto,
    });
  }

  @Delete(':userId/:exerciseId')
  remove(@Param('userId') userId: string, @Param('exerciseId') exerciseId: number) {
    return this.genericService.remove("userCompletedExercise", {
      where: {
        idUserCompletedExercise: {
          userId: String(userId),
          exerciseId: Number(exerciseId),
        }
      },
    });
  }
}
