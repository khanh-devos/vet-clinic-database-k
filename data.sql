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

-- ######
-- DAY 4: Vet clinic database: add "join table" for visits
-- Insert the following data for vets:
INSERT INTO vets (name, age, date_of_graduation)
VALUES 
    ('William Tatcher', 45, TO_DATE('20000423', 'YYYYMMDD')),
    ('Maisy Smith', 26, TO_DATE('20190117', 'YYYYMMDD')),
    ('Stephanie Mendez', 64, TO_DATE('19810504', 'YYYYMMDD')),
    ('Jack Harkness', 38, TO_DATE('20080608', 'YYYYMMDD'));

-- Insert the following data for specializations:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (vet_id, species_id)
VALUES
    (
        (SELECT id from vets WHERE name = 'William Tatcher'), 
        (SELECT id from species WHERE name = 'Pokemon')
        ),
    (
        (SELECT id from vets WHERE name = 'Stephanie Mendez'), 
        (SELECT id from species WHERE name = 'Pokemon')
        ),
    (
        (SELECT id from vets WHERE name = 'Stephanie Mendez'), 
        (SELECT id from species WHERE name = 'Digimon')
        ),
    (
        (SELECT id from vets WHERE name = 'Jack Harkness'), 
        (SELECT id from species WHERE name = 'Pokemon')
        );


-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
    (1, 1, TO_DATE('20200524', 'YYYYMMDD')),
    (1, 3, TO_DATE('20200722', 'YYYYMMDD')),
    (2, 4, TO_DATE('20210202', 'YYYYMMDD')),

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
    (3, 2, TO_DATE('20200105', 'YYYYMMDD')),
    (3, 2, TO_DATE('20200308', 'YYYYMMDD')),
    (3, 2, TO_DATE('20200514', 'YYYYMMDD')),

-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
    (4, 3, TO_DATE('20210504', 'YYYYMMDD')),
    (5, 4, TO_DATE('20210224', 'YYYYMMDD')),
    (6, 2, TO_DATE('20191221', 'YYYYMMDD')),

-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
    (6, 1, TO_DATE('20200810', 'YYYYMMDD')),
    (6, 2, TO_DATE('20210407', 'YYYYMMDD')),
    (7, 3, TO_DATE('20190929', 'YYYYMMDD')),

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
    (8, 4, TO_DATE('20201003', 'YYYYMMDD')),
    (8, 4, TO_DATE('20201104', 'YYYYMMDD')),
    (9, 2, TO_DATE('20190124', 'YYYYMMDD')),

-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
    (9, 2, TO_DATE('20190515', 'YYYYMMDD')),
    (9, 2, TO_DATE('20200227', 'YYYYMMDD')),
    (9, 2, TO_DATE('20200803', 'YYYYMMDD')),

-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.
    (10, 3, TO_DATE('20200524', 'YYYYMMDD')),
    (10, 1, TO_DATE('20210111', 'YYYYMMDD'));

