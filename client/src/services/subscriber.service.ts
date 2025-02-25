import store from "../store";
import Database from "../utils/database.utils";
import { serviceWorkerManager } from "./service-worker-manager";

class SubscriberService {
    public async subscribe(): Promise<any | void> {
        const registration: ServiceWorkerRegistration = await serviceWorkerManager.getRegistration();
        if (!registration) return;
        
        let sub = await registration.pushManager.getSubscription();
        if (!sub) {
            const response = await Database.getAll("push/key");
            const pubkey = response.pubkey;
            try {
                sub = await registration.pushManager.subscribe({
                    applicationServerKey: pubkey,
                    userVisibleOnly: true,
                });
                
            } catch (error) {
                return;
            }
        }
        if(!sub) return;

        const subData = sub.toJSON();
        await Database.create('push/sub', {
            endpoint: subData.endpoint,
            keys: subData.keys,
            expirationTime: subData.expirationTime,
        });

        const stringifySubscription = JSON.stringify(subData);
        const response = await Database.create("notification", {
            userId: store.getters.getUser.id,
            isActivate: true,
            subscription: stringifySubscription
        });

        return response;
    }

    public async isNotificationBlocked(): Promise<boolean> {
        return Notification.permission === "denied";
    }
}

export const subscriberService = new SubscriberService();