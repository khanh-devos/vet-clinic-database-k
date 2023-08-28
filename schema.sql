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
    id SERIAL,
    name VARCHAR(100),
    -- PRIMARY KEY (id, name) // 2 primary keys allowable only at initial creating.
    PRIMARY KEY (id)
)

-- ALTER TABLE species ADD PRIMARY KEY (name);  
-- -- Modify animals table:
-- Remove PRIMARY KEY attribute of former PRIMARY KEY
-- : ALTER TABLE animals DROP CONSTRAINT column_pkey;
-- Change column name of your PRIMARY KEY and PRIMARY KEY candidates properly.
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


-- BEGIN TRANSACTION;
-- CREATE TABLE Pets_new( 
--     PetId INTEGER PRIMARY KEY, 
--     PetName,
--     TypeId,
--     FOREIGN KEY(TypeId) REFERENCES Types(TypeId)
-- );

-- INSERT INTO Pets_new SELECT * FROM Pets;
-- DROP TABLE Pets;
-- ALTER TABLE Pets_new RENAME TO Pets;
-- COMMIT;

-- Way1 : ADD FORWARD KEY TO existing table.
-- ALTER TABLE animals 
-- ADD CONSTRAINT animals_species_id_fkey 
-- FOREIGN KEY (species_id) 
-- REFERENCES species (id);


-- Way2 : ADD FORWARD KEY TO existing table.
-- BEGIN TRANSACTION;
-- ALTER TABLE animals RENAME TO animals_old;
-- CREATE TABLE animals (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(100),
--     date_of_birth DATE,
--     escape_attempts INT,
--     neutered BOOLEAN,
--     weight_kg DECIMAL,
--     species_id INTEGER,
--     species_name VARCHAR(100),
--     owner_id INTEGER,
--     FOREIGN KEY(species_id) REFERENCES species(id),
--     FOREIGN KEY(owner_id) REFERENCES owners(id)
-- );

-- INSERT INTO animals SELECT * FROM animals_old;
-- DROP TABLE animals_old;
-- COMMIT;

-- DAY 4: conjunction table to build a many-to-many relationship
-- Create a table 'vets':
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER NOT NULL CHECK (age > 0),
    date_of_graduation DATE
);

-- There is a many-to-many relationship between species and vets: 
-- A vet(pet doctor) can be specialized in many species, 
-- And a species can have multiple vets specialized in it.
-- Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id)
);

-- A many-to-many relationship between the tables animals and vets: 
-- An animal can visit multiple vets 
-- And one vet can be visited by multiple animals. 
-- Create a "join table" called visits to handle this relationship, 
-- It should also keep track of the date of the visit.
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    date_of_visit DATE
);

-- ######################################
-- Database performance audit
-- ######################################

-- start by: psql -U postgres
-- step 1. Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- step 2. Add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
SELECT * FROM (SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- step 3. Add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) 
select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

-- Depending on your machine speed: Check that by running 
-- If you get Execution time: X ms and X >= 1000: that should be enough, you can continue to the project requirements. 
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4: 
-- If you get Execution time: X ms and X < 1000: go back to point 3. and repeat until you get a value bigger than 1000ms.

-- The following queries are taking too much time (1000ms can be considered 
-- as too much time for database query).
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';

-- *********CHALLENGES: *************
-- 1. Find a way to decrease the execution time of the first query.
BEGIN;
ALTER TABLE animals ADD COLUMN total_visit INTEGER;
UPDATE animals   
SET total_visit = (SELECT COUNT(*) FROM visits where animal_id = 4)
WHERE id = 4;

explain analyze SELECT total_visit FROM animals where id = 4;
ROLLBACK;

-- 2. Find a way to decrease the execution time of the remaining two queries.
BEGIN;
CREATE TABLE vet_id_2_data 
AS (SELECT * FROM visits where vet_id = 2);

explain analyze SELECT * FROM vet_id_2_data;
ROLLBACK;


