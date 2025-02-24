import Database from "../utils/database.utils";
import { serviceWorkerManager } from "./service-worker-manager";

class SubscriberService {
    public async subscribe(): Promise<Object | void> {
        const registration: ServiceWorkerRegistration = await serviceWorkerManager.getRegistration();
        if (!registration) {
            return;
        }
        
        const permission = await Notification.requestPermission();
        if(!permission && permission != "granted") return;

        let sub = await registration.pushManager.getSubscription();
        if (!sub) {
            const response = await Database.getAll("push/key");
            const pubkey = response.pubkey;

            sub = await registration.pushManager.subscribe({
                applicationServerKey: pubkey,
                userVisibleOnly: true,
            });
        }
        
        if(!sub) {
            return;
        }

        const subData = sub.toJSON();
        await Database.create('push/sub', {
            endpoint: subData.endpoint,
            keys: subData.keys,
            expirationTime: subData.expirationTime,
        });

        return subData;
    }
}

export const subscriberService = new SubscriberService();