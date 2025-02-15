/*
  Warnings:

  - You are about to drop the `exercisesserie` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `refreshtoken` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Exercise" DROP CONSTRAINT "Exercise_serieId_fkey";

-- DropForeignKey
ALTER TABLE "exercisesserie" DROP CONSTRAINT "exercisesserie_levelId_fkey";

-- DropForeignKey
ALTER TABLE "refreshtoken" DROP CONSTRAINT "refreshtoken_userId_fkey";

-- DropTable
DROP TABLE "exercisesserie";

-- DropTable
DROP TABLE "refreshtoken";

-- CreateTable
CREATE TABLE "RefreshToken" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RefreshToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExercisesSerie" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "levelId" INTEGER NOT NULL,

    CONSTRAINT "ExercisesSerie_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "RefreshToken" ADD CONSTRAINT "RefreshToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExercisesSerie" ADD CONSTRAINT "ExercisesSerie_levelId_fkey" FOREIGN KEY ("levelId") REFERENCES "Level"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exercise" ADD CONSTRAINT "Exercise_serieId_fkey" FOREIGN KEY ("serieId") REFERENCES "ExercisesSerie"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
