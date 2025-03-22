-- AlterTable
ALTER TABLE "Notification" ALTER COLUMN "subscription" SET DATA TYPE TEXT,
ALTER COLUMN "nextNotifyAt" SET DEFAULT NOW() - interval '1 year';
