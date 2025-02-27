import { ApiProperty, PartialType } from '@nestjs/swagger';
import { CreateNotificationDto } from './create-notification.dto';
import { FrequencyNotification } from '../frequency-notification.enum';
import { IsDate, IsOptional, IsString } from 'class-validator';

export class UpdateNotificationDto extends PartialType(CreateNotificationDto) {
    @ApiProperty({
        type: 'string',
        example: 'ONE_DAY',
        description: 'Frequency of notification',
        enum: FrequencyNotification,
        nullable: true,
    })
    @IsString()
    @IsOptional()
    frequency?: string;

    @IsDate()
    @IsOptional()
    nextNotifyAt?: Date;

    @ApiProperty({
        example: '08:00',
        description: 'Time of notification',
        nullable: true,
    })
    @IsString()
    @IsOptional()
    notificationTime?: string;
}
