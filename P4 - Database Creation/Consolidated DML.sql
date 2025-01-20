DECLARE @NewUserID1 INT;
EXEC RegisterUser 'Rahul', 'Gupta', 'rahulgupta@gmail.com', 'rahulg', 'Passw0rd123', '919876543210', @NewUserID1 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID1 AS NVARCHAR(10));

DECLARE @NewUserID2 INT;
EXEC RegisterUser 'Priya', 'Patel', 'priyapatel@gmail.com', 'priyap', 'Secur3P@ss', '917890123456', @NewUserID2 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID2 AS NVARCHAR(10));

DECLARE @NewUserID3 INT;
EXEC RegisterUser 'Amit', 'Sharma', 'amitsharma@gmail.com', 'amits', 'P@ssw0rd123', '919012345678', @NewUserID3 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID3 AS NVARCHAR(10));

DECLARE @NewUserID4 INT;
EXEC RegisterUser 'Michael', 'Brown', 'michaelbrown@gmail.com', 'michaelb', 'BrownMikey123', '176789012345', @NewUserID4 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID4 AS NVARCHAR(10));

DECLARE @NewUserID5 INT;
EXEC RegisterUser 'Emma', 'Williams', 'emmawilliams@gmail.com', 'emmaw', 'Emm@W1ll1ams', '492345678901', @NewUserID5 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID5 AS NVARCHAR(10));

DECLARE @NewUserID6 INT;
EXEC RegisterUser 'James', 'Jones', 'jamesjones@gmail.com', 'jamesj', 'J@mes123', '33678901234', @NewUserID6 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID6 AS NVARCHAR(10));

DECLARE @NewUserID7 INT;
EXEC RegisterUser 'Olivia', 'Miller', 'oliviamiller@gmail.com', 'oliviam', 'MillerOl1via', '55901234567', @NewUserID7 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID7 AS NVARCHAR(10));

DECLARE @NewUserID8 INT;
EXEC RegisterUser 'William', 'Davis', 'williamdavis@gmail.com', 'williamd', 'W1lliamDav1s', '865678901234', @NewUserID8 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID8 AS NVARCHAR(10));

DECLARE @NewUserID9 INT;
EXEC RegisterUser 'Ava', 'Garcia', 'avagarcia@gmail.com', 'avag', 'Garc1@Ava', '914567890123', @NewUserID9 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID9 AS NVARCHAR(10));

DECLARE @NewUserID10 INT;
EXEC RegisterUser 'Alexander', 'Rodriguez', 'alexanderrodriguez@gmail.com', 'alexanderr', 'R0driguezAlex', '746789012345', @NewUserID10 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID10 AS NVARCHAR(10));

DECLARE @NewUserID11 INT;
EXEC RegisterUser 'Sophia', 'Martinez', 'sophiamartinez@gmail.com', 'sophiam', 'S0phiaM@rtinez', '813678901234', @NewUserID11 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID11 AS NVARCHAR(10));

DECLARE @NewUserID12 INT;
EXEC RegisterUser 'Mason', 'Hernandez', 'masonhernandez@gmail.com', 'masonh', 'H3rn@ndezMason', '396789012345', @NewUserID12 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID12 AS NVARCHAR(10));

DECLARE @NewUserID13 INT;
EXEC RegisterUser 'Amelia', 'Lopez', 'amelialopez@gmail.com', 'amelial', 'Lop3z@melia', '275678901234', @NewUserID13 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID13 AS NVARCHAR(10));

DECLARE @NewUserID14 INT;
EXEC RegisterUser 'Liam', 'Gonzalez', 'liamgonzalez@gmail.com', 'liamg', 'G0nz@l3zLiam', '5214567890123', @NewUserID14 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID14 AS NVARCHAR(10));

DECLARE @NewUserID15 INT;
EXEC RegisterUser 'Ethan', 'Wilson', 'ethanwilson@gmail.com', 'ethanw', 'Wils0nEthan', '5497890123456', @NewUserID15 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID15 AS NVARCHAR(10));

DECLARE @NewUserID16 INT;
EXEC RegisterUser 'Charlotte', 'Taylor', 'charlottetaylor@gmail.com', 'charlottet', 'T@ylorCh@rl0tte', '345678901234', @NewUserID16 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID16 AS NVARCHAR(10));

DECLARE @NewUserID17 INT;
EXEC RegisterUser 'Elijah', 'Thomas', 'elijahthomas@gmail.com', 'elijaht', 'Th0masE1ijah', '825678901234', @NewUserID17 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID17 AS NVARCHAR(10));

DECLARE @NewUserID18 INT;
EXEC RegisterUser 'Harper', 'Moore', 'harpermoore@gmail.com', 'harperm', 'Mo0reH@rper', '234567890123', @NewUserID18 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID18 AS NVARCHAR(10));

DECLARE @NewUserID19 INT;
EXEC RegisterUser 'Evelyn', 'Jackson', 'evelynjackson@gmail.com', 'evelynj', 'J@cks0nEvelyn', '2014567890123', @NewUserID19 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID19 AS NVARCHAR(10));

DECLARE @NewUserID20 INT;
EXEC RegisterUser 'Logan', 'White', 'loganwhite@gmail.com', 'loganw', 'Wh1teLog@n', '4697890123456', @NewUserID20 OUTPUT;
PRINT 'New user ID: ' + CAST(@NewUserID20 AS NVARCHAR(10));

DECLARE @NewUserID21 INT, @NewUserID22 INT, @NewUserID23 INT, @NewUserID24 INT, @NewUserID25 INT;

EXEC RegisterUser 'Michael', 'Johnson', 'michaeljohnson@example.com', 'michaelj', 'Passw0rd', '1234567890123', @NewUserID21 OUTPUT;

EXEC RegisterUser 'Jennifer', 'Williams', 'jenniferwilliams@example.com', 'jenniferw', 'P@ssw0rd', '2345678901234', @NewUserID22 OUTPUT;

EXEC RegisterUser 'James', 'Brown', 'jamesbrown@example.com', 'jamesb', 'Password123', '3456789012345', @NewUserID23 OUTPUT;

EXEC RegisterUser 'Mary', 'Davis', 'marydavis@example.com', 'maryd', 'Welcome123', '4567890123456', @NewUserID24 OUTPUT;

EXEC RegisterUser 'David', 'Miller', 'davidmiller@example.com', 'davidm', 'SecurePwd', '5678901234567', @NewUserID25 OUTPUT;

PRINT 'New user IDs: ' + CAST(@NewUserID21 AS NVARCHAR(10)) + ', ' + CAST(@NewUserID22 AS NVARCHAR(10)) + ', ' + CAST(@NewUserID23 AS NVARCHAR(10)) + ', ' + CAST(@NewUserID24 AS NVARCHAR(10)) + ', ' + CAST(@NewUserID25 AS NVARCHAR(10));

Select * from Users;

-----------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Categories (Category_Name) VALUES ('Electronics');
INSERT INTO Categories (Category_Name) VALUES ('Clothing');
INSERT INTO Categories (Category_Name) VALUES ('Books');
INSERT INTO Categories (Category_Name) VALUES ('Home Appliances');
INSERT INTO Categories (Category_Name) VALUES ('Groceries');
INSERT INTO Categories (Category_Name) VALUES ('Personal Care');
INSERT INTO Categories (Category_Name) VALUES ('Furniture');
INSERT INTO Categories (Category_Name) VALUES ('Sports Equipment');
INSERT INTO Categories (Category_Name) VALUES ('Toys');
INSERT INTO Categories (Category_Name) VALUES ('Tools');
INSERT INTO Categories (Category_Name) VALUES ('Beauty');
INSERT INTO Categories (Category_Name) VALUES ('Jewelry');

SELECT * FROM Categories;

---------------------------------------------------------------------------------------------------------------------------------------
-- Products for Electronics category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Headphones', 'Over-ear headphones with noise cancellation', 40, 99.99, 1);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Smartwatch', 'Fitness tracker and smartwatch with heart rate monitor', 35, 149.99, 1);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Wireless Earbuds', 'True wireless earbuds with long battery life', 50, 79.99, 1);

-- Products for Clothing category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Women''s Dress', 'Elegant dress for special occasions', 60, 39.99, 2);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Men''s Suit', 'Classic tailored suit for formal events', 45, 199.99, 2);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Kids Jacket', 'Warm winter jacket for kids', 30, 34.99, 2);

-- Products for Books category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('The Catcher in the Rye', 'Classic coming-of-age novel by J.D. Salinger', 55, 12.99, 3);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('1984', 'Dystopian novel by George Orwell', 40, 10.99, 3);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Cookbook', 'Collection of delicious recipes for home cooking', 25, 19.99, 3);

-- Products for Home Appliances category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Blender', 'High-speed blender for smoothies and shakes', 35, 29.99, 4);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Microwave Oven', 'Compact microwave oven for quick cooking', 30, 79.99, 4);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Electric Kettle', 'Fast-boiling electric kettle for tea and coffee', 40, 19.99, 4);

-- Products for Groceries category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Bananas', 'Ripe and ready-to-eat bananas', 75, 0.49, 5);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Bread', 'Freshly baked bread loaf', 60, 2.99, 5);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Pasta', 'Assorted pasta shapes for cooking', 45, 1.99, 5);

-- Products for Personal Care category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Body Lotion', 'Hydrating body lotion for soft and smooth skin', 50, 7.99, 6);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Hand Soap', 'Gentle hand soap with moisturizing properties', 65, 4.49, 6);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Facial Cleanser', 'Foaming facial cleanser for deep cleansing', 40, 9.99, 6);

-- Products for Furniture category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Sofa', 'Comfortable sofa for living room', 25, 499.99, 7);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Dining Table Set', 'Elegant dining table set with chairs', 20, 799.99, 7);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Bed Frame', 'Sturdy bed frame for a restful sleep', 30, 299.99, 7);

-- Products for Sports Equipment category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Yoga Mat', 'Non-slip yoga mat for yoga and pilates', 40, 24.99, 8);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Dumbbell Set', 'Adjustable dumbbell set for strength training', 30, 99.99, 8);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Treadmill', 'Foldable treadmill for indoor cardio workouts', 15, 599.99, 8);

-- Products for Toys category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('LEGO Classic Bricks', 'Assorted LEGO bricks for creative building', 50, 29.99, 9);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Barbie Doll', 'Classic Barbie doll for imaginative play', 40, 19.99, 9);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Remote Control Car', 'RC car for outdoor and indoor racing', 35, 39.99, 9);

-- Products for Tools category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Cordless Drill', 'Powerful cordless drill for DIY projects', 25, 79.99, 10);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Toolbox Set', 'Complete toolbox set with assorted tools', 20, 99.99, 10);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Electric Screwdriver', 'Compact electric screwdriver for easy screwing', 30, 34.99, 10);

-- Products for Beauty category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Makeup Palette', 'Versatile makeup palette with assorted shades', 45, 39.99, 11);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Facial Mask', 'Hydrating facial mask for glowing skin', 50, 9.99, 11);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Hair Dryer', 'Ionic hair dryer for quick drying and styling', 35, 49.99, 11);

-- Products for Jewelry category
INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Diamond Necklace', 'Elegant diamond necklace for special occasions', 15, 999.99, 12);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Gold Bracelet', 'Classic gold bracelet for everyday wear', 20, 499.99, 12);

INSERT INTO Products (Product_Name, Product_Description, Stock_Quantity, Actual_Price, Category_ID) 
VALUES ('Silver Earrings', 'Chic silver earrings for a touch of elegance', 30, 79.99, 12);

SELECT * FROM Products;

-----------------------------------------------------------------------------------------------------------------------------------------


-- Add 10 promotions
INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (10, '2024-04-10 08:30:00', '2024-04-20 20:45:00');	

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (20, '2024-04-04 09:15:00', '2024-04-25 21:30:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (15, '2024-04-12 10:00:00', '2024-04-22 22:15:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (25, '2024-04-04 10:45:00', '2024-04-28 23:00:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (30, '2024-04-11 11:30:00', '2024-04-21 19:45:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (18, '2024-04-14 12:15:00', '2024-04-24 20:30:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (22, '2024-04-16 13:00:00', '2024-04-26 21:15:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (12, '2024-04-04 13:45:00', '2024-04-23 22:00:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (28, '2024-04-04 14:30:00', '2024-04-27 20:45:00');

INSERT INTO Promotions (Discount_Percentage, Start_Date, End_Date)
VALUES (16, '2024-04-04 15:15:00', '2024-04-29 23:30:00');


SELECT * FROM Promotions;

---------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Product_Promotions (Promotion_ID, Product_ID)
VALUES
    (1, 4),
    (2, 10),
    (3, 12),
    (4, 9),
    (5, 1),
    (6, 31),
    (7, 11),
    (8, 6),
    (9, 3),
    (10, 20),
    (1, 22),
    (2, 30),
    (3, 26),
    (4, 16),
    (5, 13);

SELECT * FROM Product_Promotions;

-----------------------------------------------------------------------------------------------------------------------------------------

DECLARE @NewUserID1 INT;
EXEC RegisterSeller 'Rahul', 'Guppt', 'rahulgppta@gmail.com', 'rahlg', 'Passw0021rd123', '919876544510', @NewUserID1 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID1 AS NVARCHAR(10));

DECLARE @NewUserID2 INT;
EXEC RegisterSeller 'Jesus', 'Hebert', 'kelsey48@kerr-young.org', 'edwardsanders', 'Passw844rd7841', '9415578388', @NewUserID2 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID2 AS NVARCHAR(10));

DECLARE @NewUserID3 INT;
EXEC RegisterSeller 'Darlene', 'Cox', 'mkey@gmail.com', 'brenda07', 'Passw814rd8970', '06189753799', @NewUserID3 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID3 AS NVARCHAR(10));

DECLARE @NewUserID4 INT;
EXEC RegisterSeller 'Mark', 'Richardson', 'qbarnes@yahoo.com', 'johnhogan', 'Passw233rd2825', '94879328250', @NewUserID4 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID4 AS NVARCHAR(10));

DECLARE @NewUserID5 INT;
EXEC RegisterSeller 'Patricia', 'Sosa', 'weavermelinda@yahoo.com', 'ramseylindsay', 'Passw129rd2259', '4369075057', @NewUserID5 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID5 AS NVARCHAR(10));

DECLARE @NewUserID6 INT;
EXEC RegisterSeller 'Richard', 'Collins', 'michaelpalmer@gmail.com', 'blewis', 'Passw556rd7824', '5944446018', @NewUserID6 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID6 AS NVARCHAR(10));

DECLARE @NewUserID7 INT;
EXEC RegisterSeller 'Rachel', 'Jordan', 'thorn@phillips.com', 'qgutierrez', 'Passw454rd3166', '5913800404', @NewUserID7 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID7 AS NVARCHAR(10));

DECLARE @NewUserID8 INT;
EXEC RegisterSeller 'Regina', 'Thomas', 'angela29@yahoo.com', 'allenedward', 'Passw239rd1875', '4617749966', @NewUserID8 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID8 AS NVARCHAR(10));

DECLARE @NewUserID9 INT;
EXEC RegisterSeller 'Bruce', 'Donaldson', 'iberry@bush-kirk.com', 'alexanderpineda', 'Passw209rd3992', '0014947404077', @NewUserID9 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID9 AS NVARCHAR(10));

DECLARE @NewUserID10 INT;
EXEC RegisterSeller 'Lisa', 'Lewis', 'christinebrady@gmail.com', 'nfrazier', 'Passw984rd3626', '020792950623', @NewUserID10 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID10 AS NVARCHAR(10));

DECLARE @NewUserID11 INT;
EXEC RegisterSeller 'Garrett', 'Lowe', 'kimberlyreyes@rose-cook.biz', 'wendy03', 'Passw755rd3844', '917747580993', @NewUserID11 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID11 AS NVARCHAR(10));

DECLARE @NewUserID12 INT;
EXEC RegisterSeller 'Sarah', 'Hamilton', 'nancyfranco@yahoo.com', 'stephen20', 'Passw278rd9522', '485212936', @NewUserID12 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID12 AS NVARCHAR(10));

DECLARE @NewUserID13 INT;
EXEC RegisterSeller 'Tristan', 'Scott', 'scott03@perry-mason.org', 'darlene63', 'Passw205rd3003', '058183666', @NewUserID13 OUTPUT;
PRINT 'New seller ID: ' + CAST(@NewUserID13 AS NVARCHAR(10));


select * from Sellers;

-----------------------------------------------------------------------------------------------------------------------------------------

-- Products supplied by ABC Electronics
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (1, 1, 49.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (1, 2, 199.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (1, 3, 79.99);

-- Products supplied by XYZ Fashion
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (2, 4, 14.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (2, 5, 112.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (2, 6, 19.99);

-- Products supplied by Books Galore
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (3, 7, 10.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (3, 8, 7.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (3, 9, 12.99);

-- Products supplied by Home Appliances Inc.
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (4, 10, 24.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (4, 11, 19.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (4, 12, 15.99);

-- Products supplied by Fresh Grocers
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (5, 13, 0.29);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (5, 14, 1.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (5, 15, 1.49);

-- Products supplied by Beauty Boutique
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (6, 16, 5.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (6, 17, 2.49);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (6, 18, 9.99);

-- Products supplied by Jewelry Emporium
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (7, 19, 249.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (7, 20, 349.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (7, 21, 49.99);

-- Products supplied by Furniture Haven
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (8, 22, 39.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (8, 23, 59.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (8, 24, 399.99);

-- Products supplied by Sports Zone
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (9, 25, 19.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (9, 26, 9.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (9, 27, 49.99);

-- Products supplied by Toy World
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (10, 28, 19.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (10, 29, 99.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (10, 30, 29.99);

-- Products supplied by Tool Tech
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (11, 31, 59.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (11, 32, 79.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (11, 33, 29.99);

-- Products supplied by Cosmetics Co.
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (12, 34, 299.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (12, 35, 179.99);
INSERT INTO SupplyLogistics (Seller_ID, Product_ID, Seller_Price) VALUES (12, 36, 39.99);

SELECT * FROM SupplyLogistics;

-------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO ShippingAddresses (User_ID, Appartment_Name, Street, City, State, ZipCode, Region, Country)
VALUES
    -- North USA (6 addresses)
    (1, 'Northern Pines Apartments', '123 Pine Street', 'Seattle', 'Washington', '98101', 'North', 'USA'),
    (2, 'Snowy Peaks Residency', '456 Snowflake Lane', 'Anchorage', 'Alaska', '99501', 'North', 'USA'),
    (3, 'Frosty Meadows', '789 Frost Avenue', 'Minneapolis', 'Minnesota', '55401', 'North', 'USA'),
    (4, 'Glacial Heights', '123 Glacier Street', 'Fargo', 'North Dakota', '58102', 'North', 'USA'),
    (5, 'Chillview Condos', '456 Frost Lane', 'Portland', 'Maine', '04101', 'North', 'USA'),
    (6, 'Polar Vista Apartments', '789 Polar Lane', 'Bozeman', 'Montana', '59715', 'North', 'USA'),

    -- West USA (4 addresses)
    (7, 'Sunset Ridge Apartments', '123 Sunset Avenue', 'San Francisco', 'California', '94101', 'West', 'USA'),
    (8, 'Pacific Palms', '456 Pacific Street', 'Honolulu', 'Hawaii', '96813', 'West', 'USA'),
    (9, 'Golden Gate Residency', '789 Golden Lane', 'Portland', 'Oregon', '97201', 'West', 'USA'),
    (10, 'Rocky Coast Condos', '123 Rocky Street', 'San Diego', 'California', '92101', 'West', 'USA'),

    -- East USA (2 addresses)
    (11, 'Atlantic View Apartments', '123 Atlantic Avenue', 'New York', 'New York', '10001', 'East', 'USA'),
    (12, 'Harbor Lights Residency', '456 Harbor Lane', 'Boston', 'Massachusetts', '02101', 'East', 'USA'),

    -- South USA (8 addresses)
    (13, 'Southern Comfort Apartments', '123 Southern Street', 'Atlanta', 'Georgia', '30301', 'South', 'USA'),
    (14, 'Palm Tree Gardens', '456 Palm Lane', 'Miami', 'Florida', '33101', 'South', 'USA'),
    (15, 'Bayou View Residency', '789 Bayou Avenue', 'New Orleans', 'Louisiana', '70112', 'South', 'USA'),
    (16, 'Sunnyvale Condos', '123 Sunny Street', 'Orlando', 'Florida', '32801', 'South', 'USA'),
    (17, 'Gulf Coast Apartments', '456 Gulf Lane', 'Houston', 'Texas', '77001', 'South', 'USA'),
    (18, 'Riverfront Residency', '789 River Lane', 'Nashville', 'Tennessee', '37201', 'South', 'USA'),
    (19, 'Magnolia Manor', '123 Magnolia Avenue', 'Jackson', 'Mississippi', '39201', 'South', 'USA'),
    (20, 'Bayview Heights', '456 Bayview Street', 'Tampa', 'Florida', '33602', 'South', 'USA');


-- Adding some more addresses to new users(4021 - 4025) all in east region
INSERT INTO ShippingAddresses (User_ID, Appartment_Name, Street, City, State, ZipCode, Region, Country)
VALUES
    (21, 'Eastview Apartments', '123 East Street', 'New York', 'New York', '10001', 'East', 'USA'),
    (22, 'Harbor View Residency', '456 Harbor Lane', 'Boston', 'Massachusetts', '02101', 'East', 'USA'),
    (23, 'Brooklyn Heights', '789 Brooklyn Avenue', 'Brooklyn', 'New York', '11201', 'East', 'USA'),
    (24, 'Cambridge Gardens', '123 Cambridge Street', 'Cambridge', 'Massachusetts', '02138', 'East', 'USA'),
    (25, 'Providence Place', '456 Providence Lane', 'Providence', 'Rhode Island', '02903', 'East', 'USA');

SELECT * FROM ShippingAddresses;


--------------------------------------------------Make Shopping Carts for each User -----------------------------------------------

INSERT INTO ShoppingCart (User_ID) VALUES (1);
INSERT INTO ShoppingCart (User_ID) VALUES (2);
INSERT INTO ShoppingCart (User_ID) VALUES (3);
INSERT INTO ShoppingCart (User_ID) VALUES (4);
INSERT INTO ShoppingCart (User_ID) VALUES (5);
INSERT INTO ShoppingCart (User_ID) VALUES (6);
INSERT INTO ShoppingCart (User_ID) VALUES (7);
INSERT INTO ShoppingCart (User_ID) VALUES (8);
INSERT INTO ShoppingCart (User_ID) VALUES (9);
INSERT INTO ShoppingCart (User_ID) VALUES (10);
INSERT INTO ShoppingCart (User_ID) VALUES (11);
INSERT INTO ShoppingCart (User_ID) VALUES (12);
INSERT INTO ShoppingCart (User_ID) VALUES (13);
INSERT INTO ShoppingCart (User_ID) VALUES (14);
INSERT INTO ShoppingCart (User_ID) VALUES (15);
INSERT INTO ShoppingCart (User_ID) VALUES (16);
INSERT INTO ShoppingCart (User_ID) VALUES (17);
INSERT INTO ShoppingCart (User_ID) VALUES (18);
INSERT INTO ShoppingCart (User_ID) VALUES (19);
INSERT INTO ShoppingCart (User_ID) VALUES (20);
INSERT INTO ShoppingCart (User_ID) VALUES (21);
INSERT INTO ShoppingCart (User_ID) VALUES (22);
INSERT INTO ShoppingCart (User_ID) VALUES (23);
INSERT INTO ShoppingCart (User_ID) VALUES (24);
INSERT INTO ShoppingCart (User_ID) VALUES (25);


SELECT * from ShoppingCart;

-----------------------------------------------------------------------------------------------------------------------------------

-- Adding items to ShoppingCartItems for User 1's cart 
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (1, 1, 3); -- Headphones
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (1, 4, 2); -- Women's Dress
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (1, 7, 1); -- The Catcher in the Rye

-- Adding items to ShoppingCartItems for User 2's cart 
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (2, 2, 4); -- Smartwatch
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (2, 5, 2); -- Men's Suit
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (2, 8, 1); -- 1984

-- Adding items to ShoppingCartItems for User 3's cart 
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (3, 3, 5); -- Wireless Earbuds
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (3, 6, 2); -- Kids Jacket
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (3, 9, 1); -- Cookbook

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (4, 10, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (4, 11, 3);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (4, 12, 1);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (5, 13, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (5, 14, 5);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (5, 15, 6);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (6, 16, 1);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (6, 17, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (6, 18, 3);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (7, 19, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (7, 20, 5);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (7, 21, 6);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (8, 22, 1);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (8, 23, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (8, 24, 3);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (9, 25, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (9, 26, 5);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (9, 27, 6);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (10, 28, 1);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (10, 29, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (10, 30, 3);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (11, 3, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (11, 30, 4);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (12, 1, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (12, 28, 5);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (12, 27, 6);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (12, 7, 6);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (13, 32, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (13, 34, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (13, 25, 6);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (13, 4, 6);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (14, 2, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (14, 32, 3);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (14, 18, 4);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (15, 25, 1);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (15, 5, 6);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (15, 3, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (15, 20, 3);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (16, 30, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (16, 24, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (16, 20, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (16, 28, 6);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (17, 25, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (17, 2, 4);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (17, 9, 6);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (17, 18, 1);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (18, 31, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (18, 26, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (18, 11, 5);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (18, 8, 2);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (19, 1, 1);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (19, 19, 5);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (19, 28, 3);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (19, 13, 1);

INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (20, 19, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (20, 35, 3);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (20, 4, 2);
INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity) VALUES (20, 20, 4);

DECLARE @UserCart21 dbo.ProductQuantityTableType;

INSERT INTO @UserCart21 (ProductID, Quantity) VALUES (13, 3);
INSERT INTO @UserCart21 (ProductID, Quantity) VALUES (36, 6);
INSERT INTO @UserCart21 (ProductID, Quantity) VALUES (31, 9);
EXEC SP_AddProductsToCart @UserID = 21, @Products = @UserCart21;

DECLARE @UserCart22 dbo.ProductQuantityTableType;

INSERT INTO @UserCart22 (ProductID, Quantity) VALUES (30, 2);
INSERT INTO @UserCart22 (ProductID, Quantity) VALUES (20, 6);
INSERT INTO @UserCart22 (ProductID, Quantity) VALUES (32, 4);
INSERT INTO @UserCart22 (ProductID, Quantity) VALUES (30, 8);
INSERT INTO @UserCart22 (ProductID, Quantity) VALUES (7, 2);
EXEC SP_AddProductsToCart @UserID = 22, @Products = @UserCart22;

DECLARE @UserCart23 dbo.ProductQuantityTableType;

INSERT INTO @UserCart23 (ProductID, Quantity) VALUES (21, 1);
INSERT INTO @UserCart23 (ProductID, Quantity) VALUES (25, 6);
EXEC SP_AddProductsToCart @UserID = 23, @Products = @UserCart23;

DECLARE @UserCart24 dbo.ProductQuantityTableType;

INSERT INTO @UserCart24 (ProductID, Quantity) VALUES (16, 6);
INSERT INTO @UserCart24 (ProductID, Quantity) VALUES (10, 3);
INSERT INTO @UserCart24 (ProductID, Quantity) VALUES (9, 7);
EXEC SP_AddProductsToCart @UserID = 24, @Products = @UserCart24;

DECLARE @UserCart25 dbo.ProductQuantityTableType;

INSERT INTO @UserCart25 (ProductID, Quantity) VALUES (14, 7);
INSERT INTO @UserCart25 (ProductID, Quantity) VALUES (22, 9);
INSERT INTO @UserCart25 (ProductID, Quantity) VALUES (2, 3);
INSERT INTO @UserCart25 (ProductID, Quantity) VALUES (27, 8);
EXEC SP_AddProductsToCart @UserID = 25, @Products = @UserCart25;


select * from ShoppingCartItems;

-----------------------------------------------------------------------------------------------------------------------------------------
EXEC SP_CompleteOrderFromCart @UserID = 1, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 2, @ShippingMethod = 'Standard';
EXEC SP_CompleteOrderFromCart @UserID = 3, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 4, @ShippingMethod = 'Same-Day';
EXEC SP_CompleteOrderFromCart @UserID = 5, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 6, @ShippingMethod = 'Same-Day';
EXEC SP_CompleteOrderFromCart @UserID = 7, @ShippingMethod = 'Standard';
EXEC SP_CompleteOrderFromCart @UserID = 8, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 9, @ShippingMethod = 'Same-Day';
EXEC SP_CompleteOrderFromCart @UserID = 10, @ShippingMethod = 'Standard';
EXEC SP_CompleteOrderFromCart @UserID = 11, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 12, @ShippingMethod = 'Same-Day';
EXEC SP_CompleteOrderFromCart @UserID = 13, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 14, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 15, @ShippingMethod = 'Standard';
EXEC SP_CompleteOrderFromCart @UserID = 16, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 17, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 18, @ShippingMethod = 'Same-Day';
EXEC SP_CompleteOrderFromCart @UserID = 19, @ShippingMethod = 'Same-Day';
EXEC SP_CompleteOrderFromCart @UserID = 20, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 21, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 22, @ShippingMethod = 'Standard';
EXEC SP_CompleteOrderFromCart @UserID = 23, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 24, @ShippingMethod = 'Express';
EXEC SP_CompleteOrderFromCart @UserID = 25, @ShippingMethod = 'Same-Day';
--------------------------------------------------------------------------------------------------------------------

INSERT INTO Payments (Payment_Method, Payment_Date, Order_ID)
VALUES
    ('Credit', '2024-01-01', 1),
    ('Paypal', '2024-01-02', 2),
    ('Credit', '2024-01-03', 3),
    ('Paypal', '2024-01-04', 4),
    ('Debit', '2024-01-05', 5),
    ('Debit', '2024-04-10', 6),
    ('Paypal', '2024-02-01', 7),
    ('Credit', '2024-02-02', 8),
    ('Debit', '2024-02-03', 9),
    ('Credit', '2024-02-04', 10),
    ('Paypal', '2024-02-05', 11),
    ('Credit', '2024-02-06', 12),
    ('Debit', '2024-02-07', 13),
    ('Paypal', '2024-02-08', 14),
    ('Paypal', '2024-02-09', 15),
    ('Debit', '2024-02-10', 16),
    ('Credit', '2024-03-15', 17),
    ('Paypal', '2024-03-20', 18),
	('Credit', '2024-02-06', 19),
    ('Debit', '2024-02-07', 20),
    ('Paypal', '2024-02-08', 21),
    ('Paypal', '2024-02-09', 22),
    ('Debit', '2024-02-10', 23),
    ('Credit', '2024-03-15', 24),
    ('Paypal', '2024-03-20', 25)
 
SELECT * FROM Payments;

--------------------------------------------------------------------------------------------------------------------

-- Reviews for Product 2001
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (6, 1, 4, 'Good product, meets expectations.'),
    (13, 1, 5, 'Impressed with the quality and performance.'),
    (17, 1, 3, 'Average product, could be better.');

-- Reviews for Product 2002
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (8, 2, 5, 'Very satisfied with the purchase, excellent value.'),
    (10, 2, 4, 'Nice design, satisfied with the purchase.'),
    (20, 2, 5, 'Great product, highly recommended.');

-- Reviews for Product 2003
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (2, 3, 4, 'Happy with the purchase, good quality.'),
    (15, 3, 5, 'Impressed with the quality and design.'),
    (19, 3, 3, 'Average product, nothing exceptional.');

-- Reviews for Product 2004
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (3, 4, 5, 'Absolutely love it! Great purchase.'),
    (12, 4, 4, 'Satisfied with the product, serves its purpose well.'),
    (18, 4, 5, 'Great product, highly recommended.');

-- Reviews for Product 2005
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (7, 5, 4, 'Nice design and features, recommended.'),
    (11, 5, 5, 'Impressed with the durability and performance.'),
    (16, 5, 3, 'Product quality could be improved.');

-- Reviews for Product 2006
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (9, 6, 5, 'Excellent value for money, highly satisfied.'),
    (14, 6, 4, 'Good value for money, satisfied with the purchase.'),
    (15, 6, 3, 'Average product, nothing special.');


-- Reviews for Product 7
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (3, 7, 5, 'Excellent product, highly recommended.'),
    (4, 7, 4, 'Good value for money, satisfied with the purchase.'),
    (5, 7, 3, 'Average product, could be better.'),
    (6, 7, 5, 'Impressed with the quality and design.'),
    (7, 7, 4, 'Satisfied with the product, meets expectations.'),
    (8, 7, 5, 'Absolutely love it! Great purchase.'),
    (9, 7, 4, 'Nice design and functionality.');

-- Reviews for Product 8
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (10, 8, 4, 'Happy with the purchase, good quality.'),
    (11, 8, 5, 'Very satisfied with the product, exceeded expectations.'),
    (12, 8, 3, 'Average product, nothing exceptional.'),
    (13, 8, 5, 'Excellent value for money, highly recommended.'),
    (14, 8, 4, 'Satisfied with the purchase, meets my needs.'),
    (15, 8, 5, 'Impressed with the durability and design.'),
    (16, 8, 3, 'Product quality could be improved.');

-- Reviews for Product 9
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (17, 9, 5, 'Amazing product, exceeded my expectations.'),
    (18, 9, 4, 'Good quality and functionality, satisfied.'),
    (19, 9, 3, 'Average product, nothing special.'),
    (20, 9, 5, 'Very happy with the purchase, great value.'),
    (1, 9, 4, 'Nice design and features, recommended.'),
    (2, 9, 5, 'Excellent purchase, highly satisfied.'),
    (3, 9, 4, 'Happy with the product, serves its purpose well.');

-- Reviews for Product 10
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (4, 10, 4, 'Good product, meets expectations.'),
    (5, 10, 5, 'Impressed with the quality and performance.'),
    (6, 10, 3, 'Average product, could be better.'),
    (7, 10, 5, 'Very satisfied with the purchase, excellent value.'),
    (8, 10, 4, 'Nice design, satisfied with the purchase.'),
    (9, 10, 5, 'Great product, highly recommended.'),
    (10, 10, 4, 'Happy with the purchase, good quality.');

-- Reviews for Product 11
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (11, 11, 5, 'Absolutely love it! Great quality.'),
    (12, 11, 4, 'Good value for money, satisfied.'),
    (13, 11, 3, 'Average product, nothing special.'),
    (14, 11, 5, 'Very satisfied with the purchase, exceeded expectations.'),
    (15, 11, 4, 'Nice design and functionality, recommended.'),
    (16, 11, 5, 'Impressed with the durability and performance.'),
    (17, 11, 4, 'Happy with the purchase, serves its purpose well.');

-- Reviews for Product 12
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (18, 12, 4, 'Good product, meets expectations.'),
    (19, 12, 5, 'Excellent value for money, highly satisfied.'),
    (20, 12, 3, 'Average product, could be better.'),
    (1, 12, 5, 'Very happy with the purchase, great quality.'),
    (2, 12, 4, 'Satisfied with the product, serves its purpose well.'),
    (3, 12, 5, 'Great product, highly recommended.'),
    (4, 12, 4, 'Nice design and features, happy with the purchase.');

-- Reviews for Product 13
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (5, 13, 4, 'Happy with the purchase, good quality.'),
    (6, 13, 5, 'Very satisfied with the product, exceeded expectations.'),
    (7, 13, 3, 'Average product, nothing exceptional.'),
    (8, 13, 5, 'Excellent value for money, highly recommended.'),
    (9, 13, 4, 'Satisfied with the purchase, meets my needs.'),
    (10, 13, 5, 'Impressed with the durability and design.'),
    (11, 13, 3, 'Product quality could be improved.');

-- Ratings for Product 14
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (6, 14, 4, 'Satisfied with the purchase, good value.'),
    (13, 14, 3, 'Product quality could be better.'),
    (20, 14, 2, 'Disappointed with the product, not as expected.');

-- Ratings for Product 15
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (8, 15, 3, 'Average product, meets basic needs.'),
    (10, 15, 2, 'Not satisfied with the quality, expected better.'),
    (17, 15, 4, 'Good value for money, satisfied overall.');

-- Ratings for Product 16
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (2, 16, 4, 'Impressed with the design and functionality.'),
    (15, 16, 2, 'Product did not meet expectations, disappointed.'),
    (19, 16, 3, 'Average product, serves its purpose.');

-- Ratings for Product 17
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (3, 17, 3, 'Okay product, nothing special.'),
    (12, 17, 4, 'Satisfied with the purchase, good value for money.'),
    (18, 17, 2, 'Product quality could be improved.');

-- Reviews for Product 18
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (3, 18, 4, 'Impressive product, worth the purchase.'),
    (7, 18, 5, 'Highly satisfied with the quality and performance.'),
    (10, 18, 3, 'Product meets expectations, but not exceptional.'),
    (13, 18, 5, 'Fantastic product, exceeded my expectations.'),
    (16, 18, 4, 'Good value for money, would recommend.'),
    (19, 18, 2, 'Disappointed with the product quality.');

-- Reviews for Product 19
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (4, 19, 3, 'Average product, does the job.'),
    (8, 19, 4, 'Happy with the purchase, good quality.'),
    (11, 19, 5, 'Absolutely love it! Great value for money.'),
    (14, 19, 4, 'Impressed with the performance and durability.'),
    (17, 19, 3, 'Satisfied with the product, but expected better.'),
    (20, 19, 2, 'Not satisfied with the product, poor quality.');

-- Reviews for Product 20
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (5, 20, 5, 'Amazing product, exceeded my expectations.'),
    (9, 20, 4, 'Satisfied with the purchase, good value for money.'),
    (12, 20, 3, 'Product meets expectations, but not exceptional.'),
    (15, 20, 4, 'Good quality product, happy with the purchase.'),
    (18, 20, 2, 'Disappointed with the product quality.'),
    (20, 20, 5, 'Highly satisfied with the performance and durability.');

-- Reviews for Product 21
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (1, 21, 4, 'Impressed with the features and performance.'),
    (3, 21, 5, 'Excellent product, highly recommended.'),
    (6, 21, 3, 'Product is okay, could be better.'),
    (9, 21, 4, 'Satisfied with the purchase, good value.'),
    (12, 21, 5, 'Fantastic product, exceeded expectations.'),
    (15, 21, 2, 'Not happy with the product quality.');

-- Reviews for Product 22
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (2, 22, 3, 'Average product, does the job.'),
    (5, 22, 4, 'Happy with the purchase, good quality.'),
    (8, 22, 5, 'Absolutely love it! Great value for money.'),
    (11, 22, 4, 'Impressed with the performance and durability.'),
    (14, 22, 3, 'Satisfied with the product, but expected better.'),
    (17, 22, 2, 'Not satisfied with the product, poor quality.');

-- Reviews for Product 23
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (4, 23, 5, 'Amazing product, exceeded my expectations.'),
    (7, 23, 4, 'Satisfied with the purchase, good value for money.'),
    (10, 23, 3, 'Product meets expectations, but not exceptional.'),
    (13, 23, 4, 'Good quality product, happy with the purchase.'),
    (16, 23, 2, 'Disappointed with the product quality.'),
    (19, 23, 5, 'Highly satisfied with the performance and durability.');

-- Reviews for Product 24
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (2, 24, 4, 'Impressed with the features and performance.'),
    (5, 24, 5, 'Excellent product, highly recommended.'),
    (8, 24, 3, 'Product is okay, could be better.'),
    (11, 24, 4, 'Satisfied with the purchase, good value.'),
    (14, 24, 5, 'Fantastic product, exceeded expectations.'),
    (17, 24, 2, 'Not happy with the product quality.');

-- Reviews for Product 25
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (3, 25, 3, 'Average product, does the job.'),
    (6, 25, 4, 'Happy with the purchase, good quality.'),
    (9, 25, 5, 'Absolutely love it! Great value for money.'),
    (12, 25, 4, 'Impressed with the performance and durability.'),
    (15, 25, 3, 'Satisfied with the product, but expected better.'),
    (18, 25, 2, 'Not satisfied with the product, poor quality.');

-- Reviews for Product 26
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (4, 26, 5, 'Amazing product, exceeded my expectations.'),
    (7, 26, 4, 'Satisfied with the purchase, good value for money.'),
    (10, 26, 3, 'Product meets expectations, but not exceptional.'),
    (13, 26, 4, 'Good quality product, happy with the purchase.'),
    (16, 26, 2, 'Disappointed with the product quality.'),
    (19, 26, 5, 'Highly satisfied with the performance and durability.');

-- Reviews for Product 27
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (1, 27, 4, 'Impressed with the features and performance.'),
    (15, 27, 5, 'Excellent product, highly recommended.');

-- Reviews for Product 28
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (2, 28, 3, 'Average product, does the job.'),
    (16, 28, 4, 'Happy with the purchase, good quality.');

-- Reviews for Product 29
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (3, 29, 5, 'Absolutely love it! Great value for money.'),
    (17, 29, 4, 'Satisfied with the purchase, good value for money.');

-- Reviews for Product 30
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (4, 30, 4, 'Impressed with the performance and durability.'),
    (18, 30, 3, 'Satisfied with the product, but expected better.');

-- Reviews for Product 31
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (1, 31, 5, 'Excellent product, exceeded expectations.'),
    (15, 31, 4, 'Good quality and performance.'),
    (19, 31, 4, 'Satisfied with the purchase.'),
    (20, 31, 3, 'Average product, could be better.');

-- Reviews for Product 32
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (2, 32, 4, 'Impressed with the features and design.'),
    (16, 32, 3, 'Decent product, but slightly overpriced.'),
    (18, 32, 5, 'Absolutely love it! Great value for money.'),
    (20, 32, 4, 'Happy with the purchase, good quality.');

-- Reviews for Product 33
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (3, 33, 3, 'Average product, nothing special.'),
    (17, 33, 5, 'Fantastic product, highly recommended.'),
    (19, 33, 4, 'Satisfied with the performance and durability.'),
    (20, 33, 4, 'Impressed with the features and build quality.');

-- Reviews for Product 34
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (4, 34, 4, 'Good value for money, performs well.'),
    (18, 34, 3, 'Satisfied with the product, but expected better.'),
    (19, 34, 5, 'Excellent product, exceeded expectations.'),
    (20, 34, 4, 'Happy with the purchase, good quality.');

-- Reviews for Product 35
INSERT INTO Reviews (User_ID, Product_ID, Rating, Comment)
VALUES
    (5, 35, 5, 'Amazing product, highly recommended.'),
    (16, 35, 4, 'Impressed with the performance and design.'),
    (17, 35, 4, 'Satisfied with the purchase, good value for money.'),
    (19, 35, 3, 'Average product, could be better.');


Select * from Reviews;

------------------------------------------------------------------------------------------------------------------

INSERT INTO CustomerSupport (User_ID, Order_ID, Issue_Description, Status, Created_On)
VALUES
    (4, 4, 'Product damaged upon delivery', 'Open', '2024-04-05'),
    (7, 7, 'Late delivery', 'Open', '2024-04-05'),
    (1, 1, 'Missing item from order', 'Open', '2024-04-05'),
    (17, 13, 'Received wrong product', 'Open', '2024-04-05'),
    (8, 8, 'Defective product', 'Open', '2024-04-05'),
    (10, 9, 'Product not as described', 'Open', '2024-04-05'),
    (2, 2, 'Billing issue', 'Open', '2024-04-05'),
    (16, 12, 'Return request', 'Open', '2024-04-05'),
    (19, 15, 'Refund status inquiry', 'Open', '2024-04-05');

SELECT * FROM CustomerSupport;

----------------------------------------------------------------------------------------------------------
INSERT INTO Wishlist (User_ID) VALUES (2);
INSERT INTO Wishlist (User_ID) VALUES (4);
INSERT INTO Wishlist (User_ID) VALUES (6);
INSERT INTO Wishlist (User_ID) VALUES (8);
INSERT INTO Wishlist (User_ID) VALUES (10);
INSERT INTO Wishlist (User_ID) VALUES (12);
INSERT INTO Wishlist (User_ID) VALUES (14);
INSERT INTO Wishlist (User_ID) VALUES (16);
INSERT INTO Wishlist (User_ID) VALUES (18);
INSERT INTO Wishlist (User_ID) VALUES (20);
INSERT INTO Wishlist (User_ID) VALUES (22);
INSERT INTO Wishlist (User_ID) VALUES (24);

----------------------------------------------------------------------------------------------------------------------------
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (1, 3),
    (1, 10),
    (1, 28);

-- Add 2 random products to wishlist 2
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (2, 5),
    (2, 18);

-- Add 2 random products to wishlist 3
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (3, 7),
    (3, 32);

-- Add 5 random products to wishlist 4
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (4, 6),
    (4, 15),
    (4, 19),
    (4, 20),
    (4, 35);

-- Add 1 random product to wishlist 5
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (5, 34);

-- Add 2 random products to wishlist 6
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (6, 26),
    (6, 29);

-- Add 3 random products to wishlist 7
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (7, 1),
    (7, 13),
    (7, 33);

-- Add 6 random products to wishlist 8
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (8, 4),
    (8, 9),
    (8, 16),
    (8, 22),
    (8, 24),
    (8, 30);

-- Add 2 random products to wishlist 9
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (9, 11),
    (9, 36);

-- Add 2 random products to wishlist 10
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (10, 2),
    (10, 31);

-- Add 5 random products to wishlist 11
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (11, 12),
    (11, 30),
    (11, 19),
    (11, 11),
    (11, 35);

-- Add 3 random products to wishlist 12
INSERT INTO WishlistItems (Wishlist_ID, Product_ID)
VALUES
    (12, 11),
    (12, 16),
    (12, 33);



SELECT * FROM WishlistItems;

----------------------------------------------------------------------------