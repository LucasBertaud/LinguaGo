import { Database } from "../utils/database.utils";
import { networkObserver } from "./network-observer";

export const OfflineStorageService = {
    async releaseAllOfflineStorage(): Promise<void> {
        if(networkObserver.isOffline()) return;
        const items = { ...localStorage };
        for(const key in items) {
            if(key.includes('||')) this.save(key);
        }
    },
    async store(path: string, data: object, method: methods): Promise<void> {
        const key = `${path}||${method}`;
        try {
            const storage = JSON.parse(localStorage.getItem(key) || '[]');
            storage.push(data);
            localStorage.setItem(key, JSON.stringify(storage));
        } catch (error) {
            console.error('Erreur lors de l\'enregistrement pour plus tard:', error);
        }  
    },
    async save(key: string): Promise<void> {
        const path = key.split('||')[0];
        const method = key.split('||')[1];
        try {
            const storage = JSON.parse(localStorage.getItem(key) || '[]');
            if(storage.length === 0) return;
            for (const object of storage) {
                await Database[method](path, object);
            }
            localStorage.removeItem(key);
        } catch (error) {
            console.error('Erreur lors de l\'enregistrement depuis le offline storage:', error);
        }
    }
}

export enum methods {
    POST = 'create',
    PATCH = 'patch',
    DELETE = 'delete'
}