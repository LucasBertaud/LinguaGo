-- CreateTable
CREATE TABLE "UserCompletedExercisesSerie" (
    "userId" TEXT NOT NULL,
    "serieId" INTEGER NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserCompletedExercisesSerie_pkey" PRIMARY KEY ("userId","serieId")
);

-- AddForeignKey
ALTER TABLE "UserCompletedExercisesSerie" ADD CONSTRAINT "UserCompletedExercisesSerie_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCompletedExercisesSerie" ADD CONSTRAINT "UserCompletedExercisesSerie_serieId_fkey" FOREIGN KEY ("serieId") REFERENCES "ExercisesSerie"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
