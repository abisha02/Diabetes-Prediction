SELECT * FROM diabetics.`copy of diabetes_prediction`;

# 1. Retrieve the Patient_id and ages of all patients.
SELECT patient_id, age
FROM diabetics.`copy of diabetes_prediction`;

# 2. Select all female patients who are older than 40.
SELECT EmployeeName,gender,age
FROM diabetics.`copy of diabetes_prediction`
WHERE age > 40;

# 3. Calculate the average BMI of patients.
SELECT AVG (bmi) as avg_bmi
FROM diabetics.`copy of diabetes_prediction`;

# 4. List patients in descending order of blood glucose levels
SELECT EmployeeName,blood_glucose_level
FROM diabetics.`copy of diabetes_prediction`
ORDER BY blood_glucose_level DESC;

# 5.Find patients who have hypertension and diabetes
SELECT EmployeeName,hypertension,diabetes 
FROM diabetics.`copy of diabetes_prediction`
WHERE hypertension and diabetes < 1;

# 6. Determine the number of patients with heart disease
SELECT EmployeeName,heart_disease
FROM diabetics.`copy of diabetes_prediction`
WHERE heart_disease < 1;

# 7. Group patients by smoking history and count how many smokers and non-smokers 
#    there are ?
SELECT smoking_history,count(*) as count
FROM diabetics.`copy of diabetes_prediction`
GROUP BY smoking_history;

# 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
SELECT Patient_id
FROM diabetics.`copy of diabetes_prediction`
WHERE bmi > (SELECT AVG(bmi)FROM diabetics.`copy of diabetes_prediction`) ;

#9.Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
SELECT EmployeeName,HbA1c_level
FROM diabetics.`copy of diabetes_prediction`
WHERE HbA1c_level = (SELECT MAX(HbA1c_level) FROM diabetics.`copy of diabetes_prediction`)
   OR HbA1c_level = (SELECT MIN(HbA1c_level) FROM diabetics.`copy of diabetes_prediction`);

# 10. Calculate the age of patients in years (assuming the current date as of now).

SELECT 
    EmployeeName,
    TIMESTAMPDIFF(YEAR, age, CURDATE()) AS age_in_years
FROM diabetics.`copy of diabetes_prediction`;

# 11. Rank patients by blood glucose level within each gender group.

select *,RANK() 
OVER (PARTITION BY gender ORDER BY blood_glucose_level) as Rankss 
FROM diabetics.`copy of diabetes_prediction`;

# 12. Update the smoking history of patients who are older than 50 to "Ex-smoker."

UPDATE diabetics.`copy of diabetes_prediction`
SET smoking_history = "Ex-smoker"
WHERE age > 50;

# 13. Insert a new patient into the database with sample data.

INSERT INTO diabetics.`copy of diabetes_prediction` VALUES 
('ABISHA', 'PT601', 'Female', 23, 0, 0, 'No', 25.12, 5.2, 80, 0);

# 14 .Delete all patients with heart disease from the database 

DELETE FROM diabetics.`copy of diabetes_prediction`
WHERE heart_disease = 1;

# 15. Find patients who have hypertension but not diabetes using the EXCEPT operator
#call test
SELECT * 
FROM diabetics.`copy of diabetes_prediction` as d1
WHERE hypertension = 1 
AND NOT EXISTS  
( SELECT 1 
FROM diabetics.`copy of diabetes_prediction` as d2 
WHERE d1.patient_id = d2.patient_id AND d2.diabetes = 1);

SELECT * 
FROM diabetics.`copy of diabetes_prediction`
WHERE hypertension = 1
EXCEPT
SELECT * 
FROM diabetics.`copy of diabetes_prediction`
WHERE diabetes = 1;

# 16. Define a unique constraint on the "patient_id" column to ensure its values are unique

ALTER TABLE diabetics.`copy of diabetes_prediction`
ADD CONSTRAINT unique_patient_id unique (patient_id);

# 17. Create a view that displays the Patient_ids, ages, and BMI of patients.
CREATE VIEW Patient_view AS
SELECT patient_id, age, bmi
FROM diabetics.`copy of diabetes_prediction`;

SELECT * FROM patient_view; 

# 18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity.

# 1. Normalization: Ensure the database schema is normalized to eliminate data redundancy and dependency issues. 
# 2. Use of Foreign Keys: Implement foreign keys to establish relationships between tables. 
# 3. Unique Constraints: Enforce unique constraints on columns where appropriate to prevent duplicate data entries.
# 4. Atomicity: Ensure that each table stores data related to a single entity or concept, adhering to the principle of atomicity. 
# 5. Consistent Data Types: Use consistent data types across related tables for fields that represent the same type of data. 


# 19. Explain how you can optimize the performance of SQL queries on this dataset.

# 1. Use Indexes: Indexes help speed up data retrieval by providing quick access to rows based on indexed columns. 
# 2. Optimize Joins: Use appropriate join types (e.g., INNER JOIN, LEFT JOIN) based on the relationships between tables.
# 3. Limit Results: Limit the number of rows returned by queries using the LIMIT clause, especially for queries that return large result sets. 
# 4. **Avoid SELECT ***: Instead of selecting all columns using SELECT *, explicitly specify only the required columns in the SELECT statement. 
# 5. Optimize WHERE Clause: Use selective and indexed columns in the WHERE clause to filter data efficiently. 
# 6. Use Stored Procedures: Stored procedures reduce network traffic, promote code reusability, and improve query performance by precompiling execution plans.

