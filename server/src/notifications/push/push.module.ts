import { Module } from '@nestjs/common';
import { PushController } from './push.controller';
import { SubscriptionsModule } from '../subscriptions/subscriptions.module';

@Module({
    imports: [SubscriptionsModule],
    controllers: [PushController],
})
export class PushModule {}
