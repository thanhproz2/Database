/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 10A			*/
/*																				*/
/*	The View Ridge Gallery (VRG) - User Function NameConcatenation				*/
/*																				*/
/*	These are the Microsoft SQL Server 2008 R2 / 2012 SQL code solutions		*/
/*																				*/
/********************************************************************************/

USE VRG
GO

CREATE FUNCTION dbo.NameConcatenation 

-- These are the input parameters
(
	@FirstName		CHAR(25),
	@LastName		CHAR(25)
)
RETURNS VARCHAR(60)
AS
BEGIN
	-- This is the variable that will hold the value to be returned
	DECLARE @FullName VARCHAR(60);

	-- SQL statements to concatenate the names in the proper order
	SELECT @FullName = RTRIM(@LastName);
	IF @FirstName IS NOT NULL
		SELECT @FullName = @FullName + ', ' + RTRIM(@FirstName);
	
	-- Return the concatentate name
	RETURN @FullName;
END


/************************************************************************/
USE VRG
GO

CREATE FUNCTION dbo.NameConcatenation 

-- These are the input parameters
(
	@FirstName		CHAR(25),
	@LastName		CHAR(25)
)
RETURNS VARCHAR(60)
AS
BEGIN
	-- This is the variable that will hold the value to be returned
	DECLARE @FullName VARCHAR(60)

	-- SQL statements to concatenate the names in the proper order
	SELECT @FullName = RTRIM(@LastName) + ', ' + RTRIM(@FirstName);
	
	-- Return the concatentate name
	RETURN @FullName
END


/************************************************************************/

SELECT		RTRIM(LastName)+', '+RTRIM(FirstName) AS CustomerName, 
			AreaCode, PhoneNumber, Email
FROM		CUSTOMER
ORDER BY	CustomerName;

/************************************************************************/

SELECT		dbo.NameConcatenation(FirstName, LastName) AS CustomerName, 
			AreaCode, PhoneNumber, Email
FROM		CUSTOMER
ORDER BY	CustomerName;

/************************************************************************/

SELECT		dbo.NameConcatenation(FirstName, LastName) AS ArtistName, 
			DateOfBirth, DateDeceased
FROM		ARTIST
ORDER BY	ArtistName;

/************************************************************************/
/* *** Figure 7-21 SQL-Query-CH07-04 ***							    */

SELECT		dbo.NameConcatenation(C.FirstName, C.LastName) AS CustomerName,
			dbo.NameConcatenation(A.FirstName, A.LastName) AS ArtistName
FROM		CUSTOMER AS C JOIN CUSTOMER_ARTIST_INT AS CAI
	ON		C.CustomerID = CAI.CustomerID
				JOIN	ARTIST AS A
					ON	CAI.ArtistID = A.ArtistID
ORDER BY	CustomerName, ArtistName;


