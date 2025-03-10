-- It will create a stored procedure that takes the start and end dates of the sales and display all the sales transactions between the start and the end dates.

DROP PROCEDURE IF EXISTS GetDates; 
DELIMITER $$

CREATE PROCEDURE GetDates(IN Start_date DATE, IN Finish_date DATE)
BEGIN
    SELECT p.*
    FROM Product p
    WHERE p.transaction_date BETWEEN Start_date AND Finish_date;
END $$

DELIMITER ;

CALL GetDates('2020-04-01', '2020-06-30');

-- It will create a trigger that adjusts the stock level every time a product is sold.

DROP TRIGGER IF EXISTS UpdateStock;
DELIMITER $$

CREATE TRIGGER UpdateStock
AFTER INSERT ON Product
FOR EACH ROW 
BEGIN
    UPDATE Suppliers
    SET StockQty = StockQty - NEW.qtd
    WHERE Suppliers.SupplierID = NEW.SupplierID;
END $$

DELIMITER ;


DROP TRIGGER IF EXISTS UpdateStock;
DELIMITER $$

CREATE TRIGGER UpdateStock
AFTER INSERT ON Product
FOR EACH ROW 
BEGIN
    -- Declare a variable to store current stock level
    DECLARE current_stock INT;

    -- Get the current stock of the supplier for the product
    SELECT StockQty INTO current_stock
    FROM Suppliers
    WHERE SupplierID = NEW.SupplierID;

    -- Check if there is enough stock before updating
    IF current_stock < NEW.qtd THEN
        -- Log the error to StockUpdateLog
        INSERT INTO StockUpdateLog (SupplierID, ProductID, Quantity, ErrorMessage)
        VALUES (NEW.SupplierID, NEW.ProductID, NEW.qtd, 'Error: Not enough stock available!');
        
        -- Raise an error to prevent further processing
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Not enough stock available!';
    ELSE
        -- Update stock level
        UPDATE Suppliers
        SET StockQty = StockQty - NEW.qtd
        WHERE SupplierID = NEW.SupplierID;
    END IF;
END $$

DELIMITER ;

