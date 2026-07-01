CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

DROP DATABASE IF EXISTS jobs_mart;

SELECT *
FROM information_schema.schemata;


USE jobs_mart; 
CREATE SCHEMA staging; 

   

SELECT *
FROM    information_schema.tables
WHERE table_catalog = 'jobs_mart';

DROP TABLE MAIN.preferred_roles;

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES 
    (1, 'Data Engineer '),
    (2, 'Senior Data Engineer');

SELECT *
FROM staging.preferred_roles; 

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES 
    
    (3, 'Software Engineer');

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id=2; 

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE staging.preferred_roles
RENAME TO prority_roles; 

SELECT *
FROM staging.prority_roles; 

ALTER TABLE staging.prority_roles
RENAME COLUMN preferred_role TO priority_lvl;

ALTER TABLE staging.prority_roles
ALTER COLUMN priority_lvl TYPE integer;

UPDATE staging.prority_roles
SET priority_lvl = 3 
WHERE role_id = 3; 
