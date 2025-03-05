import { Controller, Post, Body, HttpCode, HttpStatus, UseGuards, Request, Patch, Res, Get, Req } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './dto/sign-in.dto';
import { AuthGuard } from './auth.guard';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { Response } from 'express';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) { }

  @Post('login')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'User login' })
  @ApiResponse({ status: 200, description: 'User successfully logged in.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  signIn(@Body() signInDto: SignInDto, @Res() res: Response) {
    return this.authService.signIn(signInDto.email, signInDto.password, res);
  }

  @Post('refresh')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Refresh access token' })
  @ApiResponse({ status: 200, description: 'Access token successfully refreshed.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  async refreshToken(@Req() req, @Res() res: Response) {
    await this.authService.refreshToken(req.user.id, res);
    return res.send({ message: 'Token successfully refreshed' });
  }

  @Patch('first-time-connected')
  @UseGuards(AuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'First time connected' })
  @ApiResponse({ status: 200, description: 'First time connected successfully.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  firstTimeConnected(@Request() req) {
    return this.authService.firstTimeConnected(req.user.id);
  }

  @Post('logout')
  @UseGuards(AuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'User logout' })
  @ApiResponse({ status: 200, description: 'User successfully logged out.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  async logout(@Req() req, @Res() res: Response) {
    return this.authService.logout(req.user.id, res);
  }
}