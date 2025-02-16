DROP FUNCTION IF EXISTS add_winablePoints_in_level() CASCADE;
DROP TRIGGER IF EXISTS on_create_exercise_add_winablePoints_in_level ON "Exercise";

CREATE FUNCTION add_winablePoints_in_level() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = NEW."serieId" LIMIT 1;

    UPDATE "Level"
    SET "winablePoints" = "winablePoints" + 1
    WHERE id = "level_id";
    RETURN NULL;
END;
$$;

CREATE FUNCTION subtract_winablePoints_in_level() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = OLD."serieId" LIMIT 1;

    UPDATE "Level"
    SET "winablePoints" = "winablePoints" - 1
    WHERE id = "level_id";
    RETURN NULL;
END;
$$;

CREATE TRIGGER on_create_exercise_add_winablePoints_in_level
AFTER INSERT ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE add_winablePoints_in_level();

CREATE TRIGGER on_delete_exercise_subtract_winablePoints_in_level
AFTER DELETE ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE subtract_winablePoints_in_level();