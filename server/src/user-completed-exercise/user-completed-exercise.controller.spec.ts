import { Test, TestingModule } from '@nestjs/testing';
import { UserCompletedExerciseController } from './user-completed-exercise.controller';
import { UserCompletedExerciseService } from './user-completed-exercise.service';

describe('UserCompletedExerciseController', () => {
  let controller: UserCompletedExerciseController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UserCompletedExerciseController],
      providers: [UserCompletedExerciseService],
    }).compile();

    controller = module.get<UserCompletedExerciseController>(UserCompletedExerciseController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
