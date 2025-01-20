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

---View's for Order Summary
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


---View for sales Report
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

----View for Sales by State
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