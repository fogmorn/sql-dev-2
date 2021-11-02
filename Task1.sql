-- Задание 1.

CREATE DATABASE pharm;

CREATE TABLE good_type (
    id          SERIAL PRIMARY KEY,
    name        varchar(15) NOT NULL
);

CREATE TABLE recipe (
    id          SERIAL PRIMARY KEY,
    name        varchar(20) NOT NULL
);

CREATE TABLE locality (
    id          SERIAL PRIMARY KEY,
    name        varchar(100) NOT NULL
);

CREATE TABLE good (
    id          SERIAL PRIMARY KEY,
    name        varchar(50) NOT NULL UNIQUE,
    vital       boolean     NOT NULL,
    type_id     int         NOT NULL,
    recipe_id   int,
    FOREIGN KEY (type_id) REFERENCES good_type (id),
    FOREIGN KEY (recipe_id) REFERENCES recipe (id)
);

CREATE TABLE pharmacy (
    id          SERIAL PRIMARY KEY,
    name        varchar(50) NOT NULL,
    locality_id int         NOT NULL,
    FOREIGN KEY (locality_id) REFERENCES locality (id)
);

CREATE TABLE price (
    id          SERIAL PRIMARY KEY,
    price       int NOT NULL,
    good_id     int NOT NULL,
    pharmacy_id int NOT NULL,
    FOREIGN KEY (good_id) REFERENCES good (id),
    FOREIGN KEY (pharmacy_id) REFERENCES pharmacy (id)
);

CREATE TABLE sale (
    id          SERIAL PRIMARY KEY,
    sale_time   timestamp NOT NULL,
    quantity    int       NOT NULL,
    good_id     int       NOT NULL,
    pharmacy_id int       NOT NULL,
    FOREIGN KEY (good_id) REFERENCES good (id),
    FOREIGN KEY (pharmacy_id) REFERENCES pharmacy (id)
);
