/* *** SQL-Query-CH10A-01 *** */
SELECT		RTRIM(FirstName)+' '+RTRIM(LastName) AS CustomerName, 
			Street, City, State, ZipPostalCode
FROM		CUSTOMER
ORDER BY	CustomerName;

/********************************************************************************/

CREATE FUNCTION dbo.FirstNameFirst 

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
	SELECT @FullName = RTRIM(@FirstName) + ' ' + RTRIM(@LastName);
	
	-- Return the concatenated name
	RETURN @FullName
END


/* *** SQL-Query-CH10A-02 *** */

SELECT		dbo.FirstNameFirst(FirstName, LastName) AS CustomerName, 
				Street, City, [State], ZipPostalCode
FROM		CUSTOMER
ORDER BY	CustomerName;

/* *** SQL-Query-CH10A-03 *** */
SELECT		dbo.FirstNameFirst(FirstName, LastName) AS ArtistName, 
				DateOfBirth, DateDeceased
FROM		ARTIST
ORDER BY	ArtistName;



/* *** SQL-Query-CH10A-04 *** */
SELECT		dbo.FirstNameFirst(C.FirstName, C.LastName) AS CustomerName,
				dbo.FirstNameFirst(A.FirstName, A.LastName) AS ArtistName
FROM		CUSTOMER AS C JOIN CUSTOMER_ARTIST_INT AS CAI
	ON		C.CustomerID = CAI.CustomerID
				JOIN		ARTIST AS A
					ON	CAI.ArtistID = A.ArtistID
ORDER BY	CustomerName, ArtistName;



