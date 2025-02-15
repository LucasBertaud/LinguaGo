/*
  Warnings:

  - You are about to drop the `Levels` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "LevelEnum" AS ENUM ('A1', 'A2', 'B1', 'B2', 'C1');

-- DropForeignKey
ALTER TABLE "ExercisesSerie" DROP CONSTRAINT "ExercisesSerie_levelId_fkey";

-- DropTable
DROP TABLE "Levels";

-- DropEnum
DROP TYPE "Level";

-- CreateTable
CREATE TABLE "Level" (
    "id" SERIAL NOT NULL,
    "title" "LevelEnum" NOT NULL,
    "subtitle" TEXT NOT NULL,
    "description" TEXT,
    "winablePoints" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Level_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ExercisesSerie" ADD CONSTRAINT "ExercisesSerie_levelId_fkey" FOREIGN KEY ("levelId") REFERENCES "Level"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
