-- CreateTable
CREATE TABLE "UserFavoriteSerie" (
    "userId" TEXT NOT NULL,
    "serieId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserFavoriteSerie_pkey" PRIMARY KEY ("userId","serieId")
);

-- AddForeignKey
ALTER TABLE "UserFavoriteSerie" ADD CONSTRAINT "UserFavoriteSerie_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFavoriteSerie" ADD CONSTRAINT "UserFavoriteSerie_serieId_fkey" FOREIGN KEY ("serieId") REFERENCES "ExercisesSerie"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
