-- UNION -> ZWRACA TABELE Z WARTOSCIAMI I Z TEJ I Z TEJ, BEZ DUPLIKATOW
chyba ze all, wtedy duplikaty sa zawarte

SELECT UNNEST([1, 1, 1, 2])
UNION ALL
SELECT UNNEST([1, 1, 3]);

┌─────────────────────────────────────┐
│ unnest(main.list_value(1, 1, 1, 2)) │
│                int32                │
├─────────────────────────────────────┤
│                                   3 │
│                                   2 │
│                                   1 │
└─────────────────────────────────────┘

-- INTERSECT -> ZWRACA WARTOSCI WSPOLNE DLA TABELI A I TABELI B, BEZ DUPLIKATOW
tak samo jak powyzej, jezeli all 

SELECT UNNEST([1, 1, 1, 2])
INTERSECT ALL
SELECT UNNEST([1, 1, 3]);

┌─────────────────────────────────────┐
│ unnest(main.list_value(1, 1, 1, 2)) │
│                int32                │
├─────────────────────────────────────┤
│                                   1 │
└─────────────────────────────────────┘


-- EXCEPT -> ZWRACA TABELE Z WARTOSCIAMI Z TABELI A, KTORYCH W TABELI B NIE ZNAJDZIEMY 
'except all' odejmuje nam jakby tabele a od tabeli b 

1.)
SELECT UNNEST([1, 1, 1, 2])
EXCEPT 
SELECT UNNEST([1, 1, 3]);

┌─────────────────────────────────────┐
│ unnest(main.list_value(1, 1, 1, 2)) │
│                int32                │
├─────────────────────────────────────┤
│                                   2 │
└─────────────────────────────────────┘

2.) 
SELECT UNNEST([1, 1, 1, 2])
EXCEPT ALL
SELECT UNNEST([1, 1, 3]);

┌─────────────────────────────────────┐
│ unnest(main.list_value(1, 1, 1, 2)) │
│                int32                │
├─────────────────────────────────────┤
│                                   1 │
│                                   2 │
└─────────────────────────────────────┘

-- EXAMPLE 

-- TYMCZASOWA Z OFERTAMI PRACY NA 2023

CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

-- TYMCZASOWA Z OFERTAMI PRACY NA 2024

CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

-- UNIKALNE Z LAT 2023 I 2024

SELECT 
    'jobs_2023' AS table_name,
    COUNT(*) AS record_count
FROM jobs_2023
UNION
SELECT 
    'jobs_2024' AS table_name,
    COUNT(*) AS record_count
FROM jobs_2024;

-- JAKIE OFERTY POJAWILY SIE I W 23 I W 24, LICZAC DUPLIKATY 

SELECT * FROM jobs_2023
UNION all
SELECT * FROM jobs_2024;

-- JAKIE OFERTY POJAWILY SIE W 23 ALE W 24 JUZ NIE?

SELECT * FROM jobs_2023
EXCEPT
SELECT * FROM jobs_2024;

-- KTORE OGLOSZENIA O PRACE POZOSTAJA W TABELI A BO WYCIAGNECIU
Z NIEJ WSZYSTKICH Z TABELI B, JEDEN DO JEDEN? 

SELECT * FROM jobs_2023
EXCEPT ALL 
SELECT * FROM jobs_2024;

-- KTORE POJAWIAJA SIE W LATACH I 23 I 24

SELECT * FROM jobs_2023
INTERSECT 
SELECT * FROM jobs_2024;

-- KTORE POJAWIAJA SIE W OBU LATACH 

SELECT * FROM jobs_2023
INTERSECT ALL
SELECT * FROM jobs_2024;







