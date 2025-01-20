---- SP For Customer Support 
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


---- SP For Adding Products into Cart for Perticular User
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

---- Stored Procedure to buy products whicha re in cart 
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

---- Stored Procedure Register Users 
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

---- Stored Procedure Register Sellers
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