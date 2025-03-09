import { NavigationRoute, registerRoute } from 'workbox-routing';
import { CacheFirst, NetworkFirst, StaleWhileRevalidate } from 'workbox-strategies';
import { CacheableResponsePlugin } from 'workbox-cacheable-response/CacheableResponsePlugin';
import { createHandlerBoundToURL} from 'workbox-precaching';
import { ExpirationPlugin } from 'workbox-expiration';
const API_URL = import.meta.env.VITE_API_URL;

export const register = () => {
    registerRoute(
        /^https:\/\/fonts\.googleapis\.com\/.*/i,
        new CacheFirst({
            cacheName: "google-fonts-cache",
            plugins: [
                new ExpirationPlugin({maxEntries: 500, maxAgeSeconds: 5184e3}),
                new CacheableResponsePlugin({statuses: [0, 200]})
            ]
        }), 
    "GET");
    
    registerRoute(
        /^https:\/\/fonts\.gstatic\.com\/.*/i, new CacheFirst({
            cacheName: "gstatic-fonts-cache",
            plugins: [
                new ExpirationPlugin({maxEntries: 500, maxAgeSeconds: 5184e3}),
                new CacheableResponsePlugin({statuses: [0, 200]})
            ]
        }), 
    "GET");
    
    registerRoute(
        /.*storage.*/, new CacheFirst({
            cacheName: "dynamic-images-cache",
            plugins: [
                new ExpirationPlugin({maxEntries: 500, maxAgeSeconds: 5184e3}),
                new CacheableResponsePlugin({statuses: [0, 200]})
            ]
        }),
    "GET");
    
    registerRoute(
        ({ url }) =>
          url.origin === API_URL && url.pathname.startsWith('/level/favorites'),
        new NetworkFirst({
          cacheName: 'user-favorites-series-cache',
          plugins: [
            new CacheableResponsePlugin({ statuses: [200] }),
            new ExpirationPlugin({
              maxEntries: 50,
              maxAgeSeconds: 60 * 60 * 24,
            }),
          ],
        })
    );
    
    registerRoute(
      ({ url }) =>
        url.origin === self.location.origin && url.pathname.startsWith('/assets/images/icons'),
      new StaleWhileRevalidate({
        cacheName: 'icons-cache',
        plugins: [
          new CacheableResponsePlugin({
            statuses: [200],
          }),
          new ExpirationPlugin({
            maxEntries: 100,
            maxAgeSeconds: 60 * 60 * 24 * 30,
          }),
        ],
      }),
    "GET");

    registerRoute(
        ({ url }) =>
          url.origin === API_URL && url.pathname.startsWith('/avatar'),
        new CacheFirst({
          cacheName: 'user-avatar-cache',
          plugins: [
            new CacheableResponsePlugin({ statuses: [200] }),
            new ExpirationPlugin({
              maxEntries: 50,
              maxAgeSeconds: 60 * 60 * 24,
            }),
          ],
        })
    );

    registerRoute(
        ({ url }) =>
          url.origin === API_URL && url.pathname.startsWith('/exercise/serie'),
        new NetworkFirst({
          cacheName: 'exercises-cache',
          plugins: [
            new CacheableResponsePlugin({ statuses: [200] }),
            new ExpirationPlugin({
              maxEntries: 500,
              maxAgeSeconds: 60 * 60 * 24 * 30,
            }),
          ],
        })
    );

    if(self.location.host.includes('5173')) return;
    const handler = createHandlerBoundToURL('/index.html');
    const navigationRoute = new NavigationRoute(handler);
    registerRoute(navigationRoute);
}