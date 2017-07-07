/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 10A			*/
/*																				*/
/*	View Ridge Gallery (VRG) - Create Triggers, and Stored Procedures			*/
/*																				*/
/*	These are the Microsoft SQL Server 2008 R2 / 2012 SQL code solutions		*/
/*																				*/
/********************************************************************************/

/*   SQL Trigger - TRANS_AfterInsertSetAskingPrice								*/

CREATE TRIGGER TRANS_AfterInsertSetAskingPrice
	ON TRANS
	AFTER INSERT

AS
BEGIN	
	SET NOCOUNT ON;

	DECLARE	@PriorRowCount		AS Int,
			@WorkID				AS Int,
			@TransactionID		AS Int,
			@AcquisitionPrice	AS Numeric(8,2),
			@NewAskingPrice		AS Numeric(8,2),
			@SumNetProfit		AS Numeric(8,2),
			@AvgNetProfit		AS Numeric(8,2)
	
	SELECT	@TransactionID = TransactionID,
			@AcquisitionPrice = AcquisitionPrice,
			@WorkID = WorkID
	FROM	inserted;
	
	-- First find if work has been here before.
	
	SELECT 	*
	FROM	dbo.TRANS AS T
	WHERE	T.WorkID = @WorkID;
	
	-- Since this is an AFTER trigger, @@Rowcount includes the new row.
	
	SET @PriorRowCount = (@@Rowcount - 1)
	
	IF (@PriorRowCount = 0)
		-- This is first time work has been in the gallery.
		-- Set @NewAskingPrice to twice the acquisition cost.
		SET @NewAskingPrice = (2 * @AcquisitionPrice)
		
	ELSE
		-- The work has been here before 
		-- We have to determine the value of @NewAskingPrice											
		BEGIN
			SELECT 		@SumNetProfit = SUM(NetProfit)
			FROM		dbo.ArtistWorkNetView AWNV
			WHERE		AWNV.WorkID = @WorkID
			GROUP BY	AWNV.WorkID;
		
			SET @AvgNetProfit = (@SumNetProfit / @PriorRowCount);

				-- Now choose larger value for the new AskingPrice.

			IF ((@AcquisitionPrice + @AvgNetProfit)
					> (2 * @AcquisitionPrice))
				SET @NewAskingPrice = (@AcquisitionPrice + @AvgNetProfit)
			ELSE
				SET @NewAskingPrice = (2 * @AcquisitionPrice)
		END
	-- Update TRANS with the value of AskingPrice 
	
	UPDATE	dbo.TRANS
	SET		AskingPrice = @NewAskingPrice
	WHERE	TransactionID = @TransactionID;
	
	-- The INSERT is completed. Print output
	BEGIN
			PRINT '******************************************************'
			PRINT ''
			PRINT '   INSERT complete. '
			PRINT ''
			PRINT '   TransactionID		=  '+CONVERT(Char(6), @TransactionID)
			PRINT '   WorkID			=  '+CONVERT(Char(6), @WorkID)
			PRINT '   Acquisition Price	=  '+CONVERT(Char(12), @AcquisitionPrice)
			PRINT '   Asking Price		=  '+CONVERT(Char(12), @NewAskingPrice)
			PRINT ''  
			PRINT '******************************************************'
	END
END

/*   SQL Trigger - TRANS_AfterInsertSetAskingPrice	- Test Data					*/

-- INSERT new work into WORK

/* DBP-e13 Chapter10A SQL-INSERT-CH10A-01										*/

INSERT INTO WORK VALUES(
	'Spanish Dancer', '635/750', 'High Quality Limited Print',
	'American Realist style - From work in Spain', 11);

--  Obtain new WorkID

/* DBP-e13 Chapter10A SQL-Query-CH10A-01										*/

SELECT	WorkID
FROM	dbo.WORK
WHERE	ArtistID = 11
	AND	Title = 'Spanish Dancer'
	AND Copy = '635/750';
	
--  Use the new WorkID value (597 in this case)

/* DBP-e13 Chapter10A SQL-INSERT-CH10A-02										*/
	
INSERT INTO TRANS (DateAcquired, AcquisitionPrice, WorkID)
 	VALUES ('11/12/2013', 200.00, 597);

/********************************************************************************/

/*   SQL Trigger - CUSTOMER Table Modifications									*/

-- Add column isProblemAccount to CUSTOMER

/* DBP-e13 Chapter10A SQL-ALTER-TABLE-CH10A-01									*/

ALTER TABLE dbo.CUSTOMER
	ADD		isProblemAccount	Bit NULL DEFAULT '0';

-- Set initial column values for CUSTOMER.isProblemAccount

/* DBP-e13 Chapter10A SQL-UPDATE-CH10A-01										*/

UPDATE		dbo.CUSTOMER
	SET		isProblemAccount = 0;

-- Set column value for Melinda Gliddens

/* DBP-e12 Chapter10 SQL-UPDATE-CH10-02											*/

UPDATE		dbo.CUSTOMER
	SET		isProblemAccount = 1
	WHERE	LastName	= 'Gliddens'
		AND	FirstName	= 'Melinda';

-- Check CUSTOMER.isProblemAccount column values

/* DBP-e12 Chapter10 SQL-Query-CH10-02											*/

SELECT	CustomerID, LastName, FirstName, isProblemAccount
FROM		dbo.CUSTOMER;

/*   SQL Trigger - TRANS_CheckIsProblemAccount									*/

CREATE TRIGGER TRANS_CheckIsProblemAccount
	ON dbo.TRANS
	FOR UPDATE

AS
BEGIN
	SET NOCOUNT ON;	

	DECLARE	@TransactionID		AS Int,
			@CustomerID			AS Int,
			@isProblemAccount	AS Bit
				
	SELECT	@TransactionID = TransactionID,
			@CustomerID = CustomerID
	FROM	inserted; 

	/* This trigger will fire for every update of TRANS.
	 * This includes updates without a Customer participating,
     * such as an update of AskingPrice using the 
     * TRANS_AfterInsertSetAskingPrice tigger.
     * Therefore, make sure there is a Customer particpating
     * in the Update of TRANS/
     */		
	
	-- Check if Customer ID is NULL and if so RETURN.
	-- Do not ROLLBACK the transaction, just don't complete this trigger.
	
	IF (@CustomerID IS NULL) RETURN
		
	-- Valid CustomerID.
	-- Obtain value of @isProblemAcocunt.
	
	SELECT 	@isProblemAccount = isProblemAccount
	FROM	dbo.CUSTOMER AS C
	WHERE	C.CustomerID = @CustomerID;
	
	IF (@isProblemAccount = 1)
		-- This is a problem account.
		-- Rollback the transaction and send message.
		BEGIN
			ROLLBACK TRANSACTION
			PRINT '******************************************************'
			PRINT ''
			PRINT '   Transaction canceled.'
			PRINT ''
			PRINT '   CustomerID      = '+CONVERT(Char(6), @CustomerID)
			PRINT ''
			PRINT '   Refer customer to the manager immediately.'
			PRINT ''  
			PRINT '******************************************************'
			RETURN
		END
	ELSE
		-- This is a good account
		-- Let the transaction stand.
		BEGIN
			PRINT '******************************************************'
			PRINT ''
			PRINT '   Transaction complete.'
			PRINT '   TransactionID   = '+CONVERT(Char(6), @TransactionID)
			PRINT '   CustomerID      = '+CONVERT(Char(6), @CustomerID)
			PRINT ''
			PRINT '   Thank the customer for their business.'
			PRINT ''  
			PRINT '******************************************************'
		END
END

/*   SQL Trigger - TRANS_CheckIsProblemAccount - Test Data						*/

/* DBP-e12 Chapter10 SQL-UPDATE-CH10-03											*/

UPDATE	TRANS
SET		DateSold = '11/18/2010',
		SalesPrice = 475.00,
		CustomerID = 1053
WHERE	TransactionID = 229;

/********************************************************************************/

/*   SQL Trigger - CIV_ChangeCustomerName										*/

CREATE TRIGGER CIV_ChangeCustomerLastName
	ON dbo.CustomerInterestsView
	INSTEAD OF UPDATE

AS
BEGIN	
	SET NOCOUNT ON;

	DECLARE	@NewCustomerLastName	AS Char(25),
			@OldCustomerLastName	AS Char(25)
				
	-- Get values of new and old names.
	SELECT	@NewCustomerLastName = CustomerLastName
	FROM	inserted; 
	
	SELECT	@OldCustomerLastName = CustomerLastName
	FROM	deleted;
	
	-- Count number of synonyms is CUSTOMER.
	SELECT 	*
	FROM	dbo.CUSTOMER AS C1
	WHERE	C1.LastName = @OldCustomerLastName
		AND	EXISTS
			(SELECT		*
			 FROM		dbo.CUSTOMER AS C2
			 WHERE		C1.LastName = C2.LastName
					AND	C1.CustomerID <> C2.CustomerID);
	
	IF (@@rowCount = 0)
		-- The Customer last name is unique.
		-- Update the Customer record.
		BEGIN
			UPDATE		dbo.CUSTOMER
			SET			LastName = @NewCustomerLastName
			WHERE		LastName = @OldCustomerLastName;
			
			-- Print update message.
			PRINT '******************************************************'
			PRINT ''
			PRINT '   The Customer last name has been changed.'
			PRINT ''
			PRINT '   Former Customer Last Name  = '+@OldCustomerLastName
			PRINT ''
			PRINT '   Updated Customer Last Name  = '+@NewCustomerLastName
			PRINT ''
			PRINT '******************************************************'
		END
	ELSE
		-- The Customer name is not unique.
		-- Rollback the transaction and send message.
		BEGIN
			PRINT '******************************************************'
			PRINT ''
			PRINT '   Transaction canceled.'
			PRINT ''
			PRINT '   Customer Last Name  = '+@NewCustomerLastName
			PRINT ''
			PRINT '   The customer last name is not unique.'
			PRINT ''  
			PRINT '******************************************************'
		END
END

/*   SQL Trigger - CIV_ChangeCustomerName - Test Data							*/

/* DBP-e12 Chapter10 SQL-UPDATE-CH10-04											*/

UPDATE	dbo.CustomerInterestsView
SET		CustomerLastName = 'Bench'
WHERE	CustomerLastName = 'Gliddens';


/********************************************************************************/

/*   SQL Trigger - WATV_InsertTransactionWithWork 								*/

CREATE TRIGGER WATV_InsertTransactionWithWork
	ON dbo.WorkAndTransView
	INSTEAD OF INSERT

AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE	@TransactionID		AS Int,
			@WorkID				AS Int,
			@Title				AS Char(35),
			@Copy				AS Char(12),
			@Medium				AS Char(35),
			@Description		AS Varchar(1000),
			@ArtistID			AS Int,
			@DateAcquired		AS DateTime,
			@AcquisitionPrice	AS Numeric(8,2),
			@AskingPrice		AS Numeric(8,2)
				
	-- Get available values from Insert on the view.
	SELECT	@Title = Title, @Copy = Copy, @Medium = Medium,
			@Description = [Description],
			@ArtistID = ArtistID, @DateAcquired =DateAcquired,
			@AcquisitionPrice = AcquisitionPrice
	FROM	inserted; 
	
	-- Insert new row into WORK.
	INSERT	INTO WORK VALUES(
			@Title, @Copy, @Medium, @Description, @ArtistID);
	
	-- Get new WorkID surrogate key value using @@Identity funcion.
	SET	@WorkID = @@Identity;
	
	-- Insert new row into TRANS.
	-- Note that INSERT will trigger TRANS_AfterInsertSetAskingPrice.
	INSERT	INTO TRANS (DateAcquired, AcquisitionPrice, WorkID)
			VALUES(
			@DateAcquired, @AcquisitionPrice, @WorkID);
	
	-- Get new TranasctionID surrogate key value.
	SET	@TransactionID = @@Identity;
			
	-- Get new AskingPrice set by TRANS_AfterInsertSetAskingPrice.
	SELECT	@AskingPrice = AskingPrice
	FROM	TRANS
	WHERE	TransactionID = @TransactionID; 
	
	-- Print results message.
	PRINT '******************************************************'
	PRINT ''
	PRINT '   The new work has been inserted into WORK and TRANS.'
	PRINT ''
	PRINT '   TransactionID     = '+CONVERT(Char(6), @TransactionID)
	PRINT '   WorkID            = '+CONVERT(Char(6), @WorkID)
	PRINT '   ArtistID          = '+CONVERT(Char(6), @ArtistID)
	PRINT '   Title             = '+@Title
	PRINT '   Copy              = '+@Copy
	PRINT '   Medium            = '+@Medium
	PRINT '   Description       = '+@Description
	PRINT '   DateAcquired      = '+CONVERT(Char(12), @DateAcquired)
	PRINT '   Acquisition Price =  '+CONVERT(Char(12), @AcquisitionPrice)
	PRINT '   Asking Price      =  '+CONVERT(Char(12), @AskingPrice)
	PRINT '******************************************************'
END

/*   SQL Trigger - WATV_InsertTransactionWithWork - Test Data					*/

-- Reset Melinda Bench’s Problem Account status.

/* DBP-e12 Chapter10 SQL-UPDATE-CH10-05											*/

UPDATE	dbo.CUSTOMER
SET		isProblemAccount = 0
WHERE	LastName	= 'Bench'
	AND	FirstName	= 'Melinda';

-- Record the complted purchase of “Color Floating in Time”.

/* DBP-e12 Chapter10 SQL-UPDATE-CH10-06											*/

UPDATE	TRANS
SET		DateSold = '11/18/2010',
		SalesPrice = 475.00,
		CustomerID = 1053
WHERE	TransactionID = 229;

-- Test WATV_InsertTransactionWithWork Trigger

/* DBP-e12 Chapter10 SQL-INSERT-CH10-03											*/

INSERT INTO WorkAndTransView
	VALUES(
	'Color Floating in Time', '493/750', 'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 18,
	'02/05/2011', 250.00);
	
-- Test the GO Command

/* DBP-e12 Chapter10 SQL-INSERT-CH10-04								*/
INSERT INTO WorkAndTransView
	VALUES(
	'Color Floating in Time', '494/750',
	'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 18,
	'02/05/2011', 250.00);
GO
/* DBP-e12 Chapter10 SQL-INSERT-CH10-05								*/
INSERT INTO WorkAndTransView
	VALUES(
	'Color Floating in Time', '495/750',
	'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 18,
	'02/05/2011', 250.00);
GO
/* DBP-e12 Chapter10 SQL-INSERT-CH10-06								*/
INSERT INTO WorkAndTransView
	VALUES(
	'Color Floating in Time', '496/750',
	'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 18,
	'02/05/2011', 250.00);
GO


/********************************************************************************/





