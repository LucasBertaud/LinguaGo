import { Test, TestingModule } from '@nestjs/testing';
import { UserFavoriteSerieController } from './user-favorite-serie.controller';
import { UserFavoriteSerieService } from './user-favorite-serie.service';

describe('UserFavoriteSerieController', () => {
  let controller: UserFavoriteSerieController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UserFavoriteSerieController],
      providers: [UserFavoriteSerieService],
    }).compile();

    controller = module.get<UserFavoriteSerieController>(UserFavoriteSerieController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
