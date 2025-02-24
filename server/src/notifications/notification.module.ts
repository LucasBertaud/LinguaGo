import { forwardRef, Module } from '@nestjs/common';
import { GenericService } from 'src/utils/generic.service';
import { PrismaService } from 'src/utils/prisma.service';
import { AuthModule } from 'src/auth/auth.module';
import { NotificationController } from './notification.controller';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [NotificationController],
  providers: [GenericService, PrismaService],
})
export class NotificationModule {}
