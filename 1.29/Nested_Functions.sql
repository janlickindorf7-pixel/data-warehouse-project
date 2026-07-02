-- Array Intro 
SELECT ['python', 'sql','r'] AS skills_array;



WITH skills AS (
    SELECT 'python' AS skill
    UNION ALL 
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), 
skills_array AS (
    SELECT LIST(skill) AS skills 
    FROM skills
)

SELECT 
    skills [1] AS first_skill
FROM skills_array;

-- Struct Intro 
SELECT { skill: 'python', type: 'programming' } AS skill_struct;


WITH skill_struct AS (
SELECT 
    STRUCT_PACK(
        skill := 'python',
        type  := 'programming'
    ) AS s
)
SELECT 
    s.skill,
    s.type
FROM skill_struct;

    SELECT 'python' AS skill, 'programming' AS type
    UNION ALL 
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming';

    