import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { ExercisesSerieModule } from './exercises-serie/exercises-serie.module';
import { ExerciseModule } from './exercise/exercise.module';
import { LevelModule } from './level/level.module';
import { UserCompletedExerciseModule } from './user-completed-exercise/user-completed-exercise.module';
import { AuthMiddleware } from './auth/auth.middleware';

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
  ],
  controllers: [],
  providers: [],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .forRoutes('*');
  }
}