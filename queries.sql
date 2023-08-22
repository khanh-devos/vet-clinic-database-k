/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%on';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2020-01-01';
SELECT name from animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name in ('Agumon', 'Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered=true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <=17.3;


-- Make a transaction update the species column to unspecified. 
-- Verify that change was made. 
-- Then roll back the change 
-- and verify that the species columns went back to the previous state.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT id, species FROM animals;
ROLLBACK;
SELECT id, species FROM animals;


-- Make a transaction:
-- 1. Update the animals table by setting the species column to 'digimon' for all animals that have a name ending in 'mon'.
-- 2. Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- 3. Verify that changes were made.
-- 4. Commit the transaction.
-- 5. Verify that changes persist after commit.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
SELECT id, name, species FROM animals;
COMMIT;
SELECT id, name, species FROM animals;

-- Make a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists.
BEGIN;
DELETE FROM animals;
SELECT id, name, species FROM animals;
ROLLBACK;
SELECT id, name, species FROM animals;

-- Make a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE id = 1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg)::numeric(10,2) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT id, name, neutered, escape_attempts FROM animals 
WHERE escape_attempts = (
    SELECT MAX(escape_attempts) FROM animals
);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)::NUMERIC(10,2) 
FROM (
    SELECT * FROM animals 
    WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
) AS A 
GROUP BY species;


