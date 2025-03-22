import { Injectable } from '@nestjs/common';
import * as winston from 'winston';
import { loggerConfig } from './logger.config';

@Injectable()
export class LoggerService {
  private logger: winston.Logger;

  constructor() {
    this.logger = winston.createLogger(loggerConfig);
  }

  error(error: any, context?: string) {
    const errorMessage = error instanceof Error ? error.message : error;
    const stack = error instanceof Error ? error.stack : undefined;

    this.logger.error({
      message: errorMessage,
      context,
      stack
    });
  }
}