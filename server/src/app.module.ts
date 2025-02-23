import { Module } from '@nestjs/common';
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
import { SubscriptionsModule } from './notifications/subscriptions/subscriptions.module';
import { AvatarModule } from './avatar/avatar.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
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
    SubscriptionsModule,
    AvatarModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}