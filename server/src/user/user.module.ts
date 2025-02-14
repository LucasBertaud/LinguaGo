import { Module, forwardRef } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { PrismaService } from 'src/prisma.service';
import { RolesGuard } from 'src/role/roles.guard';
import { APP_GUARD } from '@nestjs/core';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [forwardRef(() => AuthModule)],
  controllers: [UserController],
  providers: [
    UserService, 
    PrismaService,
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    }
  ],
  exports: [UserService],
})
export class UserModule {}