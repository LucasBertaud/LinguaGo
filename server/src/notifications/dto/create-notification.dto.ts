import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsString, IsNotEmpty, IsJSON, IsEmpty } from 'class-validator';
import { FrequencyNotification } from '../frequency-notification.enum';

export class CreateNotificationDto {
    @ApiProperty({
        type: 'string',
        example: '1',
        description: 'Id of the user',
    })
    @IsNotEmpty()
    @IsString()
    userId: string;

    @ApiProperty({
        type: 'boolean',
        example: true,
        description: 'Is notification activate',
    })
    @IsNotEmpty()
    @IsBoolean()
    isActivate: boolean;

    @IsNotEmpty()
    @IsString()
    subscription: string;

    @ApiProperty({
        type: 'string',
        example: 'ONE_DAY',
        description: 'Frequency of notification',
        enum: FrequencyNotification,
        nullable: true,
    })
    @IsEmpty()
    frequency?: FrequencyNotification;

    @ApiProperty({
        type: 'string',
        example: '2021-07-20T00:00:00.000Z',
        description: 'Next notification date',
        nullable: true,
    })
    @IsEmpty()
    nextNotification?: Date;

    @ApiProperty({
        type: 'string',
        example: '08:00',
        description: 'Time of notification',
        nullable: true,
    })
    @IsEmpty()
    notificationTime?: string;
}