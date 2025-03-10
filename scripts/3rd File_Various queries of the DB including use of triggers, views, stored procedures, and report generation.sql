-- Show all the details of the products that have a price greater than 100.

SELECT 
	ProductID, ProductName, 
	Price, SupplierID, 
	CategoryID
FROM Product
WHERE Price > 100
ORDER BY Price ASC;


-- Show all the products along with the supplier detail who supplied the products.

SELECT 
    p.ProductID, p.ProductName, p.Price, 
    s.SupplierID, s.Supplier_Name
FROM Product p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;


-- Create a view that shows the total number of items a customer buys from the business in October 2020 along with the total price (use group by)

CREATE VIEW CustomerPurchase AS
SELECT 
    COUNT(DISTINCT p.CustomerId) AS Total_Purchases, 
    CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name,
    SUM(p.Price) AS Total_Spent
FROM Product p
JOIN Customers c ON p.CustomerId = c.CustomerId
WHERE DATE_FORMAT(transaction_date, '%Y-%m') = '2020-10'
GROUP BY c.CustomerId, Customer_Name
ORDER BY Total_Purchases DESC;

-- Create a report of the annual sales (2020) of the business showing the total number of products sold and the total price sold every month (use A group by with roll-up)

SELECT 
    MONTH(transaction_date) AS Month, 
    COUNT(*) AS Total_Sales, 
    SUM(Price) AS Total_Revenue
FROM Product
WHERE YEAR(transaction_date) = 2020
GROUP BY Month WITH ROLLUP;

-- Display the growth in sales/services (as a percentage) for your business, from the 1st month of opening until now. 

SELECT 
    MONTH(transaction_date) AS MonthNum, 
    COUNT(*) AS Count_Sales
FROM Product
GROUP BY MonthNum
ORDER BY MonthNum ASC;

-- Calculates the month-over-month growth rate of sales transactions from a Product table.

WITH MonthlySales AS (
    SELECT 
        MONTH(transaction_date) AS MonthNum, 
        COUNT(*) AS Count_Sales
    FROM Product
    GROUP BY MonthNum
)
SELECT 
    MonthNum, 
    Count_Sales, 
    IFNULL(ROUND((Count_Sales - LAG(Count_Sales) OVER (ORDER BY MonthNum)) 
    / LAG(Count_Sales) OVER (ORDER BY MonthNum) * 100, 2), 0) AS Growth_Rate
FROM MonthlySales;

-- Delete all customers who never buy a product from the business

DELETE FROM Customers 
WHERE NOT EXISTS (
    SELECT 1 
    FROM Product 
    WHERE Product.CustomerId = Customers.CustomerId
);

 
