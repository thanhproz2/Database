/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 07			*/
/*																				*/
/*	The View Ridge Gallery (VRG) - Query and Create View Statements				*/
/*																				*/
/*	These are the Microsoft SQL Server 2008R2/2012 SQL code solutions			*/
/*																				*/
/********************************************************************************/

/* The SQL JOIN ON Syntax													    */

/* DBP-e13 Chapter07 SQL-Query-CH07-01											*/

SELECT		*
FROM		ARTIST, WORK
WHERE		ARTIST.ArtistID = WORK.ArtistID;

/* DBP-e13 Chapter07 SQL-Query-CH07-02											*/

SELECT		*
FROM		ARTIST JOIN WORK
		ON	ARTIST.ArtistID = WORK.ArtistID;

/* DBP-e13 Chapter07 SQL-Query-CH07-03											*/

SELECT		CUSTOMER.LastName, CUSTOMER.FirstName,
			ARTIST.LastName AS ArtistName
FROM		CUSTOMER JOIN CUSTOMER_ARTIST_INT
		ON	CUSTOMER.CustomerID = CUSTOMER_ARTIST_INT.CustomerID
			JOIN ARTIST
				ON	CUSTOMER_ARTIST_INT.ArtistID = ARTIST.ArtistID;

/* DBP-e13 Chapter07 SQL-Query-CH07-04											*/

SELECT		C.LastName, C.FirstName,
			A.LastName AS ArtistName
FROM		CUSTOMER AS C JOIN CUSTOMER_ARTIST_INT AS CAI
	ON		C.CustomerID = CAI.CustomerID
			JOIN ARTIST AS A
				ON	CAI.ArtistID = A.ArtistID;

/* DBP-e13 Chapter07 SQL-Query-CH07-05											*/

SELECT		TOP 10 C.LastName, C.FirstName,
			A.LastName AS ArtistName
FROM		CUSTOMER AS C JOIN CUSTOMER_ARTIST_INT AS CI
	ON		C.CustomerID = CI.CustomerID
			JOIN 	ARTIST AS A
				ON 	CI.ArtistID = A.ArtistID
ORDER BY	C.LastName, C.FirstName;

/* The SQL OUTER JOIN Syntax												    */

/* DBP-e12 Chapter07 SQL-Query-CH07-06											*/

SELECT		C.LastName, C.FirstName,
			T.TransactionID, T.SalesPrice
FROM		CUSTOMER AS C JOIN TRANS AS T
	ON		C.CustomerID = T.CustomerID
ORDER BY	T.TransactionID;

/* DBP-e12 Chapter07 SQL-Query-CH07-07											*/

SELECT		C.LastName, C.FirstName,
			T.TransactionID, T.SalesPrice
FROM		CUSTOMER AS C LEFT JOIN TRANS AS T
	ON		C.CustomerID = T.CustomerID
ORDER BY	T.TransactionID;

/* DBP-e12 Chapter07 SQL-Query-CH07-08											*/

SELECT		C.LastName, C.FirstName,
			T.TransactionID, T.SalesPrice
FROM		CUSTOMER AS C RIGHT JOIN TRANS AS T
	ON		C.CustomerID = T.CustomerID
ORDER BY	T.TransactionID;

/* DBP-e12 Chapter07 SQL-Query-CH07-09											*/

SELECT		C.LastName, C.FirstName,
			A.LastName AS ArtistName
FROM		CUSTOMER AS C LEFT JOIN CUSTOMER_ARTIST_INT AS CAI
	ON		C.CustomerID = CAI.CustomerID
			LEFT JOIN	ARTIST AS A
					ON	CAI.ArtistID = A.ArtistID
ORDER BY	C.LastName, C.FirstName;

/*	 Chapter 07  - SQL Views															*/

/*   SQL View SQL-CREATE-VIEW-CH07-01 - CustomerNameView						*/

CREATE VIEW CustomerNameView AS
	SELECT	LastName AS CustomerLastName,
			FirstName AS CustomerFirstName
	FROM	CUSTOMER;

/*   SQL View SQL-Query-Views-CH07-01 - CustomerNameView						*/

SELECT		*
FROM		CustomerNameView
ORDER BY	CustomerLastName, CustomerFirstName; 

/*   SQL View SQL-CREATE-VIEW-CH07-02 - CustomerBasicDataView					*/

CREATE VIEW CustomerBasicDataView AS
	SELECT	LastName AS CustomerLastName,
			FirstName AS CustomerFirstName,
			AreaCode, PhoneNumber
	FROM 	CUSTOMER;

/*   SQL View SQL-Query-Views-CH07-02 - CustomerBasicDataView					*/

SELECT		*
FROM		CustomerBasicDataView
ORDER BY	CustomerLastName, CustomerFirstName; 

/*   SQL View SQL-CREATE-VIEW-CH07-03 - CustomerBasicDataWAView					*/

CREATE VIEW CustomerBasicDataWAView AS
	SELECT	LastName AS CustomerLastName,
			FirstName AS CustomerFirstName,
			AreaCode, PhoneNumber
	FROM 	CUSTOMER
	WHERE	State = 'WA';

/*   SQL View SQL-Query-Views-CH07-03 - CustomerBasicDataWAView					*/

SELECT		*
FROM		CustomerBasicDataWAView
ORDER BY	CustomerLastName, CustomerFirstName; 

/*   SQL View SQL-CREATE-VIEW-CH07-04 - CustomerPhoneView						*/

CREATE VIEW CustomerPhoneView AS
	SELECT	LastName AS CustomerLastName,
			FirstName AS CustomerFirstName,
			('(' + AreaCode + ') ' + PhoneNumber) As CustomerPhone
	FROM 	CUSTOMER;

/*   SQL View SQL-Query-Views-CH07-04 - CustomerPhoneView						*/

SELECT		*
FROM		CustomerPhoneView
ORDER BY	CustomerLastName, CustomerFirstName; 

/*   SQL View SQL-CREATE-VIEW-CH07-05 - CustomerInterestsView					*/

CREATE VIEW CustomerInterestsView AS
	SELECT	C.LastName AS CustomerLastName,
			C.FirstName AS CustomerFirstName,
			A.LastName AS ArtistName
	FROM	CUSTOMER AS C JOIN CUSTOMER_ARTIST_INT AS CAI
		ON	C.CustomerID = CAI.CustomerID
			JOIN	ARTIST AS A
				ON	CAI.ArtistID = A.ArtistID;

/*   SQL View SQL-Query-Views-CH07-05 - CustomerInterestsView					*/

SELECT		*
FROM		CustomerInterestsView
ORDER BY	CustomerLastName, CustomerFirstName; 

/*   SQL View SQL-CREATE-VIEW-CH07-06 - ArtistWorkNetView						*/

CREATE VIEW ArtistWorkNetView AS
	SELECT	LastName AS ArtistLastName,
			FirstName AS ArtistFirstName,
			W.WorkID, Title, Copy, DateSold,
			AcquisitionPrice, SalesPrice,
			(SalesPrice - AcquisitionPrice) AS NetProfit
	FROM	TRANS AS T JOIN	WORK AS W
		ON 	T.WorkID = W.WorkID
			JOIN 	ARTIST AS A
				ON 	W.ArtistID = A.ArtistID;

/*   SQL View SQL-Query-Views-CH07-06 - ArtistWorkNetView						*/

SELECT		ArtistLastName, ArtistFirstName,
			WorkID, Title, Copy, DateSold, NetProfit
FROM		ArtistWorkNetView
WHERE		NetProfit > 5000
ORDER BY	DateSold;


/*   SQL View SQL-CREATE-VIEW-CH07-06 - ArtistWorkTotalNetView					*/

CREATE VIEW ArtistWorkTotalNetView AS
	SELECT		ArtistLastName, ArtistFirstName,
				WorkID, Title, Copy,
				SUM(NetProfit)AS TotalNetProfit
	FROM		ArtistWorkNetView
	GROUP BY	ArtistLastName, ArtistFirstName,
				WorkID, Title, Copy;

/*   SQL View SQL-Query-Views-CH07-07 - ArtistWorkTotalNetView					*/
	
SELECT		*
FROM		ArtistWorkTotalNetView
WHERE		TotalNetProfit > 5000
ORDER BY	TotalNetProfit;

/*   SQL View SQL-CREATE-VIEW-CH07-08 - CustomerTableBasicDataView				*/

CREATE VIEW CustomerTableBasicDataView AS
	SELECT		*
	FROM		CUSTOMER;
	
/*   SQL View SQL-Query-Views-CH07-08 - CustomerTableBasicDataView				*/	
	
SELECT		*
FROM		CustomerTableBasicDataView;





/********************************************************************************/


						
			