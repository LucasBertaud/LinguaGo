import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { ExercisesSerieModule } from './exercises-serie/exercises-serie.module';
import { ExerciseModule } from './exercise/exercise.module';
import { LevelModule } from './level/level.module';
import { UserCompletedExerciseModule } from './user-completed-exercise/user-completed-exercise.module';
import { UserFavoriteSerieModule } from './user-favorite-serie/user-favorite-serie.module';

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
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}