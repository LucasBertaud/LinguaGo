import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { ExercisesSerieModule } from './exercises-serie/exercises-serie.module';
import { ExerciseModule } from './exercise/exercise.module';
import { LevelModule } from './level/level.module';
import { UserCompletedExerciseModule } from './user/user-completed-exercise/user-completed-exercise.module';
import { UserFavoriteSerieModule } from './user/user-favorite-serie/user-favorite-serie.module';
import { UserStatsModule } from './user/user-stats/user-stats.module';
import { SiteStatsModule } from './site-stats/site-stats.module';
import { UserCompletedExercisesSerieModule } from './user/user-completed-exercises-serie/user-completed-exercises-serie.module';
import { PushModule } from './notifications/push/push.module';
import { AvatarModule } from './avatar/avatar.module';
import { NotificationModule } from './notifications/notification.module';
import { AuthMiddleware } from './auth/auth.middleware';
import { ScheduleModule } from '@nestjs/schedule';
import { PrismaModule } from './utils/prisma.module';
import { CryptoModule } from './auth/crypto/crypto.module';
import { LoggingInterceptor } from './utils/log/logging.interceptor';
import { LoggerService } from './utils/log/logger.service';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { TestController } from './test.controller';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    ScheduleModule.forRoot(),
    UserModule,
    AuthModule,
    ExercisesSerieModule,
    ExerciseModule,
    LevelModule,
    UserCompletedExerciseModule,
    UserFavoriteSerieModule,
    UserStatsModule,
    SiteStatsModule,
    UserCompletedExercisesSerieModule,
    PushModule,
    AvatarModule,
    NotificationModule,
    PrismaModule,
    CryptoModule,
  ],
  controllers: [TestController],
  providers: [
    LoggerService,
    {
      provide: APP_INTERCEPTOR,
      useClass: LoggingInterceptor,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(AuthMiddleware).forRoutes('*');
  }
}
