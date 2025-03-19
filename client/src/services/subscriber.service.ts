import store from "../store";
import { Database } from "../utils/database.utils";
import { serviceWorkerManager } from "./service-worker-manager";
import { SubscriptionInterface } from "../interface/subscription.interface";

class SubscriberService {
  public async subscribe(): Promise<SubscriptionInterface | null> {
    const subscriptionString = await this.getSubscription();
    if (!subscriptionString) return null;

    const subscription: SubscriptionInterface = {
      userId: store.getters.getUser.id,
      isActivate: true,
      subscription: subscriptionString,
    };

    const { data } = await Database.post("notification", subscription);

    return data;
  }

  public async isNotificationBlocked(): Promise<boolean> {
    return Notification.permission === "denied";
  }

  public async getSubscription(): Promise<string | null> {
    const registration: ServiceWorkerRegistration =
      await serviceWorkerManager.getRegistration();
    if (!registration) return null;

    let sub = await registration.pushManager.getSubscription();
    if (!sub) {
      const { data } = await Database.get("push/key");
      const pubkey = data.pubkey;
      try {
        sub = await registration.pushManager.subscribe({
          applicationServerKey: pubkey,
          userVisibleOnly: true,
        });
      } catch (error) {
        console.error("Erreur lors de l'abonnement aux notifications:", error);
      }
    }
    if (!sub) return null;

    const subData = sub.toJSON();
    const stringifySubscription = JSON.stringify(subData);
    return stringifySubscription;
  }
}

export const subscriberService = new SubscriberService();
