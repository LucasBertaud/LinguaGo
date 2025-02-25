import { Injectable } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import { Notification } from '@prisma/client';
import { GenericService } from 'src/utils/generic.service';
import * as webpush from 'web-push';

@Injectable()
export class NotificationService {
    constructor(private readonly genericService: GenericService<Notification>) {}

  @Cron(CronExpression.EVERY_MINUTE, {
    name: 'notifications',
    timeZone: 'Europe/Paris',
  })
  async triggerNotifications() {
    const notifications = await this.genericService.findAll('notification', {
        where: {
            isActivate: true
        }
    });

    notifications.forEach(async (notification) => {
        const subscription = notification.subscription;  // La chaîne JSON
        console.log(subscription)
        const pushSubscription: webpush.PushSubscription = JSON.parse(subscription);

        const payload: string = JSON.stringify({
            title: "LinguaGo",
            body: "Time to practice your language skills!",
        });
        webpush.sendNotification(pushSubscription, payload);
    });
  }
}