--   C r e a t e   D a t a b a s e

--ALTER DATABASE HealthMonitorDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--ALTER DATABASE HealthMonitorDb SET MULTI_USER;


USE master;
 
DROP DATABASE IF EXISTS HealthMonitorDb; 
CREATE DATABASE HealthMonitorDb;
GO
 
USE HealthMonitorDb;
GO
-------------------------------------------------------------------------------
-- Create Database Tables
-------------------------------------------------------------------------------

CREATE TABLE Users
(
	id       INT          NOT NULL IDENTITY PRIMARY KEY,
	username NVARCHAR(20) NOT NULL, --F, L name
	email    NVARCHAR(20) NOT NULL,
	password NVARCHAR(20) NOT NULL, --Health01,Require encrypted
);

CREATE UNIQUE NONCLUSTERED INDEX Idx_Username ON Users(username);

SET IDENTITY_INSERT Users ON;
INSERT INTO Users(id, username, email, password)
	VALUES(1, N'Paul, Brown',   N'PaulB01@hotmail.com', N'Health01'),
	      (2, N'Jacob, Miller', N'JacobM01@yahoo.com',  N'Health01'),
	      (3, N'Devon, Clark',  N'DevonC3@gmail.com',   N'Health01'),
	      (4, N'Jack, Ripper',  N'JackR20@edu.com',     N'Health01'),
	      (5, N'Sarah, Conner', N'SarahC@aol.com',      N'Health01');
SET IDENTITY_INSERT Users OFF;

SELECT * FROM Users;

-- Create Exercise Table
CREATE TABLE Exercise
(
	id       INT          NOT NULL IDENTITY PRIMARY KEY,
	height   INT          NOT NULL,
	weight   INT          NOT NULL,
	exerType NVARCHAR(20) NOT NULL, 
	strTime  TIME(0),
	endTime  TIME(0),
	exerDate DATE,
	userid   INT          NOT NULL FOREIGN KEY REFERENCES Users(id)
);

SET IDENTITY_INSERT Exercise ON;
INSERT INTO Exercise(id, height, weight, exerType, strTime, endTime, exerDate, userid)
	VALUES(1, '71', '197', 'cardio',   '1:00PM',  '2:30PM',  '2020-01-02', 1), 
	      (2, '71', '192', 'strength', '10:00AM', '11:30AM', '2020-01-09', 1),
	      (3, '70', '180', 'aerobic',  '7:00AM',  '9:30AM',  '2020-03-12', 2),
	      (4, '52', '140', 'endurance','9:00AM',  '11:00AM', '2020-01-02', 3),
	      (5, '66', '120', 'cardio',   '9:00AM',  '10:30AM', '2020-07-20', 5);
SET IDENTITY_INSERT Exercise OFF;

SELECT * FROM Exercise;

-- Create BloodPressure Table
CREATE TABLE BloodPressure
( 
	id                  INT          NOT NULL IDENTITY PRIMARY KEY,
	[level of Severity] NVARCHAR(20) NOT NULL,
	systolic            NUMERIC(20)  NOT NULL,
	diastolic           NUMERIC(20)  NOT NULL,
	pulse               NUMERIC(20)  NOT NULL,
	age                 NUMERIC(20)  NOT NULL,
	userid              INT          NOT NULL FOREIGN KEY REFERENCES Users(id)
);

SET IDENTITY_INSERT BloodPressure ON;
INSERT INTO BloodPressure(id, [level of Severity], systolic, diastolic, pulse, age, userid)
	VALUES(1, 'Normal',   118, 63, 71, 22, 1),
	      (2, 'Mild' ,    122, 79, 70, 22, 1),
	      (3, 'Moderate', 131, 80, 65, 55, 3),
	      (4, 'Severe',   181, 95, 88, 55, 3),
		  (5, 'Normal',   110, 60, 66, 46, 5);
SET IDENTITY_INSERT BloodPressure OFF;

SELECT * FROM BloodPressure;

--Create Meals Table
CREATE TABLE Meals
( 
	id           INT          NOT NULL IDENTITY PRIMARY KEY,
	mealType     NVARCHAR(20) NOT NULL,
	cost         MONEY        NOT NULL,
	fruits       NVARCHAR(20) NOT NULL,
	protein      NVARCHAR(20) NOT NULL,
	calories     NUMERIC(20)  NOT NULL,
	userid       INT          NOT NULL FOREIGN KEY REFERENCES Users(id)
);

SET IDENTITY_INSERT Meals ON;
INSERT INTO Meals(id, mealType, cost, fruits, protein, calories, userid)
	VALUES(1, 'breakfast', '$3.00', 'banana',       '1.3 g', '105', 3),
		  (2, 'lunch',     '$6.00', 'apple',        '0.5 g', '95',  3),
		  (3, 'dinner',    '$10.00','banana',       '1.3 g', '105', 2),
		  (4, 'breakfast', '$3.80', 'orange',       '0.9 g', '45',  4),
		  (5, 'lunch',     '$12.00','strawberries', '0.1 g', '4',   3);
SET IDENTITY_INSERT Meals OFF;

SELECT * FROM Meals;

--Create Doctor Table
CREATE TABLE Doctor
( 
	id           INT        NOT NULL IDENTITY PRIMARY KEY,
	F_Name     NVARCHAR(20) NOT NULL,
	L_Name     NVARCHAR(20) NOT NULL,
	specialty  NVARCHAR(20) NOT NULL,
	hospName   NVARCHAR(20) NOT NULL,
	address    NVARCHAR(20) NOT NULL,
	city       NVARCHAR(20) NOT NULL,
	region     NVARCHAR(20) NOT NULL,	
	zipcode    INT          NOT NULL,
	phoneNum   NVARCHAR(20) NOT NULL,
	userid     INT          NOT NULL FOREIGN KEY REFERENCES Users(id)
);

SET IDENTITY_INSERT Doctor ON;
INSERT INTO Doctor(id, F_Name, L_Name, specialty, hospName, address, city, region, zipcode, phoneNum, userid)
	VALUES(1, 'Bob',    'Francis', 'Emergency Medicine',  'St Johns Medical', '123 West St', 'Oakland', 'California', '12345','(212) 304-1020', 1),
		  (2, 'Patrica', 'Day',    'Internal Medicine',   'St Johns Medical', '123 West St', 'Oakland', 'California', '12345','(212) 304-1040', 2),
          (3, 'Jessica', 'Flecher','Family Medicine',     'St Johns Medical', '123 West St', 'Oakland', 'California', '12345','(212) 304-4018', 3),
          (4, 'Bobby', 'Picther',  'Diagnostic Radiology','St Johns Medical', '123 West St', 'Oakland', 'California', '12345','(212) 504-1000', 4),
          (5, 'Barbara', 'Blake ', 'Sport Medicine',      'St Johns Medical', '123 West St', 'Oakland', 'California', '12345','(212) 304-1015', 5);
SET IDENTITY_INSERT Doctor OFF;

SELECT * FROM Doctor;

--Create Appointment Table
CREATE TABLE Appointment
( 
	id           INT          NOT NULL IDENTITY PRIMARY KEY,
	bookedDate   DATE,
	strTime      TIME(0),
	endTime      TIME(0),	
	phoneNum     NVARCHAR(20) NOT NULL,
	diagnosis    NVARCHAR(50) NOT NULL,	
	doctorid     INT          NOT NULL FOREIGN KEY REFERENCES doctor(id),
	userid       INT          NOT NULL FOREIGN KEY REFERENCES Users(id)
);

SET IDENTITY_INSERT Appointment ON;
INSERT INTO Appointment(id, bookedDate, strTime, endTime, phoneNum, diagnosis, doctorid, userid)
	VALUES(1, '2020-06-07', '1:00PM',   '2:00PM', '(212) 500-5000', 'dehydration',             1, 2),
	      (2, '2020-08-01', '11:00AM', '12:00AM', '(212) 500-5000', 'abdominal paracentesis',  2, 1),
	      (3, '2020-03-07', '7:00AM',  '8:00AM',  '(212) 500-5000', 'arthrocentesis',          2, 5),
	      (4, '2020-10-01', '2:00PM',  '3:00PM',  '(212) 500-5000', 'hypertension',            3, 3),
	      (5, '2020-04-09', '8:00AM',  '9:00AM',  '(212) 500-5000', 'diabetes',                3, 4);
SET IDENTITY_INSERT Appointment OFF;

SELECT * FROM Appointment;

SELECT A.bookedDate, A.strTime, A.endTime, A.diagnosis, U.username 
FROM Appointment AS A
INNER JOIN Users AS U
ON U.id = A.userid;

SELECT U.Username, B.[level of Severity], b.systolic, b.diastolic, b.pulse  
FROM Users AS U
INNER JOIN BloodPressure AS B
ON U.id = B.id
WHERE [level of Severity] = 'Normal';
