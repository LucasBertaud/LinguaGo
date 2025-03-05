-- AlterEnum
ALTER TYPE "FrequencyNotification" ADD VALUE 'TODAY';

-- AlterTable
ALTER TABLE "Notification" ALTER COLUMN "nextNotifyAt" SET DEFAULT CURRENT_DATE + INTERVAL '1 day' + INTERVAL '17 hours';
