import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsString, IsNotEmpty, IsEmpty, IsDate } from 'class-validator';

const notifyInOneDayAndAt17h = new Date();
notifyInOneDayAndAt17h.setDate(notifyInOneDayAndAt17h.getDate() + 1);
notifyInOneDayAndAt17h.setHours(17);

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

    @IsNotEmpty()
    @IsDate()
    nextNotifyAt: Date = notifyInOneDayAndAt17h;
}