/// <reference lib="webworker" />
declare let self: ServiceWorkerGlobalScope

self.addEventListener("push", e => {
    if (!(
        Notification &&
        Notification.permission === 'granted'
    )) return;

    e.waitUntil(
        self.registration.showNotification('Title', {
            icon: 'Icon URL',
            body: 'Message',
        })
    );
});