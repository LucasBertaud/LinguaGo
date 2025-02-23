import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { Roles } from 'src/user/role/roles.decorator';
import { Role } from 'src/user/role/role.enum';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { RolesGuard } from 'src/user/role/roles.guard';
import { UserEntity } from './entities/user.entity';
import { UpdateUserAvatarDto } from './dto/update-user-avatar.dto';

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

  @Get()
  @ApiBearerAuth()
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Get all users (Admin)' })
  @ApiResponse({ status: 200, description: 'Return all users.', type: [UserEntity] })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  async findAll(): Promise<Partial<UserEntity>[]> {
    return this.userService.findAll({});
  }

  @Get(':id')
  @ApiBearerAuth()
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Get a user by ID (Admin)' })
  @ApiResponse({ status: 200, description: 'Return the user.', type: UserEntity })
  @ApiResponse({ status: 404, description: 'User not found.' })
  async findOne(
    @Param('id') id: string
  ): Promise<Partial<UserEntity> | null> {
    return this.userService.findOne({ id: String(id) });
  }

  @Patch('update-avatar')
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  async updateAvatar(
    @Request() req,
    @Body() updateUserAvatarDto: UpdateUserAvatarDto
  ): Promise<Partial<UserEntity>> {
    return this.userService.updateAvatar({
      where: { id: String(req.user.id) },
      data: updateUserAvatarDto
    });
  }

  @Patch()
  @ApiBearerAuth()
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

  @Delete()
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Delete the authenticated user' })
  @ApiResponse({ status: 200, description: 'The user has been successfully deleted.', type: UserEntity })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  async remove(
    @Request() req
  ): Promise<UserEntity> {
    return this.userService.remove({ id: String(req.user?.id) });
  }
}