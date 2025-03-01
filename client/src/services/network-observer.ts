import store from "../store";

class NetworkObserver {
    public observe(): void {
        this.bindEvents();
    }

    private bindEvents(): void {
        window.addEventListener('online', () => {
            store.dispatch('initLogin');
            localStorage.removeItem('offline');
            localStorage.removeItem('userOffline');
        });

        window.addEventListener('offline', () => {
            localStorage.setItem('offline', 'true');
            localStorage.setItem('userOffline', JSON.stringify(store.getters.getUser));
        });
    }

    public removeOffline(): void {
        localStorage.removeItem('offline');
        localStorage.removeItem('userOffline');
    }

    public setOffline(): void {
        localStorage.setItem('offline', 'true');
        localStorage.setItem('userOffline', JSON.stringify(store.getters.getUser));
    }

    public isOffline(): boolean {
        return Boolean(localStorage.getItem('offline'));
    }
}

export const networkObserver = new NetworkObserver();