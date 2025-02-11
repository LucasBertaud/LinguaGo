import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { UserService } from './user.service';
import { User as UserModel } from '@prisma/client';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

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
  async findAll() : Promise<UserModel[]> {
    return this.userService.findAll({});
  }

  @Get(':id')
  findOne(@Param('id') id: string) : Promise<UserModel | null> {
    return this.userService.findOne({ id: Number(id) });
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) : Promise<UserModel> {
    return this.userService.update({
      where: { id: Number(id) },
      data: updateUserDto,
    });
  }

  @Delete(':id')
  remove(@Param('id') id: string) : Promise<UserModel> {
    return this.userService.remove({ id: Number(id) });
  }
}
