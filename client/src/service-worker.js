import { precacheAndRoute, cleanupOutdatedCaches } from "workbox-precaching";
import { register } from "./service-worker-register-route";

self.__WB_MANIFEST;

precacheAndRoute(self.__WB_MANIFEST || []);

cleanupOutdatedCaches();

register();

self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", () => self.clients.claim());

self.addEventListener("push", function (e) {
  if (!(self.Notification && self.Notification.permission === "granted"))
    return;

  if (e.data) {
    let message = e.data.json();
    e.waitUntil(
      self.registration.showNotification(message.title, {
        body: message.content,
        icon: self.location.origin + "/icons/icon-192x192.png",
      })
    );
  }
});