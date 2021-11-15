--create stuff table
CREATE TABLE Staff
(
ID NUMBER(9) PRIMARY KEY,
role_code NUMBER(5) ,
department_code NUMBER(5) 
)
--create employee details table
CREATE TABLE Employee_detailes
(
ID NUMBER(9) PRIMARY KEY,
first_name VARCHAR2(30),
last_name VARCHAR2(30),
address VARCHAR2(30),
postal_code NUMBER(7),
phone_number NUMBER(10),
fax_number NUMBER(10),
email VARCHAR2(30),
FOREIGN KEY (ID) REFERENCES Staff (ID) 
)
--create patients table
CREATE TABLE Patients
(
ID NUMBER(9) PRIMARY KEY,
first_name VARCHAR2(30),
last_name VARCHAR2(30),
address VARCHAR2(30),
postal_code NUMBER(7),
phone_number NUMBER(10),
fax_number NUMBER(10),
email VARCHAR2(30),
room_number NUMBER(4),
treating_physician NUMBER(9),
bed_number NUMBER(4),
entry_date DATE,
department_code NUMBER(5),
FOREIGN KEY (treating_physician) REFERENCES Employee_detailes (ID)
)
--create medication basket table
CREATE TABLE Medication_basket
(
medication_code NUMBER(10) PRIMARY KEY,
medication_name VARCHAR2(40),
drag_description VARCHAR2(120)
)
--create diagnosis table
CREATE TABLE Diagnosis
(
ID NUMBER(9) PRIMARY KEY,
disease VARCHAR2(30),
disease_detail VARCHAR2(100),
backround_diseases VARCHAR2(150),
regular_medications VARCHAR2(50),
last_blood_test_date DATE,
remarks VARCHAR2(100),
FOREIGN KEY (ID) REFERENCES Patients (ID) 
)
--create room occupancy table
CREATE TABLE Room_occupancy
(
department_code NUMBER(5),
room_number NUMBER(4),
bed_number NUMBER(4),
vacancy NUMBER(1),
patient_ID NUMBER(9),
PRIMARY KEY ( department_code , room_number , bed_number)
)
--create patient medication linking table
CREATE TABLE Patient_medication_linking_table
(
ID NUMBER(9),
medication_code NUMBER(10),
FOREIGN KEY (ID) REFERENCES Patients (ID),
FOREIGN KEY (medication_code) REFERENCES Medication_basket (medication_code)
)
--insert staff table
INSERT ALL
    INTO Staff (ID , role_code , department_code) VALUES(326584632 , 36456 , 60079)
    INTO Staff (ID , role_code , department_code) VALUES(462847619 , 49572 , 08478)
    INTO Staff (ID , role_code , department_code) VALUES(109836452 , 35556 , 74597)
    INTO Staff (ID , role_code , department_code) VALUES(200046826 , 49572 , 74597)
    INTO Staff (ID , role_code , department_code) VALUES(109384762 , 20048 , 12444)
    INTO Staff (ID , role_code , department_code) VALUES(572094766 , 14444 , 60079)
    INTO Staff (ID , role_code , department_code) VALUES(444326153 , 72634 , 33364)
    INTO Staff (ID , role_code , department_code) VALUES(672836451 , 36456 , 12444)
    INTO Staff (ID , role_code , department_code) VALUES(374891736 , 55586 , 22293)
    INTO Staff (ID , role_code , department_code) VALUES(374619273 , 22204 , 11152)
SELECT * FROM dual;

--insert employee details table
INSERT INTO Employee_detailes (ID) 
SELECT (ID) FROM staff;

UPDATE employee_detailes
SET first_name = 'liron', 
         last_name = 'shoham' , 
         address = 'albert 3 tel aviv' , 
         postal_code = 4527653, 
         phone_number = 053726396, 
         fax_number = 0321674532 , 
         email = 'lironsh@gmail.com'
WHERE ID = 326584632;

UPDATE employee_detailes
SET first_name = 'michel', 
         last_name = 'sasoni' , 
         address = 'shinkar 15 tel aviv' , 
         postal_code = 4527645, 
         phone_number = 053726397, 
         fax_number = 0321674597 , 
         email = 'michelsh@gmail.com'
WHERE ID = 462847619;

UPDATE employee_detailes
SET first_name = 'nina', 
         last_name = 'tonnu' , 
         address = 'sokolov 1 tel aviv' , 
         postal_code = 4527745, 
         phone_number = 053726398, 
         fax_number = 0321674598 , 
         email = 'ninato@gmail.com'
WHERE ID = 109836452;

UPDATE employee_detailes
SET first_name = 'rakel', 
         last_name = 'levi' , 
         address = 'albert 8 tel aviv' , 
         postal_code = 4527653, 
         phone_number = 053726399, 
         fax_number = 0321674599 , 
         email = 'rakelle@gmail.com'
WHERE ID = 200046826;

UPDATE employee_detailes
SET first_name = 'gal', 
         last_name = 'kaplan' , 
         address = 'osishkin 15 tel aviv' , 
         postal_code = 4537645, 
         phone_number = 053726371, 
         fax_number = 0321674571 , 
         email = 'galka@gmail.com'
WHERE ID = 109384762;

UPDATE employee_detailes
SET first_name = 'hen', 
         last_name = 'kaplan' , 
         address = 'golanim 15 lod' , 
         postal_code = 7136236, 
         phone_number = 053726375, 
         fax_number = 0321674575 , 
         email = 'hengo@gmail.com'
WHERE ID = 572094766;

UPDATE employee_detailes
SET first_name = 'raanan', 
         last_name = 'uri' , 
         address = 'gisin 4 lod' , 
         postal_code = 7136471, 
         phone_number = 053726350, 
         fax_number = 0321674550 , 
         email = 'raananur@gmail.com'
WHERE ID = 444326153;

UPDATE employee_detailes
SET first_name = 'shay', 
         last_name = 'dahan' , 
         address = 'ganim 11tel aviv' , 
         postal_code = 4569645, 
         phone_number = 053726346, 
         fax_number = 0321674546 , 
         email = 'shayda@gmail.com'
WHERE ID = 672836451;

UPDATE employee_detailes
SET first_name = 'orit', 
         last_name = 'atias' , 
         address = 'albert 15 tel aviv' , 
         postal_code = 4527653, 
         phone_number = 053726342, 
         fax_number = 0321674542 , 
         email = 'oritat@gmail.com'
WHERE ID = 374891736;

UPDATE employee_detailes
SET first_name = 'liora', 
         last_name = 'yaakobi' , 
         address = 'galis 15 petah tikva' , 
         postal_code = 5634556, 
         phone_number = 053726341, 
         fax_number = 0321674541 , 
         email = 'lioraya@gmail.com'
WHERE ID = 374619273;

--insert patients table
INSERT ALL
    INTO Patients
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date , department_code)
    VALUES(492736413 , 'liron' , 'revivo' , 'hazofit 1 tel aviv' , 6037462 , 0522286473 , 038476154 , 'lironrev@gmail.com' , 2019 , 109836452 , 4006 ,TO_DATE(' 2019-05-12' , 'yyyy-mm-dd') , 60079  )
    INTO Patients 
     (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date , department_code)
     VALUES(948710377 , 'yael' , 'zvi' , 'alon 3 kfar saba' , 3007738 , 0521117649 , 0384775621 , 'yaelz@gmail.com' , 4362 , 572094766 , 1112 ,TO_DATE( '2019-01-04' , 'yyyy-mm-dd') , 11152)
    INTO Patients 
     (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date ,department_code)
    VALUES(602748364 , 'ran' , 'shemesh' , 'vered 3 tel aviv' , 4829846 , 0547826483 , 0363746251 , 'ranshemesh@gmail.com' , 3006 , 374619273 , 2006 ,TO_DATE( '2019-07-19' , 'yyyy-mm-dd') , 74597)
    INTO Patients
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date ,department_code)
    VALUES(035288574 , 'ron' , 'levin' , 'limor 19 kfar saba' , 3005738 , 0544739111 , 0377768215 , 'limorlevin@gmail.com' , 2087 , 200046826 , 3099 ,TO_DATE( '2019-09-09' , 'yyyy-mm-dd') , 11152)
    INTO Patients 
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date, department_code)
    VALUES(035788574 , 'lea' , 'shuli' , 'kalanit 19 petah tiqwa' , 4008531 , 0537465912 , 03485761998 , 'leashul@gmail.com' , 1006 , 326584632 , 3456 ,TO_DATE( '2019-11-11' , 'yyyy-mm-dd') , 74597)
    INTO Patients 
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date , department_code)
    VALUES(093674512 , 'ofer' , 'glili' , 'albert 28 petah tiqwa' , 4008532 , 0506518767 , 0376118893 , 'oferg@gmail.com' , 4367 , 462847619 , 2266 , TO_DATE('2019-11-12' , 'yyyy-mm-dd') , 60079)
    INTO Patients 
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date , department_code)
    VALUES(064783336 , 'shmuel' , 'lev' , 'oranit 32 or yehuda' , 3065367 , 0525634174 , 0367297555 , 'shmuellev@gmail.com' , 2999 , 444326153 , 2111 ,TO_DATE('2019-08-22' , 'yyyy-mm-dd') , 11152)
    INTO Patients 
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date , department_code)
    VALUES(236574826 , 'amir' , 'yaniv' , 'hanarkis 2 raanana' , 2004653 , 0524631474 , 0367237455 , 'amirya@gmail.com' , 2349 , 109384762 , 2131 , TO_DATE('2019-08-02' , 'yyyy-mm-dd') , 60079)
    INTO Patients 
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date , department_code)
    VALUES(462876513 , 'itay' , 'nevo' , 'shomron 4 raanana' , 2008653 , 0521631174 , 036937355 , 'itaynevo@gmail.com' , 3078 , 672836451 , 2133 ,TO_DATE( '2019-10-02' , 'yyyy-mm-dd') , 11152)
    INTO Patients 
    (ID , first_name , last_name , address , postal_code , phone_number , fax_number , email , room_number , treating_physician , bed_number , entry_date , department_code)
   VALUES(013674524 , 'ronit' , 'lev-ran' , 'shomron 9 raanana' , 2006653 , 0521631263 , 0369482355 , 'ronitlenr@gmail.com' , 2048 , 374891736 , 2456 ,TO_DATE( '2019-12-02' , 'yyyy-mm-dd') , 60079)
SELECT * FROM dual;

--insert diagnosis table
INSERT INTO Diagnosis (ID) 
SELECT (ID) FROM Patients;

UPDATE Diagnosis
SET disease = 'high temperature',
          disease_detail =  'high temperature',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2019-11-12' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 492736413;

UPDATE Diagnosis
SET disease = 'High blood pressure',
          disease_detail =  'High blood pressure',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2018-07-09' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 948710377;

UPDATE Diagnosis
SET disease = 'Chest pressures',
          disease_detail =  'Chest pressures',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2019-06-09' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 602748364;

UPDATE Diagnosis
SET disease = 'high temperature',
          disease_detail =  'high temperature',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2019-09-09' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 35288574;

UPDATE Diagnosis
SET disease = 'High blood pressure',
          disease_detail =  'High blood pressure',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2019-04-02' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 35788574;

UPDATE Diagnosis
SET disease = 'Chest pressures',
          disease_detail =  'Chest pressures',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2019-11-24' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 93674512;

UPDATE Diagnosis
SET disease = 'high temperature',
          disease_detail =  'high temperature',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2019-06-26' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 64783336;

UPDATE Diagnosis
SET disease = 'High blood pressure',
          disease_detail =  'High blood pressure',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2019-09-03' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 236574826;

UPDATE Diagnosis
SET disease = 'Chest pressures',
          disease_detail =  'Chest pressures',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2018-04-09' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 462876513;

UPDATE Diagnosis
SET disease = 'high temperature',
          disease_detail =  'high temperature',
           backround_diseases = 'NONE' ,
          regular_medications = 'NONE',
          last_blood_test_date = TO_DATE( '2018-03-09' , 'yyyy-mm-dd') , 
         remarks = 'supervision' 
WHERE ID = 13674524;

--insert medication basket table
INSERT ALL
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(3000576287 , 'gastro'  , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(1000583647 , 'normolog' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(3747222222 , 'photomidin' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(5883498233 , 'ogmentin' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(8483636635 , 'moxivit' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(3747272222 , 'moxipen' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(5883468833 , 'bepanten' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(6757867467 , 'tzeforal' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(1731233444 , 'revanol' , 'pill twice a day')
    INTO Medication_basket (medication_code, medication_name, drag_description) VALUES(5383498233 , 'miro' , 'pill twice a day')
SELECT * FROM dual;

--insert patient medication linking table
INSERT INTO Patient_medication_linking_table (ID) 
SELECT (ID) FROM Patients;

UPDATE Patient_medication_linking_table
SET medication_code = 3000576287
WHERE ID = 492736413;

UPDATE Patient_medication_linking_table
SET medication_code = 3747222222
WHERE ID = 948710377;

UPDATE Patient_medication_linking_table
SET medication_code = 3000576287
WHERE ID = 602748364;

UPDATE Patient_medication_linking_table
SET medication_code = 3747272222
WHERE ID = 35288574;

UPDATE Patient_medication_linking_table
SET medication_code = 1731233444
WHERE ID = 35788574;

UPDATE Patient_medication_linking_table
SET medication_code = 5383498233
WHERE ID = 93674512;

UPDATE Patient_medication_linking_table
SET medication_code = 1731233444
WHERE ID = 64783336;

UPDATE Patient_medication_linking_table
SET medication_code = 6757867467
WHERE ID = 236574826;

UPDATE Patient_medication_linking_table
SET medication_code = 1000583647
WHERE ID = 462876513;

UPDATE Patient_medication_linking_table
SET medication_code = 6757867467
WHERE ID = 13674524;

--insert room occupancy
INSERT INTO room_occupancy (DEPARTMENT_CODE , room_number , bed_number , vacancy , patient_id) 
SELECT p.DEPARTMENT_CODE , p.room_number , p.bed_number , 1 , ID FROM Patients p;





