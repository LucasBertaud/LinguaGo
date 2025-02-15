import { Test, TestingModule } from '@nestjs/testing';
import { ExercisesSerieController } from './exercises-serie.controller';
import { ExercisesSerieService } from './exercises-serie.service';

describe('ExercisesSerieController', () => {
  let controller: ExercisesSerieController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ExercisesSerieController],
      providers: [ExercisesSerieService],
    }).compile();

    controller = module.get<ExercisesSerieController>(ExercisesSerieController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
