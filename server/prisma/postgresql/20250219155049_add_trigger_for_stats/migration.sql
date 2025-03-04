DROP FUNCTION IF EXISTS add_successfullExercises_in_user_stats() CASCADE;
DROP FUNCTION IF EXISTS add_points_in_user_stats() CASCADE;
DROP FUNCTION IF EXISTS add_totalUsers_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS add_totalExercises_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS add_totalPoints_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS add_totalSeries_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS add_winablePoints_in_level() CASCADE;
DROP FUNCTION IF EXISTS subtract_totalSeries_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS subtract_totalPoints_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS subtract_winablePoints_in_level() CASCADE;
DROP FUNCTION IF EXISTS subtract_totalExercises_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS subtract_totalUsers_in_site_stats() CASCADE;
DROP FUNCTION IF EXISTS subtract_points_in_user_stats() CASCADE;
DROP FUNCTION IF EXISTS subtract_successfullExercises_in_user_stats() CASCADE;

DROP TRIGGER IF EXISTS on_create_userCompletedExercise_add_successfullExercises_in_user_stats ON "UserCompletedExercise";
DROP TRIGGER IF EXISTS on_create_userCompletedExercise_add_points_in_user_stats ON "UserCompletedExercise";
DROP TRIGGER IF EXISTS on_create_user_add_totalUsers_in_site_stats ON "User";
DROP TRIGGER IF EXISTS on_create_exercise_add_totalExercises_in_site_stats ON "Exercise";
DROP TRIGGER IF EXISTS on_create_exercise_add_totalPoints_in_site_stats ON "Exercise";
DROP TRIGGER IF EXISTS on_create_exercisesSerie_add_totalSeries_in_site_stats ON "ExercisesSerie";
DROP TRIGGER IF EXISTS on_create_exercise_add_winablePoints_in_level ON "Exercise";
DROP TRIGGER IF EXISTS on_delete_exercisesSerie_subtract_totalSeries_in_site_stats ON "ExercisesSerie";
DROP TRIGGER IF EXISTS on_delete_exercise_subtract_totalPoints_in_site_stats ON "Exercise";
DROP TRIGGER IF EXISTS on_delete_exercise_subtract_winablePoints_in_level ON "Exercise";
DROP TRIGGER IF EXISTS on_delete_exercise_subtract_totalExercises_in_site_stats ON "Exercise";
DROP TRIGGER IF EXISTS on_delete_user_subtract_totalUsers_in_site_stats ON "User";
DROP TRIGGER IF EXISTS on_delete_userCompletedExercise_subtract_points_in_user_stats ON "UserCompletedExercise";
DROP TRIGGER IF EXISTS on_delete_userCompletedExercise_subtract_successfullExercises_in_user_stats ON "UserCompletedExercise";

---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre d'exercices réussis dans les stats de l'utilisateur lorsque l'on complète un exercice
---------------------------------------------------------------------

CREATE FUNCTION add_successfullExercises_in_user_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "UserStats"
    SET "successfullExercises" = "successfullExercises" + 1
    WHERE "userId" = NEW."userId";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_userCompletedExercise_add_successfullExercises_in_user_stats
AFTER INSERT ON "UserCompletedExercise"
FOR EACH ROW
EXECUTE PROCEDURE add_successfullExercises_in_user_stats();


---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre de points dans les stats de l'utilisateur lorsque l'on complète un exercice
---------------------------------------------------------------------

CREATE FUNCTION add_points_in_user_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = NEW."serieId" LIMIT 1;

    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "UserStats"
    SET "points" = "points" + "points_per_exo"
    WHERE "userId" = NEW."userId";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_userCompletedExercise_add_points_in_user_stats
AFTER INSERT ON "UserCompletedExercise"
FOR EACH ROW
EXECUTE PROCEDURE add_points_in_user_stats();

---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre d'utilisateurs totaux dans les stats du site lorsque l'on crée un utilisateur
---------------------------------------------------------------------

CREATE FUNCTION add_totalUsers_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalUsers" = "totalUsers" + 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_user_add_totalUsers_in_site_stats
AFTER INSERT ON "User"
FOR EACH ROW
EXECUTE PROCEDURE add_totalUsers_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre d'exercices totaux dans les stats du site lorsque l'on crée un exercice
---------------------------------------------------------------------

CREATE FUNCTION add_totalExercises_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalExercises" = "totalExercises" + 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_exercise_add_totalExercises_in_site_stats
AFTER INSERT ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE add_totalExercises_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre de points totaux dans les stats du site lorsque l'on crée un exercice
---------------------------------------------------------------------

CREATE FUNCTION add_totalPoints_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = NEW."serieId" LIMIT 1;

    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "SiteStats"
    SET "totalPoints" = "totalPoints" + "points_per_exo"
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_exercise_add_totalPoints_in_site_stats
AFTER INSERT ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE add_totalPoints_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre de séries totales dans les stats du site lorsque l'on crée une série d'exercises
---------------------------------------------------------------------

CREATE FUNCTION add_totalSeries_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalSeries" = "totalSeries" + 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_exercisesSerie_add_totalSeries_in_site_stats
AFTER INSERT ON "ExercisesSerie"
FOR EACH ROW
EXECUTE PROCEDURE add_totalSeries_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre de points gagnables dans le niveau lorsque l'on crée un exercice
---------------------------------------------------------------------

CREATE FUNCTION add_winablePoints_in_level() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = NEW."serieId" LIMIT 1;

    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "Level"
    SET "winablePoints" = "winablePoints" + "points_per_exo"
    WHERE id = "level_id";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_exercise_add_winablePoints_in_level
AFTER INSERT ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE add_winablePoints_in_level();

---------------------------------------------------------------------
-- Créer un trigger qui décrémente le nombre de points totaux dans les stats du site lorsque l'on supprime une série d'exercises
---------------------------------------------------------------------

CREATE FUNCTION subtract_totalSeries_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalSeries" = "totalSeries" - 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_delete_exercisesSerie_subtract_totalSeries_in_site_stats
AFTER DELETE ON "ExercisesSerie"
FOR EACH ROW
EXECUTE PROCEDURE subtract_totalSeries_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui décrémente le nombre de points totaux dans les stats du site lorsque l'on supprime un exercice
---------------------------------------------------------------------

CREATE FUNCTION subtract_totalPoints_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = OLD."serieId" LIMIT 1;
    
    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "SiteStats"
    SET "totalPoints" = "totalPoints" - "points_per_exo"
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_delete_exercise_subtract_totalPoints_in_site_stats
AFTER DELETE ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE subtract_totalPoints_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui décrémente le nombre de points gagnables dans le niveau lorsque l'on supprime un exercice
---------------------------------------------------------------------

CREATE FUNCTION subtract_winablePoints_in_level() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = OLD."serieId" LIMIT 1;
    
    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "Level"
    SET "winablePoints" = "winablePoints" - "points_per_exo"
    WHERE id = "level_id";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_delete_exercise_subtract_winablePoints_in_level
AFTER DELETE ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE subtract_winablePoints_in_level();

---------------------------------------------------------------------
-- Créer un trigger qui décrémente le nombre d'exercices totaux dans les stats du site lorsque l'on supprime un exercice
---------------------------------------------------------------------

CREATE FUNCTION subtract_totalExercises_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalExercises" = "totalExercises" - 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_delete_exercise_subtract_totalExercises_in_site_stats
AFTER DELETE ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE subtract_totalExercises_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui décrémente le nombre d'utilisateurs totaux dans les stats du site lorsque l'on supprime un utilisateur
---------------------------------------------------------------------

CREATE FUNCTION subtract_totalUsers_in_site_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalUsers" = "totalUsers" - 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_delete_user_subtract_totalUsers_in_site_stats
AFTER DELETE ON "User"
FOR EACH ROW
EXECUTE PROCEDURE subtract_totalUsers_in_site_stats();

---------------------------------------------------------------------
-- Créer un trigger qui décrémente le nombre de points dans les stats de l'utilisateur lorsque l'on échoue un exercice
---------------------------------------------------------------------

CREATE FUNCTION subtract_points_in_user_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = OLD."serieId" LIMIT 1;
    
    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "UserStats"
    SET "points" = "points" - "points_per_exo"
    WHERE "userId" = OLD."userId";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_delete_userCompletedExercise_subtract_points_in_user_stats
AFTER DELETE ON "UserCompletedExercise"
FOR EACH ROW
EXECUTE PROCEDURE subtract_points_in_user_stats();

---------------------------------------------------------------------
-- Créer un trigger qui décrémente le nombre de points dans les stats de l'utilisateur lorsque l'on échoue un exercice
---------------------------------------------------------------------

CREATE FUNCTION subtract_successfullExercises_in_user_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "UserStats"
    SET "successfullExercises" = "successfullExercises" - 1
    WHERE "userId" = OLD."userId";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_delete_userCompletedExercise_subtract_successfullExercises_in_user_stats
AFTER DELETE ON "UserCompletedExercise"
FOR EACH ROW
EXECUTE PROCEDURE subtract_successfullExercises_in_user_stats();