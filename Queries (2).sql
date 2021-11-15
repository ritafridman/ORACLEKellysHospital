-- classification
SELECT *
FROM patients
ORDER BY last_name DESC;

SELECT *
FROM patients
ORDER BY last_name ASC;

SELECT *
FROM Employee_detailes
ORDER BY last_name DESC;

SELECT *
FROM Employee_detailes
ORDER BY last_name ASC;

--use several tables (patients & doctor)
CREATE VIEW Patients_Doctors AS
SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name AS Patients , E.ID AS Doctor_ID , E.first_name || '  ' ||  E.last_name AS Treating_Doctor
FROM Employee_detailes E , patients P
WHERE E.id = P.treating_physician
ORDER BY p.last_name;

SELECT *  FROM patients_doctors;

--use several tables (patients & diagnosis)
CREATE VIEW Patients_Diagnosis AS
SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name AS Patients , D.disease , D.disease_detail , D.remarks
FROM diagnosis D , patients P
WHERE D.id = P.ID
ORDER BY p.last_name;

SELECT *  FROM patients_Diagnosis;

-- find patiens that registered during the last 3 month
SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name , p.entry_date
FROM patients P
WHERE p.entry_date BETWEEN SYSDATE-90  AND SYSDATE  ;

SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name , p.entry_date
FROM patients P
WHERE p.entry_date BETWEEN SYSDATE-180  AND SYSDATE  ;

SELECT  P.ID AS Patients_ID  , P.first_name || '  ' ||  P.last_name , p.entry_date
FROM patients P
WHERE p.entry_date BETWEEN SYSDATE-365  AND SYSDATE  ;


SELECT ID , role_code , department_code ,
count (*) 
OVER (PARTITION BY department_code ORDER BY department_code
ROWS 10 PRECEDING) department_total
FROM staff;

--In this project the RANGE function is not useful
SELECT d.last_blood_test_date  , 
count (*)
OVER ( ORDER BY last_blood_test_date 
RANGE  BETWEEN 90 PRECEDING AND 0 FOLLOWING  ) new_blood_test
FROM diagnosis d ;

SELECT patients.first_name || '  ' || patients.last_name AS patients_name , employee_detailes.first_name || ' ' || employee_detailes.last_name AS doctor_name , diagnosis.disease
FROM patients 
INNER JOIN employee_detailes 
ON patients.treating_physician = employee_detailes.id
INNER JOIN diagnosis
ON patients.id = diagnosis.id;

SELECT  d.disease_detail , count (*) 
FROM diagnosis d
GROUP BY d.disease_detail;

SELECT * 
FROM medication_basket
WHERE medication_code IN
(SELECT medication_code
FROM Patient_medication_linking_table);

-- not used mediseans
SELECT * 
FROM medication_basket
WHERE (SELECT count (*) 
FROM Patient_medication_linking_table
WHERE Patient_medication_linking_table.medication_code = medication_basket.medication_code) = 0;


