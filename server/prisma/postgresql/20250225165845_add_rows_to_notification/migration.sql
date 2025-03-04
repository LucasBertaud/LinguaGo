-- CreateEnum
CREATE TYPE "FrequencyNotification" AS ENUM ('ONE_DAY', 'TWO_DAYS', 'THREE_DAYS', 'FOUR_DAYS', 'FIVE_DAYS', 'SIX_DAYS', 'SEVEN_DAYS');

-- AlterTable
ALTER TABLE "Notification" ADD COLUMN     "frequency" "FrequencyNotification" NOT NULL DEFAULT 'ONE_DAY',
ADD COLUMN     "nextNotifyAt" TIMESTAMP(3) NOT NULL DEFAULT NOW() - interval '1 year',
ADD COLUMN     "notificationTime" TEXT NOT NULL DEFAULT '17:00';
