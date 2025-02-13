import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { UserService } from './user.service';
import { User as UserModel } from '@prisma/client';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { Roles } from 'src/role/roles.decorator';
import { Role } from 'src/role/role.enum';
import { ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}
  
  @Post()
  async create(
    @Body() createUserDto: CreateUserDto,
  ): Promise<UserModel> {
    return this.userService.create(createUserDto);
  }
  
  @Get()
  @Roles(Role.ADMIN)
  async findAll() : Promise<UserModel[]> {
    return this.userService.findAll({});
  }

  @Get(':id')
  @Roles(Role.ADMIN)
  findOne(@Param('id') id: string) : Promise<UserModel | null> {
    return this.userService.findOne({ id: Number(id) });
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @Patch(':id')
  update(@Request() req, @Body() updateUserDto: UpdateUserDto) : Promise<UserModel> {
    return this.userService.update({
      where: { id: Number(req.user?.id) },
      data: updateUserDto,
    });
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @Delete(':id')
  remove(@Request() req) : Promise<UserModel> {
    return this.userService.remove({ id: Number(req.user?.id) });
  }
}
