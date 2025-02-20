import { ApiProperty } from "@nestjs/swagger";
import { IsInt, IsNotEmpty, IsString } from "class-validator";

export class CreateUserFavoriteSerieDto {
    @ApiProperty({
        type: 'string',
        example: '1',
        description: 'Id of the user',
    })
    @IsNotEmpty()
    @IsString()
    userId: string;
    
    @ApiProperty({
        type: 'number',
        example: 1,
        description: 'Id of the serie',
    })
    @IsNotEmpty()
    @IsInt()
    serieId: number;
}
