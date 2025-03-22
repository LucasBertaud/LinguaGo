import { Test, TestingModule } from '@nestjs/testing';
import { SiteStatsController } from './site-stats.controller';

describe('SiteStatsController', () => {
  let controller: SiteStatsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SiteStatsController],
      providers: [],
    }).compile();

    controller = module.get<SiteStatsController>(SiteStatsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
