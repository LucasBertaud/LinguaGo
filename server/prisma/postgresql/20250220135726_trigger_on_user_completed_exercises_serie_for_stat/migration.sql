---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre de séries complétées par un utilisateur quand une série est complétée
---------------------------------------------------------------------

CREATE FUNCTION add_completedSeries_in_user_stats() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "UserStats"
    SET "completedSeries" = "completedSeries" + 1
    WHERE "userId" = NEW."userId";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_UserCompletedExercisesSerie_add_completedSeries_in_user_stats
AFTER INSERT ON "UserCompletedExercisesSerie"
FOR EACH ROW
EXECUTE PROCEDURE add_completedSeries_in_user_stats();