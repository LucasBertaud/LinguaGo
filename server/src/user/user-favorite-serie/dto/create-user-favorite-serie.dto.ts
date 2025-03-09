import { ApiProperty } from "@nestjs/swagger";
import { IsInt, IsNotEmpty, IsString } from "class-validator";

export class CreateUserFavoriteSerieDto {
    @ApiProperty({
        description: "L'identifiant de l'utilisateur",
        example: "550e8400-e29b-41d4-a716-446655440000",
        type: String,
        required: true
    })
    @IsString({ message: "L'identifiant de l'utilisateur doit être une chaîne de caractères." })
    @IsNotEmpty({ message: "L'identifiant de l'utilisateur est requis." })
    userId: string;

    @ApiProperty({
        description: "L'identifiant de la série à mettre en favori",
        example: 1,
        type: Number,
        required: true,
        minimum: 1
    })
    @IsInt({ message: "L'identifiant de la série doit être un nombre entier." })
    @IsNotEmpty({ message: "L'identifiant de la série est requis." })
    serieId: number;
}