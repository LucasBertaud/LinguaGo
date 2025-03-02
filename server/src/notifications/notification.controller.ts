import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request } from '@nestjs/common';
import { Notification } from '@prisma/client';
import { GenericService } from 'src/utils/generic.service';
import { ApiBearerAuth, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { UpdateNotificationDto } from './dto/update-notification.dto';
import { NotificationService } from './notification.service';

@Controller('notification')
export class NotificationController{
    constructor(private readonly genericService: GenericService<Notification>, private readonly notificationService: NotificationService){}

    @Get()
    async findAll() {
        return this.genericService.findAll("notification", {});
    }

    @Get('user')
    @ApiBearerAuth()
    @UseGuards(AuthGuard)
    @ApiOperation({ summary: 'Get user notification.' })
    @ApiResponse({ status: 200, description: 'Return the user notification.' })
    @ApiResponse({ status: 401, description: 'Unauthorized.' })
    async findOneByUserId(@Request() req) {
        return this.genericService.findOne("notification", {
            where: {
                userId: String(req.user.id)
            }
        })
    }

    @Post()
    @ApiBearerAuth()
    @UseGuards(AuthGuard)
    @ApiOperation({ summary: 'Create user notification.' })
    @ApiResponse({ status: 200, description: 'Return the user notification.' })
    @ApiResponse({ status: 401, description: 'Unauthorized.' })
    async create(@Body() createNotificationDto: CreateNotificationDto, @Request() req) {
        try {
            const existingNotification = await this.genericService.findOne("notification", {
                where: {
                    userId: String(req.user.id)
                }
            })
            if (existingNotification) {
                await this.genericService.remove("notification", {
                    where: {
                        userId: String(req.user.id)
                    }
                });
            }
            return this.genericService.create("notification", createNotificationDto);
            
        } catch (error) {
            console.error(error)
        }
    }

    @Patch()
    @ApiBearerAuth()
    @UseGuards(AuthGuard)
    @ApiOperation({ summary: 'Update user notification.' })
    @ApiResponse({ status: 200, description: 'Return the user notification.' })
    @ApiResponse({ status: 401, description: 'Unauthorized.' })
    async update(@Body() updateNotificationDto: UpdateNotificationDto, @Request() req) {
        if(updateNotificationDto.notificationTime || updateNotificationDto.frequency) {
            updateNotificationDto.nextNotifyAt = await this.notificationService.updateNextNotifyAt(String(req.user.id), updateNotificationDto.frequency, updateNotificationDto.notificationTime);
        }
        return this.genericService.update("notification", {
            where: {
                userId: String(req.user.id)
            },
            data: updateNotificationDto
        });
    }
}