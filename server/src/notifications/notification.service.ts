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
    const date = new Date();
    date.setHours(date.getHours() + 1, date.getMinutes(), 0, 0);
    const notifications = await this.genericService.findAll('notification', {
      where: {
        isActivate: true,
        nextNotifyAt: {
          equals: date,
        },
      },
    });

    const payload: string = JSON.stringify({
      title: "Rappel d'apprentissage - LinguaGo",
      content: 'Il est temps de pratiquer vos compétences linguistiques!',
    });

    notifications.forEach(async (notification) => {
      const subscription = notification.subscription;
      const pushSubscription: webpush.PushSubscription =
        JSON.parse(subscription);

      webpush.sendNotification(pushSubscription, payload);

      const nextNotifyAt: Date = await this.updateNextNotifyAt(
        notification.userId,
        notification.frequency,
        notification.notificationTime,
      );

      await this.genericService.update('notification', {
        where: {
          id: notification.id,
        },
        data: {
          nextNotifyAt: nextNotifyAt,
        },
      });
    });
  }

  private frequencyToInt(value: string): number {
    switch (value) {
      case 'TODAY':
        return 0;
      default:
      case 'ONE_DAY':
        return 1;
      case 'TWO_DAYS':
        return 2;
      case 'THREE_DAYS':
        return 3;
      case 'FOUR_DAYS':
        return 4;
      case 'FIVE_DAYS':
        return 5;
      case 'SIX_DAYS':
        return 6;
      case 'SEVEN_DAYS':
        return 7;
    }
  }
  public async updateNextNotifyAt(
    userId: string,
    frequencyDto: string | undefined,
    notificationTimeDto: string | undefined,
  ): Promise<Date> {
    const currentNotification: Notification | null =
      await this.genericService.findOne('notification', {
        where: {
          userId: String(userId),
        },
      });
    if (!currentNotification) {
      throw new Error('Notification not found');
    }

    const frequency: string = frequencyDto || currentNotification.frequency;
    const frequencyNumberOfDay: number = this.frequencyToInt(frequency);

    const notificationTime: string =
      notificationTimeDto || currentNotification.notificationTime;
    const notificationTimeArray: string[] = notificationTime.split(':');
    const notificationHour: number = parseInt(notificationTimeArray[0]);
    const notificationMinute: number = parseInt(notificationTimeArray[1]);

    const date = new Date();
    date.setDate(date.getDate() + frequencyNumberOfDay);
    date.setHours(notificationHour, notificationMinute, 0, 0);

    return date;
  }
}
