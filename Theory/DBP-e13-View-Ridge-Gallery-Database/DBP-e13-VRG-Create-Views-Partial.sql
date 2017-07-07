/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (12th Edition) Chapter 10			*/
/*																				*/
/*	The View Ridge Gallery (VRG) - Query and Create View Statements				*/
/*																				*/
/*	These are the Microsoft SQL Server 2008/2008 R2 SQL code solutions			*/
/*																				*/
/********************************************************************************/

/*   SQL View SQL-CREATE-VIEW-CH07-05 - CustomerInterestsView					*/

CREATE VIEW CustomerInterestsView AS
	SELECT	C.LastName AS CustomerLastName,
			C.FirstName AS CustomerFirstName,
			A.LastName AS ArtistName
	FROM	CUSTOMER AS C JOIN CUSTOMER_ARTIST_INT AS CAI
		ON	C.CustomerID = CAI.CustomerID
			JOIN	ARTIST AS A
				ON	CAI.ArtistID = A.ArtistID;

/*   SQL View SQL-Query-View-CH07-05 - CustomerInterestsView					*/
 
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

/*   SQL View SQL-Query-View-CH07-06 - ArtistWorkNetView						*/

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

/*   SQL View SQL-Query-View-CH07-07 - ArtistWorkTotalNetView					*/
	
SELECT		*
FROM		ArtistWorkTotalNetView
WHERE		TotalNetProfit > 5000
ORDER BY	TotalNetProfit;

/*   SQL View SQL-CREATE-VIEW-CH07-08 - CustomerTableBasicDataView				*/

CREATE VIEW CustomerTableBasicDataView AS
	SELECT		*
	FROM		CUSTOMER;
	
/*   SQL View SQL-Query-View-CH07-08 - CustomerTableBasicDataView				*/	
	
SELECT		*
FROM		CustomerTableBasicDataView;


/*   SQL View SQL-CREATE-VIEW-CH10-01 – WorkAndTransView						*/

CREATE VIEW		WorkAndTransView AS
	SELECT		Title, Copy, Medium, [Description], ArtistID,
				DateAcquired, AcquisitionPrice
	FROM		WORK AS W JOIN TRANS AS T
		ON		W.WorkID = T.WorkID;
	
		
/*   SQL View SQL-Query-View-CH10-01 - WorkAndTransView							*/	
	
SELECT		*
FROM		WorkAndTransView
ORDER BY	DateAcquired;


/********************************************************************************/


						
			