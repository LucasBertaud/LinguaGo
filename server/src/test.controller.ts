import { Controller, Get } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('Health Check')
@Controller('test')
export class TestController {
  @Get()
  @ApiOperation({
    summary: "Vérifier que l'API est active",
    description:
      "Cet endpoint permet de vérifier rapidement si l'API est en ligne. " +
      "Il est utile pour surveiller l'état du service, car en production " +
      "le serveur peut se mettre en veille après une période d'inactivité.",
  })
  @ApiResponse({
    status: 200,
    description: "L'API est active et fonctionne correctement",
    schema: {
      type: 'object',
      properties: {
        status: {
          type: 'string',
          example: 'ok',
          description: "État de l'API",
        },
        message: {
          type: 'string',
          example: 'LinguaGo API is running',
          description: "Message confirmant que l'API est active",
        },
        timestamp: {
          type: 'string',
          example: '2025-03-22T12:34:56.789Z',
          description: 'Horodatage de la requête',
        },
      },
    },
  })
  healthCheck() {
    return {
      status: 'ok',
      message: 'LinguaGo API is running',
      timestamp: new Date().toISOString(),
    };
  }
}
