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
    Seller_Password NVARCHAR(256) NOT NULL DEFAULT EncryptByKey(Key_GUID('EncryptionKey'), CONVERT(varbinary(256), '')), -- Seller's password, should be securely hashed in practice.
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

---------------------------------------CREATING FOR MY AUDITDB --------------------------------------------
-- Create and use the WalmartPro AUDIT database.
CREATE DATABASE WalmartPro_Audit;

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

---Audit log table for Price_change
CREATE TABLE WalmartPro_Audit.dbo.Audit_Products_PriceChange (
    ChangeID INT PRIMARY KEY IDENTITY,
    ProductID INT,
    OldPrice MONEY,
    NewPrice MONEY,
    ChangeTimestamp DATETIME DEFAULT GETDATE(),
    ChangedBy NVARCHAR(50)
);

------Audit Table for OrderStatus
CREATE TABLE WalmartPro_Audit.dbo.Audit_OrderChanges (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    OldStatus NVARCHAR(50), -- NULL for inserts
    NewStatus NVARCHAR(50), -- NULL for deletes
    Action NVARCHAR(50), -- Inserted, Updated, Deleted
    ActionTimestamp DATETIME DEFAULT GETDATE()
);