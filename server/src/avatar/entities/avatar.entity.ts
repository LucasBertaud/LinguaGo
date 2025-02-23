import { UserEntity } from '../../user/entities/user.entity';
import { IsNumber, IsString, IsOptional, IsArray } from 'class-validator';

export class Avatar {
    @IsNumber()
    id: number;

    @IsString()
    svg: string;

    @IsOptional()
    @IsArray()
    users?: UserEntity[];
}