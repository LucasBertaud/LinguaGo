/*
  Warnings:

  - You are about to drop the column `level` on the `ExercisesSerie` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "ExercisesSerie" DROP COLUMN "level",
ADD COLUMN     "levelId" INTEGER NOT NULL DEFAULT 1;

-- CreateTable
CREATE TABLE "Levels" (
    "id" SERIAL NOT NULL,
    "title" "Level" NOT NULL,
    "subtitle" TEXT NOT NULL,
    "description" TEXT,
    "winablePoints" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Levels_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ExercisesSerie" ADD CONSTRAINT "ExercisesSerie_levelId_fkey" FOREIGN KEY ("levelId") REFERENCES "Levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
