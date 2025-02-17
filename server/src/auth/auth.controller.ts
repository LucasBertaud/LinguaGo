import { Controller, Post, Body, HttpCode, HttpStatus, UseGuards, Request, Patch, Res } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './dto/sign-in.dto';
import { AuthGuard } from './auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { Response } from 'express';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'User login' })
  @ApiResponse({ status: 200, description: 'User successfully logged in.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  signIn(
    @Body() signInDto: SignInDto,
    @Res() res: Response
  ) {
    return this.authService.signIn(signInDto.email, signInDto.password, res);
  }

  @Patch('first-time-connected')
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'First time connected' })
  @ApiResponse({ status: 200, description: 'First time connected successfully.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  firstTimeConnected(
    @Request() req
  ) {
    return this.authService.firstTimeConnected(req.user.id);
  }

  @Post('refresh')
  @ApiOperation({ summary: 'Refresh access token' })
  @ApiResponse({ status: 200, description: 'Access token successfully refreshed.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  refreshToken(
    @Body('refresh_token') refreshToken: string,
    @Res() res: Response
  ) {
    return this.authService.refreshToken(refreshToken, res);
  }

  @Post('logout')
  @ApiOperation({ summary: 'User logout' })
  @ApiResponse({ status: 200, description: 'User successfully logged out.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  async logout(
    @Body('refresh_token') refreshToken: string,
    @Res() res: Response
  ) {
    await this.authService.logout(refreshToken, res);
  }
}