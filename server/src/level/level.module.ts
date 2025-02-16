import { forwardRef, Module } from '@nestjs/common';
import { LevelController } from './level.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [LevelController],
  providers: [
    GenericService, 
    PrismaService
  ],
})
export class LevelModule {}
