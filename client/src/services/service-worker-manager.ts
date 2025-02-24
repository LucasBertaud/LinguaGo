import { useRegisterSW } from "virtual:pwa-register/vue";

class ServiceWorkerManager {
    private registration: ServiceWorkerRegistration;
    private promise: Promise<ServiceWorkerRegistration>;

    constructor() {
        this.init();
    }

    private init(): void {
        this.registerServiceWorker();
    }

    public registerServiceWorker(): void {
        this.promise = new Promise((resolve, reject) => {
            useRegisterSW({
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

    public setRegistration(registration: ServiceWorkerRegistration): void {
        this.registration = registration;
    }

    public async getRegistration(): Promise<ServiceWorkerRegistration> {
        return await this.promise.then(_ => this.registration);
    }
}

export const serviceWorkerManager = new ServiceWorkerManager();