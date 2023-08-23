/* Populate database with sample data. */

INSERT INTO animals 
    (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES 
    ('Agumon', TO_DATE('20200203','YYYYMMDD'), 10.23, true, 0);

INSERT INTO animals 
    (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES 
    ('Gabumon', TO_DATE('20181115','YYYYMMDD'), 8, true, 2),
    ('Pikachu', TO_DATE('20210107','YYYYMMDD'), 15.04, false, 1),
    ('Devimon', TO_DATE('20170512','YYYYMMDD'), 11, true, 5);

-- Insert new data at day 2;
INSERT INTO animals 
    (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES
    ('Charmander', TO_DATE('20200208', 'YYYYMMDD'), -11, false, 0),
    ('Plantmon', TO_DATE('20211115', 'YYYYMMDD'), -5.7, true, 2),
    ('Squirtle', TO_DATE('19930402', 'YYYYMMDD'), -12.13, false, 3),
    ('Angemon', TO_DATE('20050612', 'YYYYMMDD'), -45, true, 1),
    ('Boarmon', TO_DATE('20050607', 'YYYYMMDD'), 20.4, true, 7),
    ('Blossom', TO_DATE('19981013', 'YYYYMMDD'), 17, true, 3),
    ('Ditto', TO_DATE('20220514', 'YYYYMMDD'), 22, true, 4);


-- insert data into table owners
-- insert data into the table species
BEGIN;
INSERT INTO owners (full_name, age)
VALUES 
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);
INSERT INTO species (name)
VALUES 
    ('Pokemon'),
    ('Digimon');
COMMIT;

-- Table animals includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals SET species_id = 1;
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

-- Modify animals (owner_id):
-- Sam Smith owns Agumon.
UPDATE animals SET 
    owner_id = (SELECT id FROM owners WHERE full_name LIKE '%Sam%') 
    WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET 
    owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
    WHERE name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
UPDATE animals SET 
    owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') 
    WHERE name IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET 
    owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
    WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET 
    owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') 
    WHERE name IN ('Angemon', 'Boarmon');


