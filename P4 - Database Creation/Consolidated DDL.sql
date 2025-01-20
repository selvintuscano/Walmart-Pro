-- Create and use the WalmartPro database.
CREATE DATABASE WalmartPro;
USE WalmartPro;
GO


-- Creating Encryption

CREATE SYMMETRIC KEY EncryptionKey 

WITH ALGORITHM = AES_256 

ENCRYPTION BY PASSWORD = 'walmartpro'; 

-- Definition of the Users table.
-- Stores essential information about each user including contact information and account details.
CREATE TABLE Users (
    [User_ID] INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for the user.
    First_Name NVARCHAR(50) NOT NULL, -- User's first name.
    Last_Name NVARCHAR(50) NOT NULL, -- User's last name.
    Email NVARCHAR(256) NOT NULL UNIQUE, -- User's email address. Must be unique.
    Username NVARCHAR(50) NOT NULL UNIQUE, -- User's chosen username. Must be unique.
    [Password] NVARCHAR(256) NOT NULL, -- User's password. Ideally stored as a hash with a salt.
    Mobile_Number NVARCHAR(15), -- User's mobile phone number.
    Registration_Date DATETIME NOT NULL DEFAULT GETDATE(), -- The date and time of user registration.
    Last_Login_Date DATETIME, -- The date and time of the user's last login. Optional.
    CONSTRAINT CHK_Users_Mobile_Number CHECK (Mobile_Number LIKE '[0-9]%'), -- Ensures the mobile number consists of digits.
    CONSTRAINT CHK_Users_Email_Format CHECK (Email LIKE '%_@__%.__%') -- Validates the format of the email address.
);
GO

-- Definition of the Categories table.
-- Organizes products into distinct categories for easier management and navigation.
CREATE TABLE Categories (
    Category_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each category.
    Category_Name NVARCHAR(255) NOT NULL -- The name of the category.
);
GO

-- Definition of the Products table.
-- Contains information about each product including name, description, and pricing.
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each product.
    Product_Name NVARCHAR(100) NOT NULL, -- The name of the product.
    Product_Description NVARCHAR(1000), -- A detailed description of the product.
    Stock_Quantity INT, -- The quantity of the product currently in stock.
    Actual_Price MONEY, -- The price of the product.
    Category_ID INT, -- The category to which the product belongs.
    CONSTRAINT CHK_Products_Stock_Quantity CHECK (Stock_Quantity >= 0), -- Ensures stock quantity cannot be negative.
    CONSTRAINT CHK_Products_Actual_Price CHECK (Actual_Price >= 0), -- Ensures product price cannot be negative.
    CONSTRAINT FK_Products_Category FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID) ON DELETE CASCADE ON UPDATE CASCADE -- Establishes a relationship to the Categories table.
);
GO

-- Definition of the Orders table.
-- Tracks customer orders, including pricing, status, and related user information.
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each order.
    User_ID INT, -- The user who placed the order.
    Total_Price MONEY, -- The total price of the order.
    Order_Status NVARCHAR(50), -- The current status of the order (e.g., 'ORDER Placed', 'In Cart').
    Shipping_Method NVARCHAR(50) NOT NULL, -- The method of shipping chosen for the order.
    Order_Date DATETIME, -- The date and time when the order was placed.
	CONSTRAINT Order_Shipping_Method CHECK(Shipping_Method IN ('Standard', 'Express', 'Same-Day')),
    CONSTRAINT Order_Status_Check CHECK(Order_Status IN ('Order Placed', 'In Cart', 'Cancelled')), -- Validates the order status.
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE -- Links to the Users table.
);
GO

-- Definition of the Promotions table.
-- Manages promotions including discounts that can be applied to products.
CREATE TABLE Promotions (
    Promotion_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each promotion.
    Discount_Percentage INT, -- The percentage discount offered by the promotion.
    [Start_Date] DATETIME, -- The start date of the promotion.
    [End_Date] DATETIME, -- The end date of the promotion.
    CONSTRAINT CHK_Promotions_DateRange CHECK (End_Date >= Start_Date), -- Ensures the promotion end date is not before the start date.
    CONSTRAINT CHK_Promotions_Discount_Percentage CHECK (Discount_Percentage >= 0 AND Discount_Percentage <= 100) -- Ensures discount percentage is between 0 and 100.
);
GO

-- Definition of the Product_Promotions table.
-- Links products to promotions, allowing many-to-many relationships.
CREATE TABLE Product_Promotions (
    Promotion_Product_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each product-promotion link.
    Promotion_ID INT NOT NULL, -- The promotion being applied.
    Product_ID INT NOT NULL, -- The product the promotion applies to.
    CONSTRAINT FK_Product_Promotions_Promotion FOREIGN KEY (Promotion_ID) REFERENCES Promotions(Promotion_ID) ON DELETE CASCADE, -- Links to the Promotions table.
    CONSTRAINT FK_Product_Promotions_Product FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE -- Links to the Products table.
);
GO

-- Definition of the ShoppingCart table.
-- Represents a user's shopping cart, which can contain multiple items.
CREATE TABLE ShoppingCart (
    Cart_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each shopping cart.
    [User_ID] INT NOT NULL, -- The user to whom the shopping cart belongs.
    CONSTRAINT FK_ShoppingCart_User FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE -- Links to the Users table.
);
GO

-- Definition of the ShoppingCartItems table.
-- Contains items that are added to shopping carts, including product and quantity.
CREATE TABLE ShoppingCartItems (
    CartItem_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each cart item.
    Cart_ID INT NOT NULL, -- The shopping cart to which the item belongs.
    Product_ID INT NOT NULL, -- The product added to the cart.
    Quantity INT NOT NULL CHECK (Quantity > 0), -- The quantity of the product added.
    CONSTRAINT FK_ShoppingCartItems_Cart FOREIGN KEY (Cart_ID) REFERENCES ShoppingCart(Cart_ID) ON DELETE CASCADE, -- Links to the ShoppingCart table.
    CONSTRAINT FK_ShoppingCartItems_Product FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE -- Links to the Products table.
);
GO


-- REVIEWS TABLE: Captures customer feedback on products, including ratings and comments.
CREATE TABLE Reviews (
    Review_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each review.
    [User_ID] INT NOT NULL, -- Reference to the user who wrote the review.
    Product_ID INT NOT NULL, -- Reference to the product being reviewed.
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5), -- The rating given to the product, between 1 and 5.
    Comment NVARCHAR(1000), -- Optional textual comment provided by the user.
    Review_Date DATETIME NOT NULL DEFAULT GETDATE(), -- Date the review was posted, defaults to the current date.
    CONSTRAINT FK_Reviews_User FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE, -- Ensures referential integrity with Users table.
    CONSTRAINT FK_Reviews_Product FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE -- Ensures referential integrity with Products table.
);
GO

-- WISHLIST TABLE: Allows users to save products they are interested in for future consideration.
CREATE TABLE Wishlist (
    Wishlist_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each wishlist.
    [User_ID] INT NOT NULL, -- Reference to the user who owns the wishlist.
    CONSTRAINT FK_Wishlist_User FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE -- Ensures referential integrity with Users table.
);
GO

-- WISHLIST_ITEMS TABLE: Stores individual products saved in each user's wishlist.
CREATE TABLE WishlistItems (
    Wishlist_Item_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each wishlist item.
    Wishlist_ID INT NOT NULL, -- Reference to the wishlist.
    Product_ID INT NOT NULL, -- Reference to the product saved in the wishlist.
    CONSTRAINT FK_Wishlist_Id FOREIGN KEY (Wishlist_ID) REFERENCES Wishlist(Wishlist_ID) ON DELETE CASCADE, -- Links item to its wishlist.
    CONSTRAINT FK_Wishlist_Product FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE -- Ensures the product exists in Products table.
);
GO

-- PAYMENTS TABLE: Tracks payments made for orders, including transaction details.
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY IDENTITY(10000,1), -- Unique identifier for each payment, starting from 10000.
    Payment_Method NVARCHAR(50) NOT NULL, -- The method of payment used.
    Payment_Date DATETIME NOT NULL DEFAULT GETDATE(), -- Date of the payment, defaults to the current date.
    Transaction_Details NVARCHAR(1000), -- Additional details about the transaction.
    Order_ID INT, -- Reference to the order being paid for.
    CONSTRAINT FK_Payments_Order FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE SET NULL -- Links payment to its order. On order deletion, the link is nullified to preserve payment record.
);
GO

-- DELIVERY_LOGISTICS TABLE: Manages the delivery details of orders, including tracking and status.
CREATE TABLE Delivery_Logistics (
    Logistics_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each delivery record.
    Tracking_ID NVARCHAR(50) NOT NULL, -- The tracking number for the order's shipment.
    Expected_Delivery_Date DATETIME NOT NULL, -- The estimated delivery date.
    Actual_Delivery_Date DATETIME, -- The actual delivery date, can be null if not yet delivered.
    Status NVARCHAR(50) NOT NULL, -- The current status of the delivery.
    Order_ID INT NOT NULL, -- Reference to the related order.
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE, -- Ensures referential integrity with Orders table.
    CONSTRAINT CHK_Delivery_Logistics_Dates CHECK (Actual_Delivery_Date >= Expected_Delivery_Date OR Actual_Delivery_Date IS NULL) -- Ensures actual delivery date is not before the expected date.
);
GO

-- SHIPPING_ADDRESSES TABLE: Stores shipping addresses for users, can be used for multiple orders.
CREATE TABLE ShippingAddresses (
    Shipping_Address_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each shipping address.
    [User_ID] INT NOT NULL, -- Reference to the user the address belongs to.
	Appartment_Name NVARCHAR(100),
    Street NVARCHAR(255) NOT NULL, -- The street part of the address.
    City NVARCHAR(100) NOT NULL, -- The city part of the address.
    [State] NVARCHAR(100) NOT NULL, -- The state part of the address.
    ZipCode NVARCHAR(20) NOT NULL, -- The ZIP/postal code.
	Region NVARCHAR(25),
    Country NVARCHAR(100) NOT NULL, -- The country.
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE, -- Links address to its user.
    CONSTRAINT CHK_ShippingAddresses_ZipCode CHECK (LEN(ZipCode) >= 5 AND LEN(ZipCode) <= 9) -- Validates the length of the ZIP/postal code.
);
GO

-- CUSTOMER_SUPPORT TABLE: Records customer support issues and tracks their resolution status.
CREATE TABLE CustomerSupport (
    Support_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each support case.
    [User_ID] INT NOT NULL, -- Reference to the user who raised the issue.
    Order_ID INT, -- Optional reference to an order related to the support issue.
    Issue_Description NVARCHAR(1000) NOT NULL, -- A description of the issue.
    [Status] NVARCHAR(50) NOT NULL, -- The current status of the issue ('Open', 'Closed', 'Pending').
    Created_On DATETIME NOT NULL DEFAULT GETDATE(), -- The date and time the issue was created.
    CONSTRAINT CHK_CustomerSupport_Status CHECK ([Status] IN ('Open', 'Closed', 'Pending')), -- Ensures status value is valid.
    FOREIGN KEY ([User_ID]) REFERENCES Users([User_ID]) ON DELETE NO ACTION, -- Links issue to its user without cascading deletes.
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE NO ACTION -- Optionally links issue to an order without cascading deletes.
);
GO

-- SELLERS TABLE: Stores information about sellers who list their products on the platform.
CREATE TABLE Sellers (
    Seller_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each seller.
    Seller_First_Name NVARCHAR(50) NOT NULL, -- First name of the seller.
    Seller_Last_Name NVARCHAR(50) NOT NULL, -- Last name of the seller.
    Seller_Email NVARCHAR(256) NOT NULL UNIQUE, -- Email address of the seller, must be unique.
    Seller_Username NVARCHAR(50) NOT NULL UNIQUE, -- Username chosen by the seller, must be unique.
    Seller_Password NVARCHAR(256) NOT NULL, -- Seller's password, should be securely hashed in practice.
    Seller_Mobile_Number NVARCHAR(15), -- Mobile phone number of the seller.
    Registration_Date DATETIME NOT NULL DEFAULT GETDATE(), -- The date and time the seller registered.
    Last_Login_Date DATETIME, -- The date and time of the seller's last login.
    CONSTRAINT CHK_Seller_Mobile_Number CHECK (Seller_Mobile_Number LIKE '[0-9]%'), -- Validates the mobile number format.
    CONSTRAINT CHK_Seller_Email_Format CHECK (Seller_Email LIKE '%_@__%.__%') -- Validates the email format.
);
GO

--ORDER_PRODUCT_LINE
CREATE TABLE Order_Product_Line (
    Order_Product_ID INT PRIMARY KEY IDENTITY(1,1), -- Primary key, auto-increments for each order-product association.
    Order_ID INT NOT NULL, -- Foreign key linking to the Orders table.
    Product_ID INT NOT NULL, -- Foreign key linking to the Products table.
    Quantity INT NOT NULL CHECK (Quantity > 0), -- The quantity of the product in the order, must be positive.
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE, -- Cascading delete to remove line items if the order is deleted.
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE -- Cascading delete to remove line items if the product is deleted.
);
GO

-- SUPPLY_LOGISTICS TABLE: Manages logistics for product supplies from suppliers, including pricing.
CREATE TABLE SupplyLogistics (
    Supply_Logistics_ID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each supply logistics record.
    Seller_ID INT, -- Reference to the supplier.
    Product_ID INT NOT NULL, -- Reference to the supplied product.
    Seller_Price MONEY NOT NULL CHECK (Seller_Price >= 0), -- Price at which the product is supplied.
    CONSTRAINT FK_SupplyLogistics_Supplier FOREIGN KEY (Seller_ID) REFERENCES Sellers(Seller_ID) ON DELETE CASCADE, -- Links to the Suppliers table.
    CONSTRAINT FK_SupplyLogistics_Product FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE -- Ensures the product exists in Products table.
);
GO


-----------------------------------VIEWS-------------------------------------
-- UDF For Discounted Price.
CREATE FUNCTION dbo.CalculateDiscountedPrice (@ActualPrice MONEY, @DiscountPercentage INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @DiscountedPrice MONEY;
    SET @DiscountedPrice = @ActualPrice * (1 - @DiscountPercentage / 100.0);
    RETURN @DiscountedPrice;
END;
GO

--View for Active Promotions on Products
CREATE OR ALTER VIEW vw_ActiveProductPromotions
AS
SELECT 
    p.Product_ID,
    p.Product_Name,
    c.Category_Name, -- Category name from the Categories table
    s.Seller_First_Name + ' ' + s.Seller_Last_Name AS SellerFullName, -- Seller's full name
    s.Seller_Email, -- Seller's email address
    pr.Promotion_ID,
    pr.Discount_Percentage,
    p.Actual_Price,
    dbo.CalculateDiscountedPrice(p.Actual_Price, pr.Discount_Percentage) AS DiscountedPrice, -- Calculated discounted price using UDF
    pr.Start_Date,
    pr.End_Date
FROM 
    Product_Promotions pp
INNER JOIN 
    Promotions pr ON pp.Promotion_ID = pr.Promotion_ID
INNER JOIN 
    Products p ON pp.Product_ID = p.Product_ID
INNER JOIN 
    Categories c ON p.Category_ID = c.Category_ID -- Joining with Categories table
INNER JOIN 
    SupplyLogistics sl ON p.Product_ID = sl.Product_ID -- Assuming each product has supply logistics info
INNER JOIN 
    Sellers s ON sl.Seller_ID = s.Seller_ID -- Joining with Sellers table through SupplyLogistics
WHERE 
    pr.Start_Date <= GETDATE() AND pr.End_Date >= GETDATE(); -- Filtering for active promotions
GO


--- Customer Spendings

CREATE VIEW vw_EnhancedCustomerOrderSummary AS
SELECT 
    u.User_ID,
    dbo.GetFullName(u.First_Name, u.Last_Name) AS FullName,
    COUNT(o.Order_ID) AS NumberOfOrders,
    SUM(CASE WHEN o.Order_Status NOT IN ('In Cart') THEN o.Total_Price ELSE 0 END) AS TotalSpent,
    AVG(CASE WHEN o.Order_Status NOT IN ('In Cart') THEN o.Total_Price ELSE NULL END) AS AverageOrderValue,
    MAX(CASE WHEN o.Order_Status NOT IN ('In Cart') THEN o.Order_Date ELSE NULL END) AS LastOrderDate,
    (SELECT TOP 1 o2.Order_Status FROM Orders o2 WHERE o2.User_ID = u.User_ID AND o2.Order_Status NOT IN ('In Cart') ORDER BY o2.Order_Date DESC) AS LastOrderStatus,
    CASE 
        WHEN (SUM(CASE WHEN o.Order_Status NOT IN ('In Cart') THEN o.Total_Price ELSE 0 END) / NULLIF(DATEDIFF(MONTH, MIN(o.Order_Date), GETDATE()), 0)) >= 2500 THEN 'Gold'
        WHEN (SUM(CASE WHEN o.Order_Status NOT IN ('In Cart') THEN o.Total_Price ELSE 0 END) / NULLIF(DATEDIFF(MONTH, MIN(o.Order_Date), GETDATE()), 0)) >= 1500 THEN 'Silver'
        WHEN (SUM(CASE WHEN o.Order_Status NOT IN ('In Cart') THEN o.Total_Price ELSE 0 END) / NULLIF(DATEDIFF(MONTH, MIN(o.Order_Date), GETDATE()), 0)) >= 750 THEN 'Bronze'
        ELSE 'New'
    END AS CustomerSegment
FROM 
    Users u
INNER JOIN 
    Orders o ON u.User_ID = o.User_ID
GROUP BY 
    u.User_ID, u.First_Name, u.Last_Name;
GO


--- Inventory Quantity report

CREATE VIEW vw_ProductInventoryStatus AS
SELECT 
    p.Product_Name,
    SUM(p.Stock_Quantity) AS TotalStockQuantity, -- Aggregating stock quantity across all instances of the product
    CASE 
        WHEN SUM(p.Stock_Quantity) <= 0 THEN 'Out of Stock'
        WHEN SUM(p.Stock_Quantity) BETWEEN 1 AND 50 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS InventoryStatus
FROM 
    Products p
GROUP BY 
    p.Product_Name;
GO

---UDF FOR FULL NAME-------------------
CREATE OR ALTER FUNCTION dbo.GetFullName (@FirstName NVARCHAR(50), @LastName NVARCHAR(50))
RETURNS NVARCHAR(101) -- Assuming a maximum length of 100 characters for full name
AS
BEGIN
    DECLARE @FullName NVARCHAR(101);
    SET @FullName = @FirstName + ' ' + @LastName;
    RETURN @FullName;
END;
GO
--- Support Ticket Analysis

CREATE VIEW vw_EnhancedSupportTicketOverview AS
SELECT TOP (100) PERCENT
    cs.Support_ID,
    u.User_ID,
    dbo.GetFullName(u.First_Name, u.Last_Name) AS FullName, -- Using the UDF to get the full name
    cs.Order_ID,
    cs.Issue_Description,
    cs.Status,
    DATEDIFF(DAY, cs.Created_On, GETDATE()) AS DaysOpen,
    CASE 
        WHEN cs.Status IN ('Open', 'Pending') AND DATEDIFF(DAY, cs.Created_On, GETDATE()) > 3 THEN 'High Priority'
        WHEN cs.Status IN ('Open', 'Pending') AND DATEDIFF(DAY, cs.Created_On, GETDATE()) BETWEEN 1 AND 3 THEN 'Normal Priority'
        WHEN cs.Status IN ('Open', 'Pending') AND DATEDIFF(DAY, cs.Created_On, GETDATE()) < 1 THEN 'Low Priority'
        ELSE 'Resolved/Closed'
    END AS Priority,
    cs.Created_On
FROM 
    CustomerSupport cs
INNER JOIN 
    Users u ON cs.User_ID = u.User_ID
LEFT JOIN 
    Orders o ON cs.Order_ID = o.Order_ID
ORDER BY 
    CASE 
        WHEN cs.Status IN ('Open', 'Pending') AND DATEDIFF(DAY, cs.Created_On, GETDATE()) > 3 THEN 1
        WHEN cs.Status IN ('Open', 'Pending') AND DATEDIFF(DAY, cs.Created_On, GETDATE()) BETWEEN 1 AND 3 THEN 2
        WHEN cs.Status IN ('Open', 'Pending') AND DATEDIFF(DAY, cs.Created_On, GETDATE()) < 1 THEN 3
        ELSE 4
    END, 
    cs.Created_On DESC;
GO



---RATING'S Overview

CREATE OR ALTER VIEW vw_CategoryRatingSummary AS
SELECT TOP (100) PERCENT
    c.Category_Name,
    AVG(r.Rating) AS AverageRating,
    AVG(CASE WHEN r.Rating = 5 THEN 1.0 ELSE 0 END) AS AvgNoOf5StarRatings
FROM Reviews r
INNER JOIN Products p ON r.Product_ID = p.Product_ID
INNER JOIN Categories c ON p.Category_ID = c.Category_ID
GROUP BY c.Category_Name
ORDER BY AverageRating DESC;
GO

---------------------------------- Views Using UDF'S --------------------------------

--- cREATE A VIEW FOR CALCULATING ACTUAL_PRICE,GRAND_PRICE FOR EVERY ORDER.
CREATE FUNCTION dbo.fn_CalculateActualTotal (@OrderID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @Total MONEY;

    SELECT @Total = SUM(p.Actual_Price * opl.Quantity)
    FROM Order_Product_Line opl
    JOIN Products p ON opl.Product_ID = p.Product_ID
    WHERE opl.Order_ID = @OrderID;

    RETURN @Total;
END;
GO


CREATE FUNCTION dbo.fn_CalculateDiscountedTotal (@OrderID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @DiscountedTotal MONEY = 0;

    -- Iterate through each product in the order
    SELECT @DiscountedTotal = @DiscountedTotal + (CASE 
                                                    WHEN pp.Promotion_ID IS NOT NULL THEN 
                                                        p.Actual_Price * opl.Quantity * (1 - prm.Discount_Percentage / 100.0)
                                                    ELSE 
                                                        p.Actual_Price * opl.Quantity
                                                  END)
    FROM Order_Product_Line opl
    JOIN Products p ON opl.Product_ID = p.Product_ID
    LEFT JOIN Product_Promotions pp ON pp.Product_ID = p.Product_ID
    LEFT JOIN Promotions prm ON prm.Promotion_ID = pp.Promotion_ID
                             AND GETDATE() BETWEEN prm.Start_Date AND prm.End_Date
    WHERE opl.Order_ID = @OrderID;

    RETURN @DiscountedTotal;
END;
GO


CREATE OR ALTER VIEW vw_OrderPricingSummary AS
SELECT 
    o.Order_ID,
    o.User_ID,
    dbo.fn_CalculateActualTotal(o.Order_ID) AS Actual_Price,
    o.Total_Price AS Grand_Total
FROM 
    Orders o;
GO


---------------------------------- Triggers Using UDF'S --------------------------------

-- Define or alter the user-defined function to estimate delivery dates
CREATE OR ALTER FUNCTION dbo.EstimateDeliveryDateByOrderID
(
    @OrderID INT -- Input parameter: Unique identifier of the order
)
RETURNS DATE
AS
BEGIN
    -- Declare variables to hold intermediate data
    DECLARE @OrderDate DATE; -- Holds the date the order was placed
    DECLARE @ShippingMethod NVARCHAR(50); -- Holds the shipping method of the order
    DECLARE @EstimatedDeliveryDate DATE; -- Holds the calculated estimated delivery date

    -- Fetch the order date and shipping method for the given Order ID from the Orders table
    SELECT 
        @OrderDate = Order_Date, -- Assign the date the order was placed
        @ShippingMethod = Shipping_Method -- Assign the shipping method used for the order
    FROM Orders 
    WHERE Order_ID = @OrderID; -- Condition to match the specific order ID

    -- Calculate the estimated delivery date based on the shipping method
    -- The calculation adds a number of days to the order date depending on the shipping method
    SET @EstimatedDeliveryDate = CASE 
        WHEN @ShippingMethod = 'Standard' THEN DATEADD(DAY, 7, @OrderDate) -- Standard shipping: add 7 days
        WHEN @ShippingMethod = 'Express' THEN DATEADD(DAY, 3, @OrderDate) -- Express shipping: add 3 days
        WHEN @ShippingMethod = 'Same-Day' THEN DATEADD(DAY, 1, @OrderDate) -- Same-day shipping: add 1 day
        ELSE @OrderDate -- Default case: If shipping method is unknown, no days are added
    END;

    -- Return the calculated estimated delivery date
    RETURN @EstimatedDeliveryDate;
END;
GO

-- Create or alter a function to generate a unique Tracking_ID
CREATE OR ALTER FUNCTION dbo.GenerateTrackingID
(
    @OrderID INT -- Input parameter: Unique identifier of the order
)
RETURNS NVARCHAR(50)
AS
BEGIN
    -- Generate a tracking ID using the order ID and current timestamp
    DECLARE @TrackingID NVARCHAR(50);
    SET @TrackingID = 'TRACK-' + CAST(@OrderID AS NVARCHAR(10)) + '-' + REPLACE(CONVERT(NVARCHAR(20), GETDATE(), 112), '-', '') + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), ':', '');

    RETURN @TrackingID; -- Return the generated Tracking_ID
END;
GO


-- Triggers when order-status is placed it populates DELIVERY_LOGISTICS table with values using UDF Function.
CREATE OR ALTER TRIGGER trg_AutoPopulateDeliveryLogistics
ON Orders
AFTER INSERT, UPDATE
AS
BEGIN
    -- Prevents the message indicating the number of rows affected from being returned after each SQL statement
    SET NOCOUNT ON;

    -- Temporary table to store orders that have just been placed or updated to "Order Placed" status
    DECLARE @OrderPlacedTable TABLE (
        OrderID INT,
        UserID INT,
        ShippingMethod NVARCHAR(50),
        OrderDate DATETIME
    );

    -- Populate the temporary table with orders that are newly marked as "Order Placed".
    -- This includes new inserts and updates where the order status changes to "Order Placed".
    -- It excludes orders that were already in "Order Placed" status before the update.
    INSERT INTO @OrderPlacedTable (OrderID, UserID, ShippingMethod, OrderDate)
    SELECT i.Order_ID, i.User_ID, i.Shipping_Method, i.Order_Date
    FROM inserted i
    WHERE i.Order_Status = 'Order Placed'
    AND NOT EXISTS (
        SELECT 1 
        FROM deleted d 
        WHERE d.Order_ID = i.Order_ID 
        AND d.Order_Status = 'Order Placed'
    );

    -- Declare variables to hold order details while iterating through the temporary table
    DECLARE @OrderID INT, @UserID INT, @ShippingMethod NVARCHAR(50), @OrderDate DATETIME;

    -- Cursor to iterate over each order in the temporary table
    DECLARE order_cursor CURSOR FOR
        SELECT OrderID, UserID, ShippingMethod, OrderDate FROM @OrderPlacedTable;

    OPEN order_cursor;
    FETCH NEXT FROM order_cursor INTO @OrderID, @UserID, @ShippingMethod, @OrderDate;

    -- Loop through all the orders that have been marked as "Order Placed"
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Calculate the expected delivery date for the order based on the shipping method
        DECLARE @ExpectedDeliveryDate DATETIME;
        SET @ExpectedDeliveryDate = dbo.EstimateDeliveryDateByOrderID(@OrderID);

        -- Generate a unique tracking ID for the order using a custom function
        DECLARE @GeneratedTrackingID NVARCHAR(50) = dbo.GenerateTrackingID(@OrderID);

        -- Insert a new record into the Delivery_Logistics table with the order details,
        -- including the generated tracking ID and the calculated expected delivery date
        INSERT INTO Delivery_Logistics (Order_ID, Tracking_ID, Expected_Delivery_Date, Status)
        VALUES (@OrderID, @GeneratedTrackingID, @ExpectedDeliveryDate, 'Processing');

        -- Move to the next order in the cursor
        FETCH NEXT FROM order_cursor INTO @OrderID, @UserID, @ShippingMethod, @OrderDate;
    END;

    -- Clean up by closing and deallocating the cursor
    CLOSE order_cursor;
    DEALLOCATE order_cursor;
END;
GO

--------------------------------Trigger to manage stock quantity when order is placed or cancelled ------------------------
CREATE OR ALTER TRIGGER trg_AdjustProductStock
ON Orders
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Decrease stock for newly placed orders
    UPDATE Products
    SET Stock_Quantity = Stock_Quantity - opl.Quantity
    FROM inserted ins
    INNER JOIN Order_Product_Line opl ON ins.Order_ID = opl.Order_ID
    INNER JOIN Products p ON opl.Product_ID = p.Product_ID
    WHERE ins.Order_Status = 'Order Placed'
    AND NOT EXISTS (SELECT 1 FROM deleted WHERE Order_ID = ins.Order_ID);

    -- Adjust stock for updated orders
    DECLARE @OrderID INT;
    DECLARE @OldStatus NVARCHAR(50);
    DECLARE @NewStatus NVARCHAR(50);

    -- Cursor to go through each order that was updated with a status change
    DECLARE order_cursor CURSOR FOR
        SELECT ins.Order_ID, del.Order_Status, ins.Order_Status
        FROM inserted ins
        JOIN deleted del ON ins.Order_ID = del.Order_ID
        WHERE ins.Order_Status != del.Order_Status;

    OPEN order_cursor;
    FETCH NEXT FROM order_cursor INTO @OrderID, @OldStatus, @NewStatus;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Increase stock if order was cancelled
        IF @NewStatus = 'Cancelled' AND @OldStatus = 'Order Placed'
        BEGIN
            UPDATE Products
            SET Stock_Quantity = Stock_Quantity + opl.Quantity
            FROM Products p
            INNER JOIN Order_Product_Line opl ON p.Product_ID = opl.Product_ID
            WHERE opl.Order_ID = @OrderID;
        END
        -- Decrease stock if order status was changed to "Order Placed"
        ELSE IF @NewStatus = 'Order Placed'
        BEGIN
            UPDATE Products
            SET Stock_Quantity = Stock_Quantity - opl.Quantity
            FROM Products p
            INNER JOIN Order_Product_Line opl ON p.Product_ID = opl.Product_ID
            WHERE opl.Order_ID = @OrderID;
        END

        FETCH NEXT FROM order_cursor INTO @OrderID, @OldStatus, @NewStatus;
    END

    CLOSE order_cursor;
    DEALLOCATE order_cursor;
END;
GO

---------------------------------------TRIGGERS FOR MY AUDITDB --------------------------------------------
-- Create and use the WalmartPro database.
CREATE DATABASE WalmartPro_Audit;
USE WalmartPro_Audit;
GO

-- Triggeres on Users
CREATE TABLE WalmartPro_Audit.dbo.Audit_Users (
    AuditID INT PRIMARY KEY IDENTITY,
    ActionType VARCHAR(10), -- 'Insert', 'Update', 'Delete'
    UserID INT,
    Username NVARCHAR(50),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(256),
    Mobile_Number NVARCHAR(15),
    Registration_Date DATETIME,
    Last_Login_Date DATETIME,
    ChangeTimestamp DATETIME DEFAULT GETDATE(),
    ChangedBy NVARCHAR(50) -- Could be system or admin username
);

---Trigger for insert/delete
CREATE TRIGGER trg_Audit_Users
ON WalmartPro.dbo.Users
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- Handle inserts
    INSERT INTO WalmartPro_Audit.dbo.Audit_Users (ActionType, UserID, Username, FirstName, LastName, Email, Mobile_Number, Registration_Date, Last_Login_Date, ChangedBy)
    SELECT 'Insert', ins.User_ID, ins.Username, ins.First_Name, ins.Last_Name, ins.Email, ins.Mobile_Number, ins.Registration_Date, ins.Last_Login_Date, 'System'
    FROM inserted ins
    WHERE NOT EXISTS (SELECT 1 FROM deleted);
    -- Handle deletes
    INSERT INTO WalmartPro_Audit.dbo.Audit_Users (ActionType, UserID, Username, FirstName, LastName, Email, Mobile_Number, Registration_Date, Last_Login_Date, ChangedBy)
    SELECT 'Delete', del.User_ID, del.Username, del.First_Name, del.Last_Name, del.Email, del.Mobile_Number, del.Registration_Date, del.Last_Login_Date, 'System'
    FROM deleted del
    WHERE NOT EXISTS (SELECT 1 FROM inserted);
    -- Handle updates
    INSERT INTO WalmartPro_Audit.dbo.Audit_Users (ActionType, UserID, Username, FirstName, LastName, Email, Mobile_Number, Registration_Date, Last_Login_Date, ChangedBy)
    SELECT 'Update', ins.User_ID, ins.[Username], ins.[First_Name], ins.Last_Name, ins.Email, ins.Mobile_Number, ins.Registration_Date, ins.Last_Login_Date, 'System'
    FROM inserted ins
    JOIN deleted del ON ins.User_ID = del.User_ID;
END;



---Audit log table for Price_change
CREATE TABLE WalmartPro_Audit.dbo.Audit_Products_PriceChange (
    ChangeID INT PRIMARY KEY IDENTITY,
    ProductID INT,
    OldPrice MONEY,
    NewPrice MONEY,
    ChangeTimestamp DATETIME DEFAULT GETDATE(),
    ChangedBy NVARCHAR(50)
);
---Trigger for Price change
CREATE TRIGGER trg_Audit_ProductPrice
ON WalmartPro.dbo.Products
AFTER UPDATE
AS 
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(Actual_Price)
    BEGIN
        INSERT INTO WalmartPro_Audit.dbo.Audit_Products_PriceChange (ProductID, OldPrice, NewPrice, ChangedBy)
        SELECT ins.Product_ID, del.Actual_Price, ins.Actual_Price, 'System'
        FROM inserted ins
        JOIN deleted del ON ins.Product_ID = del.Product_ID
        WHERE ins.Actual_Price != del.Actual_Price;
    END
END;



------Audit Table for OrderStatus
CREATE TABLE WalmartPro_Audit.dbo.Audit_OrderChanges (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    OldStatus NVARCHAR(50), -- NULL for inserts
    NewStatus NVARCHAR(50), -- NULL for deletes
    Action NVARCHAR(50), -- Inserted, Updated, Deleted
    ActionTimestamp DATETIME DEFAULT GETDATE()
);
---Triggers for Order
CREATE TRIGGER trg_AuditAllOrderChanges
ON WalmartPro.dbo.Orders
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
    SET NOCOUNT ON;
    -- Handle inserts
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO WalmartPro_Audit.dbo.Audit_OrderChanges (OrderID, NewStatus, Action)
        SELECT Order_ID, Order_Status, 'Inserted'
        FROM inserted;
    END
    -- Handle updates
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO WalmartPro_Audit.dbo.Audit_OrderChanges (OrderID, OldStatus, NewStatus, Action)
        SELECT i.Order_ID, d.Order_Status, i.Order_Status, 'Updated'
        FROM inserted i
        JOIN deleted d ON i.Order_ID = d.Order_ID
        WHERE i.Order_Status != d.Order_Status; -- capturing only rows where the status has actually changed
    END
    -- Handle deletes
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO WalmartPro_Audit.dbo.Audit_OrderChanges (OrderID, OldStatus, Action)
        SELECT Order_ID, Order_Status, 'Deleted'
        FROM deleted;
    END
END;
GO

--------------------------------------------------- SP For Customer Support --------------------------------

USE WalmartPro;
GO

CREATE OR ALTER PROCEDURE SP_HandleCustomerSupportRequest
    @UserID INT,
    @IssueDescription NVARCHAR(1000),
    @OrderID INT = NULL, -- Optional parameter, defaults to NULL 
    @Status NVARCHAR(50) = 'Open' -- Default status is 'Open'
AS
BEGIN
    DECLARE @SupportID INT;
    
    -- Insert new support ticket
    INSERT INTO CustomerSupport (User_ID, Order_ID, Issue_Description, [Status], Created_On)
    VALUES (@UserID, @OrderID, @IssueDescription, @Status, GETDATE());

    -- Get the ID of the newly inserted support ticket
    SELECT @SupportID = SCOPE_IDENTITY();

    -- Return the Support ID for tracking
    SELECT 'SupportID' = @SupportID;
END;
GO


--------------------------------------------------- SP For Adding Products into Cart for Perticular User--------------------------------
USE WalmartPro;
GO

-- Create a type to hold product ID and quantity pairs
CREATE TYPE dbo.ProductQuantityTableType AS TABLE
(
    ProductID INT,
    Quantity INT
);
GO
--we'll create the stored procedure. This procedure will: 
--1. Check if the user has an existing shopping cart.
--2. If not, create a new shopping cart for the user.
--	2.1 Check for Availability
--3. For each product in the input table:
--	3.1 Check if the product is already in the cart.
--	3.2 If it is, update the quantity.
--	3.3 If it's not, add the new product to the cart.
USE WalmartPro;
GO

CREATE OR ALTER PROCEDURE SP_AddProductsToCart
    @UserID INT,
    @Products dbo.ProductQuantityTableType READONLY
AS
BEGIN
    SET NOCOUNT ON; -- Prevents extra result sets from interfering with SELECT statements.

    DECLARE @CartID INT;

    -- Check if the user already has a shopping cart
    SELECT @CartID = Cart_ID 
    FROM ShoppingCart 
    WHERE User_ID = @UserID;

    -- If no cart exists, create a new one
    IF @CartID IS NULL
    BEGIN
        INSERT INTO ShoppingCart (User_ID)
        VALUES (@UserID);
        SET @CartID = SCOPE_IDENTITY(); -- Retrieve the new Cart ID
    END

    DECLARE @ProductID INT, @Quantity INT, @CurrentStock INT;

    DECLARE product_cursor CURSOR FOR
        SELECT ProductID, Quantity FROM @Products;

    OPEN product_cursor;
    FETCH NEXT FROM product_cursor INTO @ProductID, @Quantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Check stock availability
        SELECT @CurrentStock = Stock_Quantity 
        FROM Products 
        WHERE Product_ID = @ProductID;

        -- Proceed if the quantity is positive and there's enough stock
        IF @Quantity > 0 AND @CurrentStock >= @Quantity
        BEGIN
            IF EXISTS (SELECT 1 FROM ShoppingCartItems WHERE Cart_ID = @CartID AND Product_ID = @ProductID)
            BEGIN
                -- Update quantity if the product is already in the cart
                UPDATE ShoppingCartItems
                SET Quantity = Quantity + @Quantity
                WHERE Cart_ID = @CartID AND Product_ID = @ProductID;
            END
            ELSE
            BEGIN
                -- Add new product to the cart
                INSERT INTO ShoppingCartItems (Cart_ID, Product_ID, Quantity)
                VALUES (@CartID, @ProductID, @Quantity);
            END
        END
        ELSE
        BEGIN
            -- Print error message if there's not enough stock
            PRINT 'Error: There is not enough stock available for ProductID ' + CAST(@ProductID AS NVARCHAR(10)) + '.';
        END

        FETCH NEXT FROM product_cursor INTO @ProductID, @Quantity;
    END

    CLOSE product_cursor;
    DEALLOCATE product_cursor;
END;
GO



---------------------------------------------- Stored Procedure to buy products whicha re in cart --------------------

USE WalmartPro;
GO

CREATE OR ALTER PROCEDURE SP_CompleteOrderFromCart
    @UserID INT,
    @ShippingMethod NVARCHAR(50)
AS
BEGIN
    DECLARE @CartID INT;
    DECLARE @OrderID INT;
    DECLARE @TotalPrice MONEY = 0;
    DECLARE @ProductID INT, @Quantity INT, @Price MONEY, @Discount MONEY;

    -- Temporary table to hold cart items and price calculations
    DECLARE @CartItems TABLE (ProductID INT, Quantity INT, Price MONEY, Discount DECIMAL(5, 2), Processed BIT);

    -- 1. Retrieve the Cart ID for the user
    SELECT @CartID = Cart_ID 
    FROM ShoppingCart 
    WHERE User_ID = @UserID;

    -- Exit if no cart exists
    IF @CartID IS NULL
    BEGIN
        RAISERROR('No shopping cart found for the user.', 16, 1);
        RETURN;
    END

    -- Populate the @CartItems table
    INSERT INTO @CartItems (ProductID, Quantity, Price, Discount, Processed)
    SELECT sci.Product_ID, sci.Quantity, p.Actual_Price, ISNULL(prm.Discount_Percentage, 0), 0
    FROM ShoppingCartItems sci
    JOIN Products p ON sci.Product_ID = p.Product_ID
    LEFT JOIN Product_Promotions pp ON pp.Product_ID = p.Product_ID
    LEFT JOIN Promotions prm ON prm.Promotion_ID = pp.Promotion_ID AND GETDATE() BETWEEN prm.Start_Date AND prm.End_Date
    WHERE sci.Cart_ID = @CartID;

    -- Calculate the total price for the order, considering discounts
    SELECT @TotalPrice = SUM(Quantity * Price * (1 - Discount / 100.0))
    FROM @CartItems;

    -- 3. Insert a new order with the total price calculated
    INSERT INTO Orders (User_ID, Total_Price, Order_Status, Shipping_Method, Order_Date)
    VALUES (@UserID, @TotalPrice, 'Order Placed', @ShippingMethod, GETDATE());

    SET @OrderID = SCOPE_IDENTITY();

    -- Process each item from the @CartItems table variable
    WHILE EXISTS(SELECT 1 FROM @CartItems WHERE Processed = 0)
    BEGIN
        SELECT TOP 1 @ProductID = ProductID, @Quantity = Quantity FROM @CartItems WHERE Processed = 0;

        -- Insert into Order_Product_Line
        INSERT INTO Order_Product_Line (Order_ID, Product_ID, Quantity)
        VALUES (@OrderID, @ProductID, @Quantity);

        -- Update stock quantity
        UPDATE Products
        SET Stock_Quantity = Stock_Quantity - @Quantity
        WHERE Product_ID = @ProductID;

        -- Mark as processed
        UPDATE @CartItems SET Processed = 1 WHERE ProductID = @ProductID;
    END

    -- 5. Clear the shopping cart
    DELETE FROM ShoppingCartItems WHERE Cart_ID = @CartID;
    DELETE FROM ShoppingCart WHERE Cart_ID = @CartID;
END;
GO




CREATE PROCEDURE RegisterUser
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(255), -- Assuming this column is set up with Always Encrypted
    @Username NVARCHAR(50),
    @Password NVARCHAR(255),
    @MobileNumber NVARCHAR(15),
    @NewUserID INT OUTPUT
AS
BEGIN
	
	-- Attempt to open the symmetric key
    OPEN SYMMETRIC KEY EncryptionKey
    DECRYPTION BY PASSWORD = 'walmartpro';

	-- Declare a variable to hold the hashed password
    DECLARE @EncryptedPassword varbinary(256);

    -- Hash the password
    SET @EncryptedPassword = EncryptByKey(Key_GUID('EncryptionKey'), CONVERT(varbinary(256), @Password));

	IF @EncryptedPassword IS NOT NULL
    BEGIN
    -- Insert new user details into Users table with the hashed password and encrypted email
    INSERT INTO Users (First_Name, Last_Name, Email, Username, Password, Mobile_Number)
    VALUES (@FirstName, @LastName, @Email, @Username, @EncryptedPassword, @MobileNumber);

    -- Get the ID of the newly registered user
    SET @NewUserID = SCOPE_IDENTITY();
    END

	-- Close the symmetric key if it was opened
    CLOSE SYMMETRIC KEY EncryptionKey;

    RETURN;
END;
GO

CREATE PROCEDURE RegisterSeller
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(255), -- Assuming this column is set up with Always Encrypted
    @Username NVARCHAR(50),
    @Password NVARCHAR(255),
    @MobileNumber NVARCHAR(15),
    @NewUserID INT OUTPUT
AS
BEGIN
	
	-- Attempt to open the symmetric key
    OPEN SYMMETRIC KEY EncryptionKey
    DECRYPTION BY PASSWORD = 'walmartpro';

	-- Declare a variable to hold the hashed password
    DECLARE @EncryptedPassword varbinary(256);

    -- Hash the password
    SET @EncryptedPassword = EncryptByKey(Key_GUID('EncryptionKey'), CONVERT(varbinary(256), @Password));

	IF @EncryptedPassword IS NOT NULL
    BEGIN
    -- Insert new user details into Users table with the hashed password and encrypted email
    INSERT INTO Sellers (Seller_First_Name, Seller_Last_Name, Seller_Email, Seller_Username, Seller_Password, Seller_Mobile_Number)
    VALUES (@FirstName, @LastName, @Email, @Username, @EncryptedPassword, @MobileNumber);

    -- Get the ID of the newly registered user
    SET @NewUserID = SCOPE_IDENTITY();
    END

	-- Close the symmetric key if it was opened
    CLOSE SYMMETRIC KEY EncryptionKey;

    RETURN;
END;
GO


---------------------------------------View for sales Report ------------------------------------------------------------------
CREATE OR ALTER VIEW vw_SalesReport AS
SELECT TOP 100 PERCENT
    p.Product_ID,
    p.Product_Name,
    c.Category_Name,
    COUNT(o.Order_ID) AS NumberOfOrders,
    AVG(opl.Quantity) AS AverageQuantitySoldPerOrder,
    SUM(opl.Quantity) AS TotalQuantitySold,
    p.Actual_Price AS SalePrice,
    SUM(opl.Quantity * p.Actual_Price) AS TotalRevenue
FROM 
    Orders o
INNER JOIN 
    Order_Product_Line opl ON o.Order_ID = opl.Order_ID
INNER JOIN 
    Products p ON opl.Product_ID = p.Product_ID
INNER JOIN 
    Categories c ON p.Category_ID = c.Category_ID
WHERE 
    o.Order_Status = 'Order Placed'
GROUP BY 
    p.Product_ID, p.Product_Name, c.Category_Name, p.Actual_Price
ORDER BY 
    TotalRevenue DESC;
GO

-----------------------------------------------View on Order Summary ------------------------------------------------
CREATE OR ALTER VIEW vw_OrderSummary AS
SELECT TOP (100) PERCENT
    o.Order_Date,
    o.Order_ID,
    COUNT(opl.Product_ID) AS NumberOfProducts,
    o.Total_Price AS GrandTotal,
    pay.Payment_Method
FROM 
    Orders o
INNER JOIN 
    Order_Product_Line opl ON o.Order_ID = opl.Order_ID
INNER JOIN 
    Payments pay ON o.Order_ID = pay.Order_ID
GROUP BY 
    o.Order_ID, o.Order_Date, o.Total_Price, pay.Payment_Method
ORDER BY 
    o.Order_Date DESC;
GO


--------------------------------------- View for Sales by State -------------------------------------------------------------

CREATE OR ALTER VIEW vw_SalesByState AS
SELECT TOP (100) PERCENT
    sa.State,
    sa.Region,
    sa.Country,
    COUNT(DISTINCT o.Order_ID) AS NumberOfOrders,
    SUM(o.Total_Price) AS TotalSales
FROM Orders o
JOIN ShippingAddresses sa ON o.User_ID = sa.User_ID
WHERE o.Order_Status = 'Order Placed'
GROUP BY sa.State, sa.Region, sa.Country
ORDER BY TotalSales DESC;

--------------------------------------------------Non Cluster Index-------------------------------------

CREATE NONCLUSTERED INDEX IDX_Products_Category_ID ON Products(Category_ID);

CREATE NONCLUSTERED INDEX IDX_Reviews_Product_ID_Rating ON Reviews(Product_ID, Rating);

CREATE NONCLUSTERED INDEX IDX_Order_Product_Line_Product_ID ON Order_Product_Line(Product_ID);
