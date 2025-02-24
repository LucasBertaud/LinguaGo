import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { Notification } from '@prisma/client';
import { GenericService } from 'src/utils/generic.service';
import { ApiBearerAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { UpdateNotificationDto } from './dto/update-notification.dto';

@Controller('notification')
export class NotificationController{
    constructor(private readonly genericService: GenericService<Notification>){}

    @Get()
    findAll() {
        return this.genericService.findAll("notification", {});
    }

    @Get('user')
    @ApiBearerAuth()
    @UseGuards(AuthGuard)
    @ApiOperation({ summary: 'Get user notification.' })
    @ApiResponse({ status: 200, description: 'Return the user notification.' })
    @ApiResponse({ status: 401, description: 'Unauthorized.' })
    findOneByUserId(@Request() req) {
        return this.genericService.findOne("notification", {
            where: {
                userId: String(req.user.id)
            }
        })
    }

    @Post()
    @ApiOperation({ summary: 'Create user notification.' })
    @ApiResponse({ status: 200, description: 'Return the user notification.' })
    @ApiResponse({ status: 401, description: 'Unauthorized.' })
    create(@Body() createNotificationDto: CreateNotificationDto) {
        return this.genericService.create("notification", createNotificationDto);
    }

    @Patch()
    @ApiBearerAuth()
    @UseGuards(AuthGuard)
    @ApiOperation({ summary: 'Update user notification.' })
    @ApiResponse({ status: 200, description: 'Return the user notification.' })
    @ApiResponse({ status: 401, description: 'Unauthorized.' })
    update(@Body() updateNotificationDto: UpdateNotificationDto, @Request() req) {
        return this.genericService.update("notification", {
            where: {
                userId: String(req.user.id)
            },
            data: updateNotificationDto
        });
    }
}