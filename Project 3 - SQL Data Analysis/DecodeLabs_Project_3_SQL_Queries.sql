
-- DecodeLabs Project 3: SQL Data Analysis
-- Dataset: Dataset for Data Analytics.xlsx

-- 1. Inspect the data
SELECT * FROM orders LIMIT 10;

-- 2. Count total orders
SELECT COUNT(*) AS Total_Orders
FROM orders;

-- 3. Filter orders using WHERE
SELECT
    OrderID,
    Date,
    Product,
    Quantity,
    TotalPrice,
    OrderStatus
FROM orders
WHERE Date >= '2024-01-01'
  AND TotalPrice >= 2000
ORDER BY TotalPrice DESC;

-- 4. Product-wise analysis
SELECT
    Product,
    COUNT(*) AS Number_of_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM orders
GROUP BY Product
ORDER BY Total_Sales DESC;

-- 5. Order status analysis
SELECT
    OrderStatus,
    COUNT(*) AS Number_of_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM orders
GROUP BY OrderStatus
ORDER BY Number_of_Orders DESC;

-- 6. Payment method analysis
SELECT
    PaymentMethod,
    COUNT(*) AS Number_of_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM orders
GROUP BY PaymentMethod
ORDER BY Total_Sales DESC;

-- 7. Referral source analysis
SELECT
    ReferralSource,
    COUNT(*) AS Number_of_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM orders
GROUP BY ReferralSource
ORDER BY Total_Sales DESC;

-- 8. Average Order Value
SELECT
    COUNT(*) AS Total_Orders,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales,
    ROUND(AVG(TotalPrice), 2) AS Average_Order_Value,
    ROUND(AVG(Quantity), 2) AS Average_Quantity_Per_Order
FROM orders;

-- 9. Coupon analysis
SELECT
    COALESCE(CouponCode, 'No Coupon') AS Coupon_Status,
    COUNT(*) AS Number_of_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales
FROM orders
GROUP BY Coupon_Status
ORDER BY Total_Sales DESC;

-- 10. Product analysis with AVG
SELECT
    Product,
    COUNT(*) AS Number_of_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales,
    ROUND(AVG(UnitPrice), 2) AS Average_Unit_Price,
    ROUND(AVG(TotalPrice), 2) AS Average_Order_Value
FROM orders
GROUP BY Product
ORDER BY Total_Sales DESC;

-- 11. HAVING example
SELECT
    Product,
    COUNT(*) AS Number_of_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales,
    ROUND(AVG(TotalPrice), 2) AS Average_Order_Value
FROM orders
GROUP BY Product
HAVING COUNT(*) > 170
ORDER BY Total_Sales DESC;

-- 12. Sales percentage contribution by product
SELECT
    Product,
    ROUND(SUM(TotalPrice), 2) AS Total_Sales,
    ROUND(
        SUM(TotalPrice) * 100.0 /
        (SELECT SUM(TotalPrice) FROM orders),
        2
    ) AS Sales_Percentage
FROM orders
GROUP BY Product
ORDER BY Total_Sales DESC;
