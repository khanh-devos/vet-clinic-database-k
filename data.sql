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
