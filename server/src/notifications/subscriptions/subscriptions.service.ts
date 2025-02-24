import { Injectable } from "@nestjs/common";
import SubscriptionDto from "./dto/subscription.dto";

@Injectable()
export class SubscriptionsService {
    private subscriptions: SubscriptionDto[] = [];

    public getSubscriptions() {
        return this.subscriptions;
    }

    public addSubscription(subscriptionDto: SubscriptionDto): boolean {
        const existingSubscription = this.subscriptions.find(sub => 
            JSON.stringify(sub) === JSON.stringify(subscriptionDto)
        );

        if (!existingSubscription) {
            this.subscriptions.push(subscriptionDto);
            return true;
        }
        return false;
    }

    public removeSubscription(subscriptionDto: SubscriptionDto): boolean {
        const existingSubscription = this.subscriptions.find(sub => 
            JSON.stringify(sub) === JSON.stringify(subscriptionDto)
        );
        if (!existingSubscription) return false;

        const index = this.subscriptions.indexOf(existingSubscription);
        if (index >= 0) {
            this.subscriptions.splice(index, 1);
            return true;
        }
    
        return false;
    }
}