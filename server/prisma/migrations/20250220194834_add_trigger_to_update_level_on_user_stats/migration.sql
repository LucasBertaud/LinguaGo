---------------------------------------------------------------------
-- Créer un trigger qui incrémente le nombre de séries complétées par un utilisateur quand une série est complétée
---------------------------------------------------------------------

CREATE FUNCTION check_user_level() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    levelUser "LevelEnum";
BEGIN
    SELECT "title" INTO levelUser FROM "Level" WHERE "winablePoints" >= NEW."points" ORDER BY "winablePoints" ASC LIMIT 1;

    IF levelUser != NEW."level" THEN
        UPDATE "UserStats"
        SET "level" = levelUser
        WHERE "userId" = NEW."userId";
    END IF;
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_update_UserStats_check_user_level
AFTER UPDATE OF "points" ON "UserStats"
FOR EACH ROW
EXECUTE PROCEDURE check_user_level();