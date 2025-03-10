# Show all the details of the products that have a price greater than 100.

SELECT * 
FROM product 
WHERE price > 100 
ORDER BY price ASC


#  Show all the products along with the supplier detail who supplied the products.

SELECT product.*,  suppliers.SupplierID, suppliers.Supplier_Name
FROM product 
INNER JOIN suppliers
ON product.ProductID = suppliers.ProductID


#  Create a view that shows the total number of items a customer buys from the business in October 2020 along with the total price (use group by)

CREATE VIEW customerpurchase AS
SELECT count(CustomerId) AS Customer_Purchase, concat(c.First_Name," ", c.Last_Name) AS Customer_Name
FROM product p
JOIN customers c
ON   p.CustomerId = c.CustomerId
WHERE transaction_date between '2020-10-01' and '2020-10-31'
GROUP BY Customer_Name
ORDER BY count(CustomerId) DESC;

# Create a report of the annual sales (2020) of the business showing the total number of products sold and the total price sold every month (use A group by with roll-up)

SELECT MONTH(Product.transaction_date) as Month, count(*) as Sales
FROM Product
WHERE transaction_date LIKE "%2020%"
GROUP BY MONTH(Product.transaction_date) WITH ROLLUP;

# Display the growth in sales/services (as a percentage) for your business, from the 1st month of opening until now. 

SELECT MONTH(transaction_date) AS MonthNum, count(*)  AS Count_Sales
FROM Product
GROUP BY MonthNum;
 
SELECT 
   LastMonth.*
   , ifnull(round((LastMonth.Count_Sales - CurMonth.Count_Sales)/CurMonth.Count_Sales * 10000)/100, 0) AS Growth_Rate
FROM ( 
    SELECT MONTH(transaction_date) AS MonthNum, count(*) Count_Sales
    FROM Product
    GROUP BY MonthNum) AS LastMonth
LEFT JOIN (
    SELECT MONTH(transaction_date) AS MonthNum, count(*) Count_Sales
    FROM Product
	GROUP BY MonthNum) AS CurMonth ON CurMonth.MonthNum = LastMonth.MonthNum - 1
    ORDER BY MonthNum ASC;
    

# Delete all customers who never buy a product from the business

DELETE FROM customers
WHERE CustomerId NOT IN (SELECT product.CustomerId FROM product);

 
