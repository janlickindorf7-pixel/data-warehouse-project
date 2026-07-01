-- LENGTH -> LICZY DLUGOSC TEKSTU
SELECT CHAR_LENGTH('SQL');
-- UPPER/LOWER -> ZMIENIA NA DUZE ALBO MALE LITERY 
SELECT UPPER('sql');
SELECT LOWER('SQL');
--LEFT/RIGHT/SUBSTRING -> WYODREBNIA NAM 
SELECT LEFT('SQL',2);
┌──────────────────┐
│ "left"('SQL', 2) │
│     varchar      │
├──────────────────┤
│ SQ               │
└──────────────────┘
SELECT RIGHT('SQL',2);
┌───────────────────┐
│ "right"('SQL', 2) │
│      varchar      │
├───────────────────┤
│ QL                │
└───────────────────┘
SELECT SUBSTRING('SQL',2,1);
┌───────────────────────────────┐
│ main."substring"('SQL', 2, 1) │
│            varchar            │
├───────────────────────────────┤
│ Q                             │
└───────────────────────────────┘


-- CONCAT -> LACZENIE TEKSTOW
SELECT CONCAT('SQL' || '-' ||'Functions');
┌─────────────────────────────────┐
│ concat('SQL', '-', 'Functions') │
│             varchar             │
├─────────────────────────────────┤
│ SQL-Functions                   │
└─────────────────────────────────┘
--TRIM/LTRIM/RTRIM -> TWORZY MIEJSCE W NAWIASACH ALBO NIE
SELECT TRIM(' SQL ');
-- REPLACE -> ZMIANA NA INNE GUNWO
SELECT REPLACE('SQL','Q','_');
┌────────────────────────────┐
│ "replace"('SQL', 'Q', '_') │
│          varchar           │
├────────────────────────────┤
│ S_L                        │
└────────────────────────────┘
-- FINAL EXAMPLE 

WITH title_lower AS (
    SELECT  
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean 
    FROM job_postings_fact
)

SELECT 
    job_title,

    CASE 
        WHEN job_title_clean LIKE '%data%' 
            AND job_title_clean LIKE '%analyst%' THEN 'data analyst'
        WHEN job_title_clean LIKE '%data%' 
            AND job_title_clean LIKE '%engineer%' THEN 'data engineer'
        WHEN job_title_clean LIKE '%data%' 
            AND job_title_clean LIKE '%scientist%' THEN 'data scientist'
        ELSE 'Other'

        END AS job_title_category

FROM title_lower
ORDER BY RANDOM()
LIMIT 30; 