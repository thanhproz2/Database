/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (11th Edition) Chapter 08			*/
/*																				*/
/*	The View Ridge Gallery (VRG) - Review Question Query Statements				*/
/*																				*/
/*	These are the Microsoft SQL Server 2005/2008 SQL code solutions				*/
/*																				*/
/********************************************************************************/

/*****   Review Question 8.5    *************************************************/

SELECT	C.CustomerID, C.LastName, C.FirstName
FROM 	CUSTOMER AS C
WHERE	C.CustomerID IN
		(SELECT CAI.CustomerID
		 FROM CUSTOMER_ARTIST_INT CAI
		 WHERE CAI.ArtistID = 17);

/*****   Review Question 8.7    *************************************************/

SELECT	C1.CustomerID, C1.Email
FROM	CUSTOMER AS C1
WHERE	C1.Email IN
		(SELECT	C2.Email
		 FROM		CUSTOMER AS C2
		 WHERE		C1.Email = C2.Email
			AND		C1.CustomerID <> C2.CustomerID);
			
/*****   Review Question 8.15    ************************************************/
			
SELECT	C.LastName, C.FirstName
FROM	CUSTOMER AS C
WHERE	NOT EXISTS
		(SELECT	A.ArtistID
		 FROM		ARTIST AS A
		 WHERE		NOT EXISTS
					(SELECT	CAI.ArtistID
					 FROM		CUSTOMER_ARTIST_INT AS CAI
					 WHERE		C.CustomerID= CAI.CustomerID
						AND		A.ArtistID = CAI.ArtistID));
			
