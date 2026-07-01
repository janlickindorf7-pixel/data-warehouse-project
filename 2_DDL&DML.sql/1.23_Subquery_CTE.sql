-- Subquery 

SELECT  *
FROM  (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_year_avg IS NOT NULL
) AS valid_salaries
LIMIT 10; 


-- CTE 

WITH valid_salaries AS (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_year_avg IS NOT NULL
)
SELECT * 
FROM valid_salaries;


-- SCENARIO 1 -> Subquery in SELECT. 

SELECT job_title_short,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact          
    )   AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10; 


-- SCENARIO 2 -> Subquery in FROM. 

SELECT 
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact   
        WHERE job_work_from_home = TRUE       
    )   AS market_median_salary

FROM (
    SELECT
    job_title_short,
    salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs

WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY median_salary DESC
LIMIT 10; 

-- SCERNARIO 3 -> Sebquery in HAVING

SELECT 
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact   
        WHERE job_work_from_home = TRUE       
    )   AS market_median_salary

FROM (
    SELECT
    job_title_short,
    salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs

WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact   
        WHERE job_work_from_home = TRUE    
)
LIMIT 10;

-- CTE Example 

WITH title_median AS (
SELECT
    job_title_short,
    job_work_from_home,
    MEDIAN(salary_year_avg)::INT AS median_salary
FROM job_postings_fact
WHERE job_country = 'Poland'
GROUP BY
    job_title_short,
    job_work_from_home
)

SELECT 
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r 
INNER JOIN title_median AS o 
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;

-- EXSIST 

SELECT *
FROM range(3) AS src(key);
-
SELECT *
FROM range(2) AS tgt(key);
--
SELECT *
FROM range(3) AS src(key)
WHERE EXISTS (
    SELECT 1
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);
--
SELECT *
FROM range(3) AS src(key)
WHERE NOT EXISTS (
    SELECT 1
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);



