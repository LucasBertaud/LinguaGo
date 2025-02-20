import { Prisma } from "@prisma/client";
import { CreateExerciseDto } from "src/exercise/dto/create-exercise.dto";
import { UpdateExerciseDto } from "src/exercise/dto/update-exercise.dto";
import { CreateExercisesSerieDto } from "src/exercises-serie/dto/create-exercises-serie.dto";
import { UpdateExercisesSerieDto } from "src/exercises-serie/dto/update-exercises-serie.dto";
import { CreateLevelDto } from "src/level/dto/create-level.dto";
import { UpdateLevelDto } from "src/level/dto/update-level.dto";
import { CreateUserCompletedExerciseDto } from "src/user/user-completed-exercise/dto/create-user-completed-exercise.dto";
import { UpdateUserCompletedExerciseDto } from "src/user/user-completed-exercise/dto/update-user-completed-exercise.dto";
import { CreateUserCompletedExercisesSerieDto } from "src/user/user-completed-exercises-serie/dto/create-user-completed-exercises-serie.dto";
import { UpdateUserCompletedExercisesSerieDto } from "src/user/user-completed-exercises-serie/dto/update-user-completed-exercises-serie.dto";
import { CreateUserFavoriteSerieDto } from "src/user/user-favorite-serie/dto/create-user-favorite-serie.dto";
import { UpdateUserFavoriteSerieDto } from "src/user/user-favorite-serie/dto/update-user-favorite-serie.dto";

export type PrismaModels = {
    ExercisesSerie: {
        cursor: Prisma.ExercisesSerieWhereUniqueInput;
        where: Prisma.ExercisesSerieWhereInput;
        orderBy: Prisma.ExercisesSerieOrderByWithRelationInput;
        include: Prisma.ExercisesSerieInclude;
        createMany: Prisma.ExercisesSerieCreateManyInput;
        create: CreateExercisesSerieDto;
        update: UpdateExercisesSerieDto;
    };
    Exercise: {
        cursor: Prisma.ExerciseWhereUniqueInput;
        where: Prisma.ExerciseWhereInput;
        orderBy: Prisma.ExerciseOrderByWithRelationInput;
        include: Prisma.ExerciseInclude;
        createMany: Prisma.ExerciseCreateManyInput | CreateExerciseDto[];
        create: CreateExerciseDto;
        update: UpdateExerciseDto;
    };
    Level: {
        cursor: Prisma.LevelWhereUniqueInput;
        where: Prisma.LevelWhereInput;
        orderBy: Prisma.LevelOrderByWithRelationInput;
        include: Prisma.LevelInclude;
        createMany: Prisma.LevelCreateManyInput;
        create: CreateLevelDto;
        update: UpdateLevelDto;
    };
    UserCompletedExercise: {
        cursor: Prisma.UserCompletedExerciseWhereUniqueInput;
        where: Prisma.UserCompletedExerciseWhereInput | Prisma.UserCompletedExerciseWhereUniqueInput;
        orderBy: Prisma.UserCompletedExerciseOrderByWithRelationInput;
        include: Prisma.UserCompletedExerciseInclude;
        createMany: Prisma.UserCompletedExerciseCreateManyInput;
        create: CreateUserCompletedExerciseDto;
        update: UpdateUserCompletedExerciseDto;
    };
    UserFavoriteSerie: {
        cursor: Prisma.UserFavoriteSerieWhereUniqueInput;
        where: Prisma.UserFavoriteSerieWhereInput | Prisma.UserFavoriteSerieWhereUniqueInput;
        orderBy: Prisma.UserFavoriteSerieOrderByWithRelationInput;
        include: Prisma.UserFavoriteSerieInclude;
        createMany: Prisma.UserFavoriteSerieCreateManyInput;
        create: CreateUserFavoriteSerieDto;
        update: UpdateUserFavoriteSerieDto;
    };
    UserStats: {
        cursor: Prisma.UserStatsWhereUniqueInput;
        where: Prisma.UserStatsWhereInput;
        orderBy: Prisma.UserStatsOrderByWithRelationInput;
        include: Prisma.UserStatsInclude;
        createMany: Prisma.UserStatsCreateManyInput;
        create: Prisma.UserStatsCreateInput;
        update: Prisma.UserStatsUpdateInput;
    };
    SiteStats: {
        cursor: Prisma.SiteStatsWhereUniqueInput;
        where: Prisma.SiteStatsWhereInput;
        orderBy: Prisma.SiteStatsOrderByWithRelationInput;
        include: null;
        createMany: Prisma.SiteStatsCreateManyInput;
        create: Prisma.SiteStatsCreateInput;
        update: Prisma.SiteStatsUpdateInput;
    };
    UserCompletedExercisesSerie: {
        cursor: Prisma.UserCompletedExercisesSerieWhereUniqueInput;
        where: Prisma.UserCompletedExercisesSerieWhereInput | Prisma.UserCompletedExercisesSerieWhereUniqueInput;
        orderBy: Prisma.UserCompletedExercisesSerieOrderByWithRelationInput;
        include: Prisma.UserCompletedExercisesSerieInclude;
        createMany: Prisma.UserCompletedExercisesSerieCreateManyInput;
        create: CreateUserCompletedExercisesSerieDto;
        update: UpdateUserCompletedExercisesSerieDto;
    }
  };
  
  export type EntityName = keyof PrismaModels;
