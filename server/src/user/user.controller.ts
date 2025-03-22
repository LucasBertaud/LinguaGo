import { Controller, Post, Body, Patch, UseGuards, Request } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { ApiCookieAuth, ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { UserEntity } from './entities/user.entity';

@ApiTags('users')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) { }

  @Post('register')
  @ApiOperation({ summary: 'Register a new user' })
  @ApiResponse({ status: 201, description: 'The user has been successfully created.', type: UserEntity })
  @ApiResponse({ status: 400, description: 'Bad Request.' })
  async create(
    @Body() createUserDto: CreateUserDto,
  ): Promise<UserEntity> {
    return this.userService.create(createUserDto);
  }

  @Patch()
  @ApiCookieAuth('access_token')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Update the authenticated user' })
  @ApiResponse({ status: 200, description: 'The user has been successfully updated.', type: UserEntity })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  async update(
    @Request() req,
    @Body() updateUserDto: UpdateUserDto
  ): Promise<Partial<UserEntity>> {
    return this.userService.update({
      where: { id: String(req.user?.id) },
      data: updateUserDto,
    });
  }
}