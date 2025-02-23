import { IsNotEmpty, IsNumber, IsObject, IsOptional, IsString } from "class-validator";

export default class SubscriptionDto {
    @IsString()
    @IsNotEmpty()
    endpoint: string;
    @IsNumber()
    @IsOptional()
    expirationTime: number | null;
    @IsObject()
    @IsNotEmpty()
    keys: { 
        p256dh: string, 
        auth: string 
    };
}