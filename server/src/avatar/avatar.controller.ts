import { Controller, Get, NotFoundException, Param } from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { Avatar } from './entities/avatar.entity';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';

@ApiTags('avatar')
@Controller('avatar')
export class AvatarController {
  constructor(private readonly genericService: GenericService<Avatar>) { }

  @Get()
  @ApiOperation({ summary: 'Get all avatars' })
  @ApiResponse({ status: 200, description: 'Return all avatars.' })
  findAll() {
    return this.genericService.findAll("avatar", {
      orderBy: {
        id: 'asc'
      }
    });
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get avatar by id' })
  @ApiParam({ name: 'id', description: 'Avatar ID' })
  @ApiResponse({ status: 200, description: 'Return avatar SVG.' })
  @ApiResponse({ status: 404, description: 'Avatar not found.' })
  async findOne(@Param('id') id: string) {
    const avatar = await this.genericService.findOne("avatar", { where: { id: parseInt(id) } });

    if (!avatar) {
      throw new NotFoundException('Avatar non trouvé');
    }

    return {
      id: avatar.id,
      svg: avatar.svg
    };
  }
}