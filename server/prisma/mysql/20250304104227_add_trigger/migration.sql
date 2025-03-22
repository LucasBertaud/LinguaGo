-- Supprimer les triggers si existants
DROP TRIGGER IF EXISTS on_create_exercise_add_winablePoints_in_level;
DROP TRIGGER IF EXISTS on_create_exercisesSerie_add_totalSeries_in_site_stats;
DROP TRIGGER IF EXISTS on_delete_exercise_subtract_winablePoints_in_level;
DROP TRIGGER IF EXISTS on_create_userCompletedExercises;
DROP TRIGGER IF EXISTS on_create_userCompletedExercise_add_points_in_user_stats;
DROP TRIGGER IF EXISTS on_create_user_add_totalUsers_in_site_stats;
DROP TRIGGER IF EXISTS on_create_exercise_add_totalExercises_in_site_stats;
DROP TRIGGER IF EXISTS on_create_exercise_add_totalPoints_in_site_stats;
DROP TRIGGER IF EXISTS on_delete_exercisesSerie_subtract_totalSeries_in_site_stats;
DROP TRIGGER IF EXISTS on_delete_exercise_subtract_totalPoints_in_site_stats;
DROP TRIGGER IF EXISTS on_delete_exercise_subtract_totalExercises_in_site_stats;
DROP TRIGGER IF EXISTS on_delete_user_subtract_totalUsers_in_site_stats;
DROP TRIGGER IF EXISTS on_delete_userCompletedExercise_subtract_points_in_user_stats;
DROP TRIGGER IF EXISTS on_delete_userCompletedExercise;
DROP TRIGGER IF EXISTS on_create_UserCompletedExercisesSerie;
DROP TRIGGER IF EXISTS on_update_UserStats_check_user_level;

-- Décrémenter les points gagnables dans un niveau lors de la suppression d'un exercice
CREATE TRIGGER on_delete_exercise_subtract_winablePoints_in_level
AFTER DELETE ON Exercise
FOR EACH ROW
BEGIN
    DECLARE level_id INT;
    DECLARE points_per_exo INT;

    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = OLD.serieId LIMIT 1;
    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;

    UPDATE Level
    SET winablePoints = winablePoints - points_per_exo
    WHERE id = level_id;
END;

-- Incrémenter le nombre total de séries dans les statistiques du site
CREATE TRIGGER on_create_exercisesSerie_add_totalSeries_in_site_stats
AFTER INSERT ON ExercisesSerie
FOR EACH ROW
BEGIN
    UPDATE SiteStats
    SET totalSeries = totalSeries + 1
    WHERE id = 1;
END;

-- Ajouter des points gagnables à un niveau lors de la création d'un exercice
CREATE TRIGGER on_create_exercise_add_winablePoints_in_level
AFTER INSERT ON Exercise
FOR EACH ROW
BEGIN
    DECLARE level_id INT;
    DECLARE points_per_exo INT;

    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = NEW.serieId LIMIT 1;
    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;

    UPDATE Level
    SET winablePoints = winablePoints + points_per_exo
    WHERE id = level_id;
END;

-- Fonction pour incrémenter le nombre d'exercices réussis par l'utilisateur
CREATE TRIGGER on_create_userCompletedExercises
AFTER INSERT ON UserCompletedExercise
FOR EACH ROW
BEGIN
    UPDATE UserStats
    SET successfullExercises = successfullExercises + 1
    WHERE userId COLLATE utf8mb4_unicode_ci = NEW.userId COLLATE utf8mb4_unicode_ci;
END;

-- Fonction pour ajouter des points à l'utilisateur
CREATE TRIGGER on_create_userCompletedExercise_add_points_in_user_stats
AFTER INSERT ON UserCompletedExercise
FOR EACH ROW
BEGIN
    DECLARE level_id INT;
    DECLARE points_per_exo INT;

    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = NEW.serieId LIMIT 1;
    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;

    UPDATE UserStats
    SET points = points + points_per_exo
    WHERE userId COLLATE utf8mb4_unicode_ci = NEW.userId COLLATE utf8mb4_unicode_ci;
END;

-- Fonction pour incrémenter le nombre total d'utilisateurs
CREATE TRIGGER on_create_user_add_totalUsers_in_site_stats
AFTER INSERT ON User
FOR EACH ROW
BEGIN
    UPDATE SiteStats
    SET totalUsers = totalUsers + 1
    WHERE id = 1;
END;

-- Fonction pour incrémenter le nombre total d'exercices
CREATE TRIGGER on_create_exercise_add_totalExercises_in_site_stats
AFTER INSERT ON Exercise
FOR EACH ROW
BEGIN
    UPDATE SiteStats
    SET totalExercises = totalExercises + 1
    WHERE id = 1;
END;

-- Fonction pour incrémenter le nombre total de points
CREATE TRIGGER on_create_exercise_add_totalPoints_in_site_stats
AFTER INSERT ON Exercise
FOR EACH ROW
BEGIN
    DECLARE level_id INT;
    DECLARE points_per_exo INT;

    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = NEW.serieId LIMIT 1;
    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;

    UPDATE SiteStats
    SET totalPoints = totalPoints + points_per_exo
    WHERE id = 1;
END;

-- Fonction pour décrémenter les séries totales dans les stats du site
CREATE TRIGGER on_delete_exercisesSerie_subtract_totalSeries_in_site_stats
AFTER DELETE ON ExercisesSerie
FOR EACH ROW
BEGIN
    UPDATE SiteStats
    SET totalSeries = totalSeries - 1
    WHERE id = 1;
END;

-- Fonction pour décrémenter le nombre total de points
CREATE TRIGGER on_delete_exercise_subtract_totalPoints_in_site_stats
AFTER DELETE ON Exercise
FOR EACH ROW
BEGIN
    DECLARE level_id INT;
    DECLARE points_per_exo INT;

    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = OLD.serieId LIMIT 1;
    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;

    UPDATE SiteStats
    SET totalPoints = totalPoints - points_per_exo
    WHERE id = 1;
END;

-- Fonction pour décrémenter le nombre total d'exercices
CREATE TRIGGER on_delete_exercise_subtract_totalExercises_in_site_stats
AFTER DELETE ON Exercise
FOR EACH ROW
BEGIN
    UPDATE SiteStats
    SET totalExercises = totalExercises - 1
    WHERE id = 1;
END;

-- Fonction pour décrémenter le nombre total d'utilisateurs
CREATE TRIGGER on_delete_user_subtract_totalUsers_in_site_stats
AFTER DELETE ON User
FOR EACH ROW
BEGIN
    UPDATE SiteStats
    SET totalUsers = totalUsers - 1
    WHERE id = 1;
END;

-- Fonction pour décrémenter les points de l'utilisateur en cas d'échec
CREATE TRIGGER on_delete_userCompletedExercise_subtract_points_in_user_stats
AFTER DELETE ON UserCompletedExercise
FOR EACH ROW
BEGIN
    DECLARE level_id INT;
    DECLARE points_per_exo INT;

    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = OLD.serieId LIMIT 1;
    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;

    UPDATE UserStats
    SET points = points - points_per_exo
    WHERE userId COLLATE utf8mb4_unicode_ci = OLD.userId COLLATE utf8mb4_unicode_ci;
END;

-- Fonction pour décrémenter les exercices réussis de l'utilisateur
CREATE TRIGGER on_delete_userCompletedExercise
AFTER DELETE ON UserCompletedExercise
FOR EACH ROW
BEGIN
    UPDATE UserStats
    SET successfullExercises = successfullExercises - 1
    WHERE userId COLLATE utf8mb4_unicode_ci = OLD.userId COLLATE utf8mb4_unicode_ci;
END;

CREATE TRIGGER on_create_UserCompletedExercisesSerie
AFTER INSERT ON UserCompletedExercisesSerie
FOR EACH ROW
BEGIN
    UPDATE UserStats
    SET completedSeries = completedSeries + 1
    WHERE userId COLLATE utf8mb4_unicode_ci = NEW.userId COLLATE utf8mb4_unicode_ci;
END;

CREATE TRIGGER on_update_UserStats_check_user_level
AFTER UPDATE ON UserStats
FOR EACH ROW
BEGIN
    DECLARE levelUser VARCHAR(255);

    -- Trouver le niveau correspondant au nouveau nombre de points
    SELECT title INTO levelUser 
    FROM Level 
    WHERE winablePoints >= NEW.points 
    ORDER BY winablePoints ASC 
    LIMIT 1;

    -- Mettre à jour le niveau si nécessaire
    IF levelUser IS NOT NULL AND levelUser != NEW.level THEN
        UPDATE UserStats 
        SET level = levelUser 
        WHERE userId COLLATE utf8mb4_unicode_ci = NEW.userId COLLATE utf8mb4_unicode_ci;
    END IF;
END;