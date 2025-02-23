import { Controller, Post, Body, HttpCode, HttpStatus, UseGuards, Res, Req, Get } from '@nestjs/common';
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
  signIn(
    @Body() signInDto: SignInDto,
    @Res() res: Response
  ) {
    return this.authService.signIn(signInDto.email, signInDto.password, res);
  }

  @Get('me')
  @UseGuards(AuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get current user information' })
  @ApiResponse({ status: 200, description: 'Return current user information.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  async getCurrentUser(@Req() req) {
    return this.authService.getCurrentUser(req.user.id);
  }

  @Post('refresh')
  @ApiOperation({ summary: 'Refresh access token' })
  @ApiResponse({ status: 200, description: 'Access token successfully refreshed.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  refreshToken(@Req() req, @Res() res: Response) {
    const refreshToken = req.cookies['refresh_token'];
    return this.authService.refreshToken(refreshToken, res);
  }

  @Post('logout')
  @UseGuards(AuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'User logout' })
  @ApiResponse({ status: 200, description: 'User successfully logged out.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  async logout(@Req() req, @Res() res: Response) {
    const refreshToken = req.cookies['refresh_token'];
    return this.authService.logout(refreshToken, res);
  }
}