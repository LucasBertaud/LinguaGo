import { Body, Controller, Get, Post } from "@nestjs/common";
import { SubscriptionsService } from "../subscriptions/subscriptions.service";
import SubscriptionDto from "../subscriptions/dto/subscription.dto";

@Controller('push')
export class PushController {
    constructor(private readonly subscriptionsService: SubscriptionsService){}

    @Get('key')
    getKey() {
        return {
            pubkey: process.env.VAPID_PUBLIC_KEY,
         };
    }

    @Post('sub')
    subscribe(@Body() subscriptionDto: SubscriptionDto) {
        this.subscriptionsService.addSubscription(subscriptionDto);
        return { message: 'subscribed' };
    }
}