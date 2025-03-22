/*
  Warnings:

  - Changed the type of `choices` on the `Exercise` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "ExercisesSerieType" AS ENUM ('DEFAULT', 'TALK');

-- AlterEnum
ALTER TYPE "ExerciseType" ADD VALUE 'TALK';

-- AlterTable
ALTER TABLE "Exercise" DROP COLUMN "choices",
ADD COLUMN     "choices" JSONB NOT NULL;

-- AlterTable
ALTER TABLE "ExercisesSerie" ADD COLUMN     "type" "ExercisesSerieType" NOT NULL DEFAULT 'DEFAULT';

-- AlterTable
ALTER TABLE "Notification" ALTER COLUMN "nextNotifyAt" DROP DEFAULT;
