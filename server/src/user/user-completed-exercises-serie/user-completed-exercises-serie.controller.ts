import { Controller, Get, Post, Body, Patch, Param, Delete, Request, UseGuards } from '@nestjs/common';
import { CreateUserCompletedExercisesSerieDto } from './dto/create-user-completed-exercises-serie.dto';
import { UpdateUserCompletedExercisesSerieDto } from './dto/update-user-completed-exercises-serie.dto';
import { GenericService } from 'src/utils/generic.service';
import { AuthGuard } from 'src/auth/auth.guard';
import {ApiCookieAuth, ApiOperation, ApiResponse, ApiTags} from '@nestjs/swagger';
import { UserCompletedExercisesSerie } from './entities/user-completed-exercises-serie.entity';

@ApiTags('User Completed Exercise Series')
@Controller('user-completed-exercises-serie')
export class UserCompletedExercisesSerieController {
  constructor(private readonly genericService: GenericService<UserCompletedExercisesSerie>) {}

  @Post()
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Create a new user completed exercise series record' })
  @ApiResponse({ status: 201, description: 'Record successfully created', type: UserCompletedExercisesSerie })
  create(@Body() createUserCompletedExercisesSerieDto: CreateUserCompletedExercisesSerieDto) {
    return this.genericService.create("userCompletedExercisesSerie", createUserCompletedExercisesSerieDto);
  }

  @Get()
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get all user completed exercise series records' })
  @ApiResponse({ status: 200, description: 'Returns all records', type: [UserCompletedExercisesSerie] })
  findAll() {
    return this.genericService.findAll("userCompletedExercisesSerie", {});
  }

  @Get('user')
  @ApiCookieAuth('access_token')
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
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get a specific user completed exercise series record' })
  @ApiResponse({ status: 200, description: 'Returns the requested record', type: UserCompletedExercisesSerie })
  @ApiResponse({ status: 404, description: 'Record not found' })
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
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Update a specific user completed exercise series record' })
  @ApiResponse({ status: 200, description: 'Record successfully updated', type: UserCompletedExercisesSerie })
  @ApiResponse({ status: 404, description: 'Record not found' })
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
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Delete a specific user completed exercise series record' })
  @ApiResponse({ status: 200, description: 'Record successfully deleted' })
  @ApiResponse({ status: 404, description: 'Record not found' })
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
