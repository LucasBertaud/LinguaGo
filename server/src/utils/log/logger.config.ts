import * as winston from 'winston';
import 'winston-daily-rotate-file';
import * as path from 'path';

const logFormat = winston.format.printf(({ level, message, timestamp, context, stack }) => {
  return `[${timestamp}] ${context}\n${level.toUpperCase()}: ${message}${stack ? `\nStack: ${stack}` : ''}\n----------------------------------------\n`;
});

const transport = new winston.transports.DailyRotateFile({
  filename: path.join(process.cwd(), 'logs', '%DATE%-app.log'),
  datePattern: 'YYYY-MM-DD',
  zippedArchive: true,
  maxSize: '20m',
  maxFiles: '14d'
});

export const loggerConfig = {
  format: winston.format.combine(
    winston.format.timestamp(),
    logFormat
  ),
  transports: [
    transport,
    new winston.transports.Console({
      format: winston.format.combine(
        winston.format.colorize(),
        winston.format.simple()
      )
    })
  ]
};