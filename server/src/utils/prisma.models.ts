import { Prisma } from "@prisma/client";
import { CreateExerciseDto } from "src/exercise/dto/create-exercise.dto";
import { UpdateExerciseDto } from "src/exercise/dto/update-exercise.dto";
import { CreateExercisesSerieDto } from "src/exercises-serie/dto/create-exercises-serie.dto";
import { UpdateExercisesSerieDto } from "src/exercises-serie/dto/update-exercises-serie.dto";
import { CreateLevelDto } from "src/level/dto/create-level.dto";
import { UpdateLevelDto } from "src/level/dto/update-level.dto";
import { CreateUserCompletedExerciseDto } from "src/user-completed-exercise/dto/create-user-completed-exercise.dto";
import { UpdateUserCompletedExerciseDto } from "src/user-completed-exercise/dto/update-user-completed-exercise.dto";

export type PrismaModels = {
    ExercisesSerie: {
        cursor: Prisma.ExercisesSerieWhereUniqueInput;
        where: Prisma.ExercisesSerieWhereInput;
        orderBy: Prisma.ExercisesSerieOrderByWithRelationInput;
        include: Prisma.ExercisesSerieInclude;
        create: CreateExercisesSerieDto;
        update: UpdateExercisesSerieDto;
    };
    Exercise: {
        cursor: Prisma.ExerciseWhereUniqueInput;
        where: Prisma.ExerciseWhereInput;
        orderBy: Prisma.ExerciseOrderByWithRelationInput;
        include: Prisma.ExerciseInclude;
        create: CreateExerciseDto;
        update: UpdateExerciseDto;
    };
    Level: {
        cursor: Prisma.LevelWhereUniqueInput;
        where: Prisma.LevelWhereInput;
        orderBy: Prisma.LevelOrderByWithRelationInput;
        include: Prisma.LevelInclude;
        create: CreateLevelDto;
        update: UpdateLevelDto;
    };
    UserCompletedExercise: {
        cursor: Prisma.UserCompletedExerciseWhereUniqueInput;
        where: Prisma.UserCompletedExerciseWhereInput;
        orderBy: Prisma.UserCompletedExerciseOrderByWithRelationInput;
        include: Prisma.UserCompletedExerciseInclude;
        create: CreateUserCompletedExerciseDto;
        update: UpdateUserCompletedExerciseDto;
    };
  };
  
  export type EntityName = keyof PrismaModels;
