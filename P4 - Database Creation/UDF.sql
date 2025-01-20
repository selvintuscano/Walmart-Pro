---UDF For Discounted Price.
CREATE FUNCTION dbo.CalculateDiscountedPrice (@ActualPrice MONEY, @DiscountPercentage INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @DiscountedPrice MONEY;
    SET @DiscountedPrice = @ActualPrice * (1 - @DiscountPercentage / 100.0);
    RETURN @DiscountedPrice;
END;
GO

---UDF FOR FULL NAME
CREATE OR ALTER FUNCTION dbo.GetFullName (@FirstName NVARCHAR(50), @LastName NVARCHAR(50))
RETURNS NVARCHAR(101) -- Assuming a maximum length of 100 characters for full name
AS
BEGIN
    DECLARE @FullName NVARCHAR(101);
    SET @FullName = @FirstName + ' ' + @LastName;
    RETURN @FullName;
END;
GO

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

--- Creating UDF FOR CALCULATING GRAND TOTAL AFTER DISCOUNT IF PRODUCT HAS PROMOTION
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