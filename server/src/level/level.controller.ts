import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CreateLevelDto } from './dto/create-level.dto';
import { UpdateLevelDto } from './dto/update-level.dto';
import { GenericService } from 'src/utils/generic.service';
import { Level } from './entities/level.entity';

@Controller('level')
export class LevelController {
  constructor(private readonly genericService: GenericService<Level>) {}

  @Post()
  create(@Body() createLevelDto: CreateLevelDto) {
    return this.genericService.create("level", createLevelDto);
  }

  @Get()
  findAll() {
    return this.genericService.findAll("level", {
      include: { exercisesSeries: true },
    });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.genericService.findOne("level", {
      where: { id: Number(id) },
      include: { exercisesSeries: true },
    });
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateLevelDto: UpdateLevelDto) {
    return this.genericService.update("level", {
      where: { id: Number(id) },
      data: updateLevelDto,
    });
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.genericService.remove("level", { id: Number(id) });
  }
}
