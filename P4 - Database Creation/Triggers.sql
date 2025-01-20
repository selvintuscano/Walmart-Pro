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

---Trigger to manage stock quantity when order is placed or cancelled
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


---Trigger for insert/delete
USE WalmartPro_Audit;
GO
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


---Trigger for Price change
USE WalmartPro_Audit;
GO
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

---Triggers for Order
USE WalmartPro_Audit;
GO
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


