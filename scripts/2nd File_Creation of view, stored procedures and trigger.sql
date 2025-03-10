-- Create a stored procedure that takes the start and end dates of the sales and display all the sales transactions between the start and the end dates.

DROP PROCEDURE IF EXISTS GetDates; 
DELIMITER $$
 CREATE PROCEDURE GetDates(IN Start_date datetime, Finish_date datetime )
  BEGIN
  SELECT product. *
  FROM product 
  WHERE product.transaction_date between Start_date  AND  Finish_date;
  END $$
 DELIMITER ;
 
CALL GetDates ('2020-04-01', '2020-06-30') ;

#  Create a trigger that adjusts the stock level every time a product is sold.

DROP TRIGGER IF EXISTS UpdateStock;
DELIMITER $$
CREATE TRIGGER UpdateStock
AFTER INSERT ON product
FOR EACH ROW 
BEGIN
UPDATE Suppliers
SET NEW.Suppliers.StockQty = NEW.Suppliers.StockQty - NEW.product.qtd
WHERE NEW.product.qtd = NEW.Suppliers.StockQty ;
END$$
DELIMITER ;
