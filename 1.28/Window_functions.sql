-- Count rows - Agregation Only 

SELECT 
    COUNT(*)
FROM 
    job_postings_fact;

-- NO I TAKIE COS WYCHODZI >>
┌────────────────┐
│  count_star()  │
│     int64      │
├────────────────┤
│    1615930     │
│ (1.62 million) │
└────────────────┘


-- Count rows but by Window Function

SELECT 
    job_id,
    COUNT(*) OVER ()
FROM 
    job_postings_fact
    LIMIT 10; 

┌────────┬─────────────────┐
│ job_id │ count() OVER () │
│ int32  │      int64      │
├────────┼─────────────────┤
│   4593 │         1615930 │
│   4594 │         1615930 │
│   4595 │         1615930 │
│   4596 │         1615930 │
│   4597 │         1615930 │
│   4598 │         1615930 │
│   4599 │         1615930 │
│   4600 │         1615930 │
│   4601 │         1615930 │
│   4602 │         1615930 │
└────────┴─────────────────┘




-- PARTITION BY 

SELECT 
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short, company_id
    )
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER  BY 
    RANDOM()
LIMIT 10;

-- ORDER BY 

SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        ORDER BY salary_hour_avg
    ) AS rank_hour_salary 
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER  BY 
    salary_hour_avg DESC 
LIMIT 10;

┌─────────┬───────────────────────────┬─────────────────┬──────────────────┐
│ job_id  │      job_title_short      │ salary_hour_avg │ rank_hour_salary │
│  int32  │          varchar          │     double      │      int64       │
├─────────┼───────────────────────────┼─────────────────┼──────────────────┤
│  256566 │ Data Analyst              │           391.0 │                1 │
│ 1004296 │ Data Scientist            │           250.0 │                2 │
│  110897 │ Data Analyst              │           242.5 │                3 │
│  646328 │ Data Scientist            │           237.5 │                4 │
│  210821 │ Data Scientist            │           225.0 │                5 │
│ 1203880 │ Data Engineer             │           221.0 │                6 │
│ 1056728 │ Machine Learning Engineer │           220.0 │                7 │
│  193693 │ Data Analyst              │           210.0 │                8 │
│  452720 │ Data Analyst              │           200.0 │                9 │
│  833111 │ Data Scientist            │           200.0 │                9 │
└─────────┴───────────────────────────┴─────────────────┴──────────────────┘

-- ORDER BY & PARTITION BY 

SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short 
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL AND 
    job_title_short = 'Data Engineer'
ORDER  BY 
    job_title_short,
    job_posted_date
LIMIT 10;

-- Ranking functions 
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    DENSE_RANK() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hour_salary 
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER  BY 
    salary_hour_avg DESC 
LIMIT 20;

-- ROW NUMBER 
SELECT 
    *,
    ROW_NUMBER() OVER (
        ORDER BY job_posted_date
    )
FROM 
    job_postings_fact
ORDER BY 
    job_posted_date
LIMIT 20;


-- LAG 
SELECT 
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ),
    salary_year_avg -   LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change
FROM 
    job_postings_fact
WHERE salary_year_avg IS NOT NULL 
ORDER BY company_id, job_posted_date
LIMIT 60;



