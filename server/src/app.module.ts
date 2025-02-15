import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { ExercisesSerieModule } from './exercises-serie/exercises-serie.module';
import { ExerciseModule } from './exercise/exercise.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    UserModule,
    AuthModule,
    ExercisesSerieModule,
    ExerciseModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}