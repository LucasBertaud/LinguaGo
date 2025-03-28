import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Request,
  UseGuards,
} from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { CreateUserCompletedExerciseDto } from './dto/create-user-completed-exercise.dto';
import { UpdateUserCompletedExerciseDto } from './dto/update-user-completed-exercise.dto';
import { UserCompletedExercise } from './entities/user-completed-exercise.entity';
import {
  ApiCookieAuth,
  ApiBody,
  ApiOperation,
  ApiParam,
  ApiResponse,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { UserService } from '../user.service';

@Controller('user-completed-exercise')
export class UserCompletedExerciseController {
  constructor(
    private readonly genericService: GenericService<UserCompletedExercise>,
    private readonly userService: UserService,
  ) {}

  @Post()
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Create a completed exercise record' })
  @ApiBody({ type: CreateUserCompletedExerciseDto })
  @ApiResponse({
    status: 201,
    description: 'Record created successfully',
    type: UserCompletedExercise,
  })
  create(
    @Body() createUserCompletedExerciseDto: CreateUserCompletedExerciseDto,
  ) {
    return this.genericService.create(
      'userCompletedExercise',
      createUserCompletedExerciseDto,
    );
  }

  @Get()
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get all completed exercises' })
  @ApiResponse({
    status: 200,
    description: 'List of all completed exercises',
    type: [UserCompletedExercise],
  })
  findAll() {
    return this.genericService.findAll('userCompletedExercise', {});
  }

  @Get('top-users-of-week')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get top 10 users of the week' })
  @ApiResponse({
    status: 200,
    description: 'Top users with their points and avatars',
    schema: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          pseudo: { type: 'string' },
          pointsWon: { type: 'number' },
          avatar: {
            type: 'object',
            properties: {
              svg: { type: 'string' },
              id: { type: 'number' },
            },
          },
        },
      },
    },
  })
  async findAllByTopUsersOfWeek() {
    const response: {
      pseudo: string;
      pointsWon: number;
      avatar:
        | {
            svg: string;
            id: number;
          }
        | undefined;
    }[] = [];

    const UsersCompletedExercises = await this.genericService.groupBy(
      'userCompletedExercise',
      {
        by: ['userId'],
        take: 10,
        where: {
          completedAt: {
            gte: new Date(new Date().getTime() - 8 * 24 * 60 * 60 * 1000),
            lte: new Date(new Date().getTime() - 1 * 24 * 60 * 60 * 1000),
          },
        },
        _sum: {
          pointsWon: true,
        },
        orderBy: {
          _sum: {
            pointsWon: 'desc',
          },
        },
      },
    );

    if (!UsersCompletedExercises) return [];

    for (const UserCompletedExercises of UsersCompletedExercises) {
      const user = await this.userService.findOne({
        id: UserCompletedExercises.userId,
      });

      if (!user) continue;

      response.push({
        pseudo: String(user.pseudo),
        pointsWon: UserCompletedExercises._sum.pointsWon,
        avatar: user.avatar || undefined,
      });
    }

    return response;
  }

  @Get('user/:userId')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get user completed exercises' })
  @ApiParam({ name: 'userId', description: 'User ID' })
  @ApiResponse({
    status: 200,
    description: 'List of user completed exercises',
    type: [UserCompletedExercise],
  })
  findAllByUser(@Param('userId') userId: string) {
    return this.genericService.findAll('userCompletedExercise', {
      where: {
        userId: String(userId),
      },
    });
  }

  @Get('one-week')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({
    summary: 'Get authenticated user completed exercises for last week',
  })
  @ApiResponse({
    status: 200,
    description: 'List of completed exercises',
    type: [UserCompletedExercise],
  })
  @ApiResponse({ status: 401, description: 'Unauthorized' })
  findAllInOneWeek(@Request() req) {
    return this.genericService.findAll('userCompletedExercise', {
      where: {
        userId: String(req.user.id),
        completedAt: {
          gte: new Date(new Date().getTime() - 7 * 24 * 60 * 60 * 1000),
        },
      },
    });
  }

  @Patch(':id')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Update completed exercise record' })
  @ApiParam({ name: 'id', description: 'Record ID' })
  @ApiBody({ type: UpdateUserCompletedExerciseDto })
  @ApiResponse({
    status: 200,
    description: 'Record updated successfully',
    type: UserCompletedExercise,
  })
  update(
    @Param('id') id: string,
    @Body() updateUserCompletedExerciseDto: UpdateUserCompletedExerciseDto,
  ) {
    return this.genericService.update('userCompletedExercise', {
      where: { id: Number(id) },
      data: updateUserCompletedExerciseDto,
    });
  }

  @Delete(':userId/:exerciseId')
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Delete completed exercise record' })
  @ApiParam({ name: 'userId', description: 'User ID' })
  @ApiParam({ name: 'exerciseId', description: 'Exercise ID' })
  @ApiResponse({ status: 200, description: 'Record deleted successfully' })
  async remove(
    @Param('userId') userId: string,
    @Param('exerciseId') exerciseId: number,
  ) {
    const exerciseCompleted = await this.genericService.findOne(
      'userCompletedExercise',
      {
        where: {
          idUserCompletedExercise: {
            userId: String(userId),
            exerciseId: Number(exerciseId),
          },
        },
      },
    );
    if (!exerciseCompleted) return { message: 'Record not found' };
    return this.genericService.remove('userCompletedExercise', {
      where: {
        idUserCompletedExercise: {
          userId: String(userId),
          exerciseId: Number(exerciseId),
        },
      },
    });
  }
}
