import { Test, TestingModule } from '@nestjs/testing';
import { UserCompletedExercisesSerieController } from './user-completed-exercises-serie.controller';
import { UserCompletedExercisesSerieService } from './user-completed-exercises-serie.service';

describe('UserCompletedExercisesSerieController', () => {
  let controller: UserCompletedExercisesSerieController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UserCompletedExercisesSerieController],
      providers: [UserCompletedExercisesSerieService],
    }).compile();

    controller = module.get<UserCompletedExercisesSerieController>(UserCompletedExercisesSerieController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
