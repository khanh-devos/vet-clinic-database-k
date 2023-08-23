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


