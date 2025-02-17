create database Exercise2
CREATE TABLE SHIPMENT(
	ShipmentID bigint NOT NULL,
	ShipperName nvarchar(35) NOT NULL,
	ShipperInvoiceNumber bigint NULL,
	DepartureDate datetime NOT NULL,
	ArrivalDate datetime NULL,
	InsuredValue float NULL,
	CONSTRAINT PK_SHIPMENT PRIMARY KEY (ShipmentID)
);

CREATE TABLE ITEM(
	ItemID bigint NOT NULL,
	Description nvarchar(50) NULL,
	PurchaseDate datetime NOT NULL,
	Store nvarchar(50) NOT NULL,
	City nvarchar(35) NOT NULL,
	Quantity int NOT NULL,
	LocalCurrencyAmt decimal(18, 0) NOT NULL,
	ExchangeRate decimal(12, 6) NOT NULL,
	CONSTRAINT PK_ITEM_PURCHASE PRIMARY KEY(ItemID)
);

CREATE TABLE SHIPMENT_ITEM(
	ShipmentID bigint NOT NULL,
	ShipmentItemID bigint NOT NULL,
	ItemID bigint NOT NULL,
	Quantity int NOT NULL,
	Value float NOT NULL,
	CONSTRAINT PK_SHIPMENT_ITEM PRIMARY KEY (ShipmentID,ShipmentItemID),
	CONSTRAINT FK_SHIPMENT_ITEM_ITEM_PURCHASE FOREIGN KEY(ItemID) REFERENCES ITEM (ItemID) ON UPDATE CASCADE,
	CONSTRAINT FK_SHIPMENT_ITEM_SHIPMENT FOREIGN KEY(ShipmentID) REFERENCES SHIPMENT (ShipmentID) ON UPDATE CASCADE
);

INSERT SHIPMENT (ShipmentID, ShipperName, ShipperInvoiceNumber, DepartureDate, ArrivalDate, InsuredValue) VALUES (1, 'ABC Trans-Oceanic', 2008651, '2008-12-10', '2009-03-15', 15000);
INSERT SHIPMENT (ShipmentID, ShipperName, ShipperInvoiceNumber, DepartureDate, ArrivalDate, InsuredValue) VALUES (2, 'ABC Trans-Oceanic', 2009012, '2009-01-10', '2009-03-20', 12000);
INSERT SHIPMENT (ShipmentID, ShipperName, ShipperInvoiceNumber, DepartureDate, ArrivalDate, InsuredValue) VALUES (3, 'Worldwide', 49100300, '2009-05-05', '2009-06-17', 27500);
INSERT SHIPMENT (ShipmentID, ShipperName, ShipperInvoiceNumber, DepartureDate, ArrivalDate, InsuredValue) VALUES (4, 'International', 399400, '2009-06-02', '2009-07-17', 7500);
INSERT SHIPMENT (ShipmentID, ShipperName, ShipperInvoiceNumber, DepartureDate, ArrivalDate, InsuredValue) VALUES (5, 'Worldwide', 84899440, '2009-07-10', '2009-07-28', 25000);
INSERT SHIPMENT (ShipmentID, ShipperName, ShipperInvoiceNumber, DepartureDate, ArrivalDate, InsuredValue) VALUES (6, 'International', 488955, '2009-08-05', '2009-09-11', 18000);

INSERT ITEM (ItemID, Description, PurchaseDate, Store, City, Quantity, LocalCurrencyAmt, ExchangeRate) VALUES (1, 'QE Dining Set', '2009-04-07', 'Eastern Treasures', 'Manila', 2,403405, 0.01774);
INSERT ITEM (ItemID, Description, PurchaseDate, Store, City, Quantity, LocalCurrencyAmt, ExchangeRate) VALUES (2, 'Willow Serving Dishes', '2009-07-15', 'Jade Antiques', 'Singapore', 75,102,0.5903);
INSERT ITEM (ItemID, Description, PurchaseDate, Store, City, Quantity, LocalCurrencyAmt, ExchangeRate) VALUES (3, 'Large Bureau', '2009-07-17', 'Eastern Sales', 'Singapore', 8, 2000, 0.5903);
INSERT ITEM (ItemID, Description, PurchaseDate, Store, City, Quantity, LocalCurrencyAmt, ExchangeRate) VALUES (4, 'Brass Lamps', '2009-07-20', 'Jade Antiques', 'Singapore', 40, 50,0.5903);

INSERT SHIPMENT_ITEM (ShipmentID, ShipmentItemID, ItemID, Quantity, Value) VALUES (4, 1, 4, 40, 1200);
INSERT SHIPMENT_ITEM (ShipmentID, ShipmentItemID, ItemID, Quantity, Value) VALUES (4, 2, 3, 8, 9500);
INSERT SHIPMENT_ITEM (ShipmentID, ShipmentItemID, ItemID, Quantity, Value) VALUES (4, 3, 2, 75, 4500);

