import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { LoggerService } from './logger.service';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  constructor(private readonly logger: LoggerService) {}

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const req = context.switchToHttp().getRequest();
    const method = req.method;
    const url = req.url;
    const controller = context.getClass().name;
    const handler = context.getHandler().name;

    return next.handle().pipe(
      catchError(error => {
        this.logger.error(
          `${method} ${url} - ${error.message}`,
          `${controller}.${handler}`
        );
        return throwError(() => error);
      }),
    );
  }
}