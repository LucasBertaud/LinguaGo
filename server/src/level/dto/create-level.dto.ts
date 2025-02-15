import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsString } from "class-validator";

export class CreateLevelDto {
    @ApiProperty({
        type: 'string',
        example: 'A1',
        description: 'Name of the level',
    })
    @IsNotEmpty()
    @IsString()
    title: string;
    @ApiProperty({
        type: 'string',
        example: 'Débutant',
        description: 'Subtitle of the level',
    })
    @IsNotEmpty()
    @IsString()
    subtitle: string;
    @ApiProperty({
        type: 'string',
        example: 'Ce niveau est destiné aux personnes qui commencent tout juste à apprendre l’anglais. L’accent est mis sur le vocabulaire de base, la grammaire élémentaire et la compréhension de phrases simples. L’objectif est de pouvoir se présenter, poser des questions courantes et comprendre des conversations très basiques.',
        description: 'Description of the level',
    })
    @IsString()
    description?: string;
}
