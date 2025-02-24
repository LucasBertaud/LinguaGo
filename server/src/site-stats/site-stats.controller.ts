import { Controller, Get } from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { SiteStat } from './entities/site-stat.entity';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';

@Controller('site-stats')
export class SiteStatsController {
  constructor(private readonly genericService: GenericService<SiteStat>) {}
  @Get()
  @ApiOperation({ summary: 'Get site stats by unique ID : 1.' })
  @ApiResponse({ status: 200, description: 'Return the site stats.', type: SiteStat })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  findOne() {
    return this.genericService.findOne("SiteStats", {
      where: {
        id: 1
      }
    });
  }
}
