import { Prisma } from "@prisma/client";
import { CreateExerciseDto } from "src/exercise/dto/create-exercise.dto";
import { UpdateExerciseDto } from "src/exercise/dto/update-exercise.dto";
import { CreateExercisesSerieDto } from "src/exercises-serie/dto/create-exercises-serie.dto";
import { UpdateExercisesSerieDto } from "src/exercises-serie/dto/update-exercises-serie.dto";
import { CreateNotificationDto } from "src/notifications/dto/create-notification.dto";
import { UpdateNotificationDto } from "src/notifications/dto/update-notification.dto";
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
        _sum: Prisma.ExercisesSerieSumAggregateInputType;
    };
    Exercise: {
        cursor: Prisma.ExerciseWhereUniqueInput;
        where: Prisma.ExerciseWhereInput;
        orderBy: Prisma.ExerciseOrderByWithRelationInput;
        include: Prisma.ExerciseInclude;
        createMany: Prisma.ExerciseCreateManyInput | CreateExerciseDto[];
        create: CreateExerciseDto;
        update: UpdateExerciseDto;
        _sum: Prisma.ExercisesSerieSumAggregateInputType;
    };
    Level: {
        cursor: Prisma.LevelWhereUniqueInput;
        where: Prisma.LevelWhereInput;
        orderBy: Prisma.LevelOrderByWithRelationInput;
        include: Prisma.LevelInclude;
        createMany: Prisma.LevelCreateManyInput;
        create: Prisma.LevelCreateInput;
        update: Prisma.LevelUpdateInput;
        _sum: Prisma.LevelSumAggregateInputType;
    };
    UserCompletedExercise: {
        cursor: Prisma.UserCompletedExerciseWhereUniqueInput;
        where: Prisma.UserCompletedExerciseWhereInput | Prisma.UserCompletedExerciseWhereUniqueInput;
        orderBy: Prisma.UserCompletedExerciseOrderByWithRelationInput | Prisma.UserCompletedExerciseOrderByWithAggregationInput;
        include: Prisma.UserCompletedExerciseInclude;
        createMany: Prisma.UserCompletedExerciseCreateManyInput;
        create: CreateUserCompletedExerciseDto;
        update: UpdateUserCompletedExerciseDto;
        _sum: Prisma.UserCompletedExerciseSumAggregateInputType;
    };
    UserFavoriteSerie: {
        cursor: Prisma.UserFavoriteSerieWhereUniqueInput;
        where: Prisma.UserFavoriteSerieWhereInput | Prisma.UserFavoriteSerieWhereUniqueInput;
        orderBy: Prisma.UserFavoriteSerieOrderByWithRelationInput;
        include: Prisma.UserFavoriteSerieInclude;
        createMany: Prisma.UserFavoriteSerieCreateManyInput;
        create: CreateUserFavoriteSerieDto;
        update: UpdateUserFavoriteSerieDto;
        _sum: Prisma.UserFavoriteSerieSumAggregateInputType;
    };
    UserStats: {
        cursor: Prisma.UserStatsWhereUniqueInput;
        where: Prisma.UserStatsWhereInput;
        orderBy: Prisma.UserStatsOrderByWithRelationInput;
        include: Prisma.UserStatsInclude;
        createMany: Prisma.UserStatsCreateManyInput;
        create: Prisma.UserStatsCreateInput;
        update: Prisma.UserStatsUpdateInput;
        _sum: Prisma.UserStatsSumAggregateInputType;
    };
    SiteStats: {
        cursor: Prisma.SiteStatsWhereUniqueInput;
        where: Prisma.SiteStatsWhereInput;
        orderBy: Prisma.SiteStatsOrderByWithRelationInput;
        include: null;
        createMany: Prisma.SiteStatsCreateManyInput;
        create: Prisma.SiteStatsCreateInput;
        update: Prisma.SiteStatsUpdateInput;
        _sum: Prisma.SiteStatsSumAggregateInputType;
    };
    UserCompletedExercisesSerie: {
        cursor: Prisma.UserCompletedExercisesSerieWhereUniqueInput;
        where: Prisma.UserCompletedExercisesSerieWhereInput | Prisma.UserCompletedExercisesSerieWhereUniqueInput;
        orderBy: Prisma.UserCompletedExercisesSerieOrderByWithRelationInput;
        include: Prisma.UserCompletedExercisesSerieInclude;
        createMany: Prisma.UserCompletedExercisesSerieCreateManyInput;
        create: CreateUserCompletedExercisesSerieDto;
        update: UpdateUserCompletedExercisesSerieDto;
        _sum: Prisma.UserCompletedExercisesSerieSumAggregateInputType;
    };
    Notification: {
        cursor: Prisma.NotificationWhereUniqueInput;
        where: Prisma.NotificationWhereInput | Prisma.NotificationWhereUniqueInput;
        orderBy: Prisma.NotificationOrderByWithRelationInput;
        include: Prisma.NotificationInclude;
        createMany: Prisma.NotificationCreateManyInput;
        create: CreateNotificationDto;
        update: UpdateNotificationDto;
        _sum: Prisma.NotificationSumAggregateInputType;
    };
  };
  
  export type EntityName = keyof PrismaModels;
