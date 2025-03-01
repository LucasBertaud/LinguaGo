import { ExpirationPlugin } from 'workbox-expiration';
import { precacheAndRoute, cleanupOutdatedCaches, createHandlerBoundToURL} from 'workbox-precaching';
import { NavigationRoute, registerRoute } from 'workbox-routing';
import { CacheFirst } from 'workbox-strategies';
import { CacheableResponsePlugin } from 'workbox-cacheable-response/CacheableResponsePlugin';

precacheAndRoute(self.__WB_MANIFEST || []);

cleanupOutdatedCaches();

registerRoute(
    /^https:\/\/fonts\.googleapis\.com\/.*/i,
    new CacheFirst({
        cacheName: "google-fonts-cache",
        plugins: [
            new ExpirationPlugin({maxEntries: 500, maxAgeSeconds: 5184e3}),
            new CacheableResponsePlugin({statuses: [0, 200]})
        ]
    }), "GET");

registerRoute(
    /^https:\/\/fonts\.gstatic\.com\/.*/i, new CacheFirst({
        cacheName: "gstatic-fonts-cache",
        plugins: [
            new ExpirationPlugin({maxEntries: 500, maxAgeSeconds: 5184e3}),
            new CacheableResponsePlugin({statuses: [0, 200]})
        ]
    }), "GET");

registerRoute(
    /.*storage.*/, new CacheFirst({
        cacheName: "dynamic-images-cache",
        plugins: [
            new ExpirationPlugin({maxEntries: 500, maxAgeSeconds: 5184e3}),
            new CacheableResponsePlugin({statuses: [0, 200]})
        ]
    }), "GET");

const handler = createHandlerBoundToURL('/index.html');
const navigationRoute = new NavigationRoute(handler);
registerRoute(navigationRoute);

self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', () => self.clients.claim());

self.addEventListener('push', function (e) {
    if (!(
        self.Notification &&
        self.Notification.permission === 'granted'
    )) return;

    if (e.data) {
        let message = e.data.json();
        e.waitUntil(self.registration.showNotification(message.title, {
            body: message.content,
            icon: import.meta.env.VITE_API_URL + 'icons/192x192.png',
        }));
    }
});