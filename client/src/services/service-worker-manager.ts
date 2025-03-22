import { useRegisterSW } from "virtual:pwa-register/vue";

class ServiceWorkerManager {
    private registration: ServiceWorkerRegistration;
    private promise: Promise<ServiceWorkerRegistration>;

    public register(): void {
        this.promise = new Promise((resolve, reject) => {
            useRegisterSW({
                immediate: true,
                onRegisteredSW(_, registration: ServiceWorkerRegistration) {
                    resolve(registration);
                    reject("Service Worker registration failed");
                }
            });
        });
        
        this.promise.then((registration) => {
            this.setRegistration(registration as ServiceWorkerRegistration);
        }).catch((error) => {
            console.error(error);
        });
    }

    private setRegistration(registration: ServiceWorkerRegistration): void {
        this.registration = registration;
    }

    public async getRegistration(): Promise<ServiceWorkerRegistration> {
        return await this.promise.then(() => this.registration);
    }
}

export const serviceWorkerManager = new ServiceWorkerManager();