<<<<<<< HEAD
import { Controller, Post, Body, HttpCode, HttpStatus, UseGuards, Res, Req, Get } from '@nestjs/common';
=======
import { Controller, Post, Body, HttpCode, HttpStatus, UseGuards, Request, Patch, Res, Req, Get } from '@nestjs/common';
>>>>>>> d783c89a694dac33c9156fcc7b2200c063cf6f4e
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
<<<<<<< HEAD
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

=======
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
  
  @Get('me')
  @UseGuards(AuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get current user information' })
  @ApiResponse({ status: 200, description: 'Return current user information.' })
  @ApiResponse({ status: 401, description: 'Unauthorized.' })
  async getCurrentUser(@Req() req) {
    return this.authService.getCurrentUser(req.user.id);
  }

>>>>>>> d783c89a694dac33c9156fcc7b2200c063cf6f4e
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