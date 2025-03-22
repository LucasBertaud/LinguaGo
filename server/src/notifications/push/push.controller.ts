import { Controller, Get } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';

@Controller('push')
export class PushController {
  constructor() {}

  @Get('key')
  @ApiOperation({ summary: 'Fetch public vapid key.' })
  @ApiResponse({ status: 200, description: 'Return the public vapid key.' })
  getKey() {
    return {
      pubkey: process.env.VAPID_PUBLIC_KEY,
    };
  }
}
