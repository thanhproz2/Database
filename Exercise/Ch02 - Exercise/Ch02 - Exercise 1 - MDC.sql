CREATE TABLE CUSTOMER(
	CustomerID bigint NOT NULL,
	FirstName nvarchar(25) NOT NULL,
	LastName nvarchar(25) NOT NULL,
	Phone nvarchar(12) NOT NULL,
	Email nvarchar(100) NULL,
	CONSTRAINT PK_CUSTOMER PRIMARY KEY (CustomerID)
 );
 
CREATE TABLE `ORDER`(
	InvoiceNumber int NOT NULL,
	DateIn datetime NOT NULL,
	DateOut datetime NULL,
	TotalAmount double NULL,
	CustomerID bigint NOT NULL,
	CONSTRAINT PK_INVOICE PRIMARY KEY (InvoiceNumber),
	CONSTRAINT FK_ORDER_CUSTOMER FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
);

CREATE TABLE ORDER_ITEM(
	InvoiceNumber int NOT NULL,
	ItemNumber bigint NOT NULL,
	Item nvarchar(50) NOT NULL,
	Quantity int NOT NULL,
	UnitPrice double NOT NULL,
	CONSTRAINT PK_INVOICE_ITEM PRIMARY KEY (InvoiceNumber,	ItemNumber),
	CONSTRAINT FK_ORDER_ITEM_ORDER FOREIGN KEY(InvoiceNumber) REFERENCES `ORDER`(InvoiceNumber)
);

INSERT CUSTOMER (CustomerID, FirstName, LastName, Phone, Email) VALUES (1, 'Nikki', 'Kaccato', '723-543-1233', 'NKaccaton@somewhere.com');
INSERT CUSTOMER (CustomerID, FirstName, LastName, Phone, Email) VALUES (2, 'Brenda', 'Catnazaro', '723-543-2344', 'BCatnazaro@somewhere.com');
INSERT CUSTOMER (CustomerID, FirstName, LastName, Phone, Email) VALUES (3, 'Bruce', 'LeCat', '723-543-3455', 'BLeCat@somewhere.com');
INSERT CUSTOMER (CustomerID, FirstName, LastName, Phone, Email) VALUES (4, 'Betsy', 'Miller', '725-654-3211', 'BMiller@somewhere.com');
INSERT CUSTOMER (CustomerID, FirstName, LastName, Phone, Email) VALUES (5, 'George', 'Miller', '725-654-4322', 'GMiller@somewhere.com');
INSERT CUSTOMER (CustomerID, FirstName, LastName, Phone, Email) VALUES (6, 'Kathy', 'Miller', '723-514-9877', 'KMiller@somewhere.com');
INSERT CUSTOMER (CustomerID, FirstName, LastName, Phone, Email) VALUES (7, 'Betsy', 'Miller', '723-514-8766', 'BMiller@elsewhere.com');

INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009001, '2009-10-04', '2009-10-06', 158.50, 1);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009002, '2009-10-04', '2009-10-06', 25.00, 2);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009003, '2009-10-06', '2009-10-08', 55.00, 1);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009004, '2009-10-06', '2009-10-08', 17.50, 4);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009005, '2009-10-07', '2009-10-11', 12.00, 6);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009006, '2009-10-11', '2009-10-13', 152.50, 3);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009007, '2009-10-11', '2009-10-13', 7.00, 3);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009008, '2009-10-12', '2009-10-14', 140.50, 7);
INSERT `ORDER` (InvoiceNumber, DateIn, DateOut, TotalAmount, CustomerID) VALUES (2009009, '2009-10-12', '2009-10-14', 27.00, 5);


INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009001, 1, 'Blouse', 2, 3.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009001, 2, 'Dress Shirt', 5, 2.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009001, 3, 'Formal Gown', 2, 10.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009001, 4, 'Slacks - Mens', 10, 5.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009001, 5, 'Slacks - Womens', 10, 6.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009001, 6, 'Suit - Mens', 1, 9.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009002, 1, 'Dress Shirt', 10, 2.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009003, 1, 'Slacks - Mens', 5, 5.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009003, 2, 'Slacks - Womens', 4, 6.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009004, 1, 'Dress Shirt', 7, 2.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009005, 1, 'Blouse', 2, 3.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009005, 2, 'Dress Shirt', 2, 2.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009006, 1, 'Blouse', 5, 3.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009006, 2, 'Dress Shirt', 10, 2.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009006, 3, 'Slacks - Mens', 10, 5.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009006, 4, 'Slacks - Womens', 10, 6.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009007, 1, 'Blouse', 2, 3.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009008, 1, 'Blouse', 3, 3.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009008, 2, 'Dress Shirt', 12, 2.50);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009008, 3, 'Slacks - Mens', 8, 5.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009008, 4, 'Slacks - Womens', 10, 6.00);
INSERT ORDER_ITEM (InvoiceNumber, ItemNumber, Item, Quantity, UnitPrice) VALUES (2009009, 1, 'Suit - Mens', 3, 9.00);
