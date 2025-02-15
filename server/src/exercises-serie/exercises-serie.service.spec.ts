import { Test, TestingModule } from '@nestjs/testing';
import { ExercisesSerieService } from './exercises-serie.service';

describe('ExercisesSerieService', () => {
  let service: ExercisesSerieService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ExercisesSerieService],
    }).compile();

    service = module.get<ExercisesSerieService>(ExercisesSerieService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
