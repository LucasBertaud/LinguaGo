CREATE FUNCTION add_winablePoints_in_level() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    level_id INTEGER;
BEGIN
    SELECT levelId INTO level_id FROM exercisesserie WHERE id = NEW.serieId LIMIT 1;

    UPDATE Level
    SET winablePoints = winablePoints + 1
    WHERE id = levelId;
END;
$$;

CREATE TRIGGER on_create_exercise_add_winablePoints_in_level
AFTER INSERT ON "Exercise"
FOR EACH ROW
EXECUTE PROCEDURE add_winablePoints_in_level();