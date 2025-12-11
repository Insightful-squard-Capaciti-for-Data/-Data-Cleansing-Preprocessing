-- Create a new table with standardized column names for easier querying
CREATE TABLE StudentsPerformance_Clean AS
SELECT
    gender,
    -- Rename columns with special characters to use snake_case
    `race/ethnicity` AS race_ethnicity,
    `parental level of education` AS parental_level_of_education,
    lunch,
    `test preparation course` AS test_preparation_course,
    `math score` AS math_score,
    `reading score` AS reading_score,
    `writing score` AS writing_score
FROM
    studentsperformance;

-- Label 1.1: Create a temporary table (StudentsPerformance_Unique) with only distinct rows
CREATE TABLE StudentsPerformance_Unique AS
SELECT DISTINCT
    gender,
    race_ethnicity,
    parental_level_of_education,
    lunch,
    test_preparation_course,
    math_score,
    reading_score,
    writing_score
FROM
    StudentsPerformance_Clean;
    
    
    -- Label 2.1: Drop the original table which may contain duplicates
DROP TABLE StudentsPerformance_Clean;

-- Label 2.2: Rename the unique table back to the standard clean name
ALTER TABLE StudentsPerformance_Unique RENAME TO StudentsPerformance_Clean;

-- Verification: Check the final row count
SELECT COUNT(*) FROM StudentsPerformance_Clean;

-- Create the final table including derived columns
CREATE TABLE StudentsPerformance_Transformed AS
SELECT
    *, -- Select all columns from the clean staging table

    -- Derived Column 1: Average Score
    (math_score + reading_score + writing_score) / 3 AS average_score,

    -- Derived Column 2: Pass/Fail Status (Pass if ALL scores are >= 40)
    CASE
        WHEN (math_score >= 40 AND reading_score >= 40 AND writing_score >= 40) THEN 'Pass'
        ELSE 'Fail'
    END AS pass_fail_status

FROM
    StudentsPerformance_Clean;

    
    
