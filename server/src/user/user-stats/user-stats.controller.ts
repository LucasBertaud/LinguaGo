import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { UserStat } from './entities/user-stat.entity';
import { ApiBearerAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';

@Controller('user-stats')
export class UserStatsController {
  constructor(private readonly genericService: GenericService<UserStat>) {}

  @Get()
  findAll() {
    return this.genericService.findAll("userStats", {});
  }

  @Get('/user')
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get user stats.' })
  @ApiResponse({ status: 200, description: 'Return the user stats.', type: UserStat })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  findOneByUserId(@Request() req) {
    return this.genericService.findOne("userStats", {
      where: {
        userId: String(req.user?.id)
      }
    });
  }

  @Patch("/failed-exercises")
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Increment failed exercises on user stats.' })
  @ApiResponse({ status: 200, description: 'Return the user stats.', type: UserStat })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  incrementFailedExercises(@Request() req) {

    return this.genericService.update("userStats", {
      data: {
        failedExercises: {
          increment: 1
        },
      },
      where: {
        userId: String(req.user?.id)
      }
    });
  }

  @Delete()
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Remove user stats.' })
  @ApiResponse({ status: 200, description: 'Return the user stats.', type: UserStat })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  remove(@Request() req) {
    return this.genericService.remove("userStats", {
      where: {
        userId: String(req.user?.id)
      }
    });
  }
}
