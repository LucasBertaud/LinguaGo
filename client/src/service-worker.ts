/// <reference lib="webworker" />
declare let self: ServiceWorkerGlobalScope

self.addEventListener('push', e => {
    e.waitUntil(push(e));
});

const push = async e => {
    const notification = await e.data.json();
    self.registration.showNotification(notification.title, {
        icon: 'http://localhost:5173/icons/192x192.png',
        body: notification.content,
    });
};