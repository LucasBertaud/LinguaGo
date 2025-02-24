import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsString, IsNotEmpty, IsJSON } from 'class-validator';

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
    @IsJSON()
    subscription: JSON;
}