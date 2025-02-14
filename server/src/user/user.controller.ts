import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { Roles } from 'src/role/roles.decorator';
import { Role } from 'src/role/role.enum';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { RolesGuard } from 'src/role/roles.guard';
import { UserEntity } from './entities/user.entity';

@ApiTags('users')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}
  
  @Post('/register')
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
  @ApiOperation({ summary: 'Get all users' })
  @ApiResponse({ status: 200, description: 'Return all users.', type: [UserEntity] })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  async findAll(): Promise<UserEntity[]> {
    return this.userService.findAll({});
  }

  @Get(':id')
  @ApiBearerAuth()
  @Roles(Role.ADMIN)
  @UseGuards(AuthGuard, RolesGuard)
  @ApiOperation({ summary: 'Get a user by ID' })
  @ApiResponse({ status: 200, description: 'Return the user.', type: UserEntity })
  @ApiResponse({ status: 404, description: 'User not found.' })
  async findOne(@Param('id') id: string): Promise<UserEntity | null> {
    return this.userService.findOne({ id: Number(id) });
  }

  @Patch()
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Update the authenticated user' })
  @ApiResponse({ status: 200, description: 'The user has been successfully updated.', type: UserEntity })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  update(@Request() req, @Body() updateUserDto: UpdateUserDto): Promise<UserEntity> {
    return this.userService.update({
      where: { id: Number(req.user?.id) },
      data: updateUserDto,
    });
  }

  @Delete()
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Delete the authenticated user' })
  @ApiResponse({ status: 200, description: 'The user has been successfully deleted.', type: UserEntity })
  @ApiResponse({ status: 403, description: 'Forbidden.' })
  remove(@Request() req): Promise<UserEntity> {
    return this.userService.remove({ id: Number(req.user?.id) });
  }
}