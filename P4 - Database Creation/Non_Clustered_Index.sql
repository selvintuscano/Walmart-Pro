--------------------------------------------------Non Cluster Index-------------------------------------

CREATE NONCLUSTERED INDEX IDX_Products_Category_ID ON Users(First_Name,Last_Name);

CREATE NONCLUSTERED INDEX IDX_Reviews_Product_ID_Rating ON Reviews(Product_ID, Rating);

CREATE NONCLUSTERED INDEX IDX_Order_Product_Line_Product_ID ON Order_Product_Line(Product_ID);
