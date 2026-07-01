-- COALESCE - POMIJA WARTOSCI NULL I DAJE PIERWSZA JAKA NULLEM NIE JEST

SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM 
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL 
LIMIT 10;