-- Задание 2.

-- 2.1 - Хранимая процедура. Добавление товара.

CREATE OR REPLACE FUNCTION insert_good(
    _name       TEXT DEFAULT NULL,
    _vital      BOOLEAN DEFAULT NULL,
    _type_id    INTEGER DEFAULT NULL,
    _recipe_id  INTEGER DEFAULT NULL
) RETURNS BOOLEAN AS $insert_good$
BEGIN
    IF _name IS NULL THEN
        RAISE EXCEPTION 'Значение поля name не определено.';
    END IF;

    IF _vital IS NULL THEN
        RAISE EXCEPTION 'Значение поля vital не определено.';
    END IF;

    IF _type_id IS NULL THEN
        RAISE EXCEPTION 'Значение поля type_id не определено.';
    END IF;


    INSERT INTO good (
        name,
        vital,
        type_id,
        recipe_id
    )
    VALUES (
        _name,
        _vital,
        _type_id,
        COALESCE(_recipe_id, NULL)
    );

    RETURN FOUND;
END;
$insert_good$ LANGUAGE plpgsql;



-- 2.2 - Хранимая процедура. Изменение товара.

CREATE OR REPLACE FUNCTION update_good(
    _name       TEXT DEFAULT NULL,
    _vital      BOOLEAN DEFAULT NULL,
    _type_id    INTEGER DEFAULT NULL,
    _recipe_id  INTEGER DEFAULT NULL
) RETURNS BOOLEAN AS $update_good$
BEGIN

    UPDATE good SET
        name=COALESCE(_name, good.name),
        vital=COALESCE(_vital, good.vital),
        type_id=COALESCE(_type_id, good.type_id),
        recipe_id=COALESCE(_recipe_id, good.recipe_id)
    WHERE name=_name;

    RETURN FOUND;
END;
$update_good$ LANGUAGE plpgsql;



-- 2.3 - Хранимая процедура. Удаление товара.

CREATE OR REPLACE FUNCTION delete_good(
    _name TEXT
) RETURNS BOOLEAN AS $delete_good$
BEGIN
    DELETE FROM good WHERE name = _name;
    IF NOT FOUND THEN RETURN NULL; END IF;

    RETURN TRUE;
END;
$delete_good$ LANGUAGE plpgsql;