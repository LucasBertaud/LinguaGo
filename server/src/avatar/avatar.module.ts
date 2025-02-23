import { Module } from '@nestjs/common';
import { AvatarController } from './avatar.controller';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';

@Module({
  controllers: [AvatarController],
  providers: [
    GenericService, 
    PrismaService
  ],
})
export class AvatarModule {}