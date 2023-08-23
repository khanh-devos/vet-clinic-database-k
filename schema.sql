/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- Add a new column "species" of type string to the table 'animals'.
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- DAY 3 : create new table owners
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
CREATE TABLE OWNERS (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INTEGER
);

-- Create a table species
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
CREATE TABLE SPECIES (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
)

-- -- Modify animals table:
-- Remove PRIMARY KEY attribute of former PRIMARY KEY
-- : ALTER TABLE animals DROP CONSTRAINT column_pkey;
-- Then change column name of  your PRIMARY KEY and PRIMARY KEY candidates properly.
-- : ALTER TABLE animals RENAME COLUMN col_name TO id;
-- Lastly set your new PRIMARY KEY
-- : ALTER TABLE animals ADD PRIMARY KEY (id);
-- change type of a column
-- : ALTER TABLE animals ALTER id TYPE int;

-- id is set as autoincremented PRIMARY KEY
ALTER TABLE animals ADD PRIMARY KEY id;
-- Remove column species
ALTER TABLE animals DROP COLUMN species;
-- Add column species_id referencing species table
ALTER TABLE animals ADD COLUMN species_id int REFERENCES species(id);
-- Add column owner_id referencing the owners table (auto connect pkey of owners: id)
ALTER TABLE animals ADD COLUMN owner_id int REFERENCES owners;  


