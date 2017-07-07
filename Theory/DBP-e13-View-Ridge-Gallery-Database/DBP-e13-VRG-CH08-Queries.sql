/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 08			*/
/*																				*/
/*	The View Ridge Gallery (VRG) - Query Statements								*/
/*																				*/
/*	These are the Microsoft SQL Server 2008R2/2012 SQL code solutions			*/
/*																				*/
/********************************************************************************/

USE DBP_e13_VRG
GO


/* The SQL Subquery Syntax														*/

/* *** SQL =Qery-CH08-01 *** */
SELECT	A.FirstName, A.lastName
FROM	ARTIST AS A
WHERE	A.ArtistID IN
		(SELECT	W.ArtistID
		 FROM	WORK W
		 WHERE	W.Title = 'Blue Interior');

/* The SQL Correlated Subquery Syntax											*/
/* *** SQL =Qery-CH08-02 *** */

SELECT	W1.Title, W1.Copy
FROM	WORK AS W1
WHERE	W1.Title IN
		(SELECT	W2.Title
		 FROM	WORK AS W2
		 WHERE	W1.Title = W2.Title
			AND	W1.WorkID <> W2.WorkID);



/* *** SQL-Query-CH08-03 *** */
SELECT	W1.Title, W1.Copy
FROM	WORK AS W1
WHERE	W1.WorkID IN
		(SELECT		W2.WorkID
		 FROM		WORK AS W2
		 WHERE		W1.Title = W2.Title
		 	AND		W1.WorkID <> W2.WorkID);




/********************************************************************************/

USE DBP_e13_CH08
GO


CREATE  TABLE EMPLOYEE_08(
	EmployeeNumber	Int 			NOT NULL,
	LastName        Char(25) 		NOT NULL,
	Email 			VarChar(100)	NOT NULL UNIQUE,
	Department		Char(35)		NOT NULL DEFAULT 'Human Resources',
	DeptPhone		Char(12)		NULL,
	CONSTRAINT 	EMPLOYEE_08_PK 		PRIMARY KEY(EmployeeNumber),
	);
						
INSERT INTO EMPLOYEE_08 VALUES (
	100, 'Johnson', 'JJ@somewhere.com', 'Accounting', '834-1100');
INSERT INTO EMPLOYEE_08 VALUES (
	200, 'Abernathy', 'MA@somewhere.com', 'Finance', '834-2100');
INSERT INTO EMPLOYEE_08 VALUES (
	300, 'Smathers', 'LS@somewhere.com', 'Finance', '834-21000');
INSERT INTO EMPLOYEE_08 VALUES (
	400, 'Caruthers', 'TC@somewhere.com', 'Accounting', '834-1100');
INSERT INTO EMPLOYEE_08 VALUES (
	500, 'Jackson', 'TJ@somewhere.com', 'Production', '834-4100');
INSERT INTO EMPLOYEE_08 VALUES (
	600, 'Caldera', 'EC@somewhere.com', 'Legal', '834-3100');
INSERT INTO EMPLOYEE_08 VALUES (
	700, 'Bandalone', 'RB@somewhere.com', 'Legal', '834-3100');


/* *** SQL-Query-CH08-04 *** */
SELECT	E1.Department, E1.DeptPhone
FROM	EMPLOYEE_08 AS E1
WHERE	E1.Department IN
		(SELECT	E2.Department
		 FROM	EMPLOYEE_08 AS E2
		 WHERE	E1.Department = E2.Department
			AND	E1.DeptPhone <> E2.DeptPhone);
			

/* *** SQL-Query-CH08-05 *** */
SELECT	E1.Department, E1. DeptPhone
FROM	EMPLOYEE_08 AS E1
WHERE	EXISTS
		(SELECT	E2.Department
		 FROM	EMPLOYEE_08 AS E2
		 WHERE	E1.Department = E2.Department
			AND	E1.DeptPhone <> E2.DeptPhone);
			
/********************************************************************************/

USE DBP_e13_VRG
GO

/* *** SQL-Query-CH08-05 *** */			
SELECT	A.FirstName, A.LastName
FROM	ARTIST AS A
WHERE	NOT EXISTS
		(SELECT	C.CustomerID
		 FROM	CUSTOMER AS C
		 WHERE	NOT EXISTS
				(SELECT	CAI.CustomerID
				 FROM	CUSTOMER_ARTIST_INT AS CAI
				 WHERE	C.CustomerID= CAI.CustomerID
					AND	A.ArtistID = CAI.ArtistID));


