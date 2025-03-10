/*
=============================================================
Create Database and Tables
=============================================================
Script Purpose:
This script covers the creation of the database, insertion of the tables, and the population of these tables using DDL. 
It makes use of a bridging table called "OrderItem". Details of both can be found down beside their respective piece of SQL.

Set up and data prep
Load the 3 CSV files into your fold. 
Ex:
C:\ProgramData\MySQL\MySQL Server 8.0\Uploads

WARNING:
    Running this script will drop the entire 'Retail' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Drop and recreate the 'Retail' database
DROP DATABASE IF EXISTS Retail;

-- Create the 'Retail' database
CREATE DATABASE Retail;
USE Retail;

-- Create the 'Customers' table with optimized data types
CREATE TABLE Customers(
    CustomerId INT AUTO_INCREMENT, 
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    gender ENUM('Male', 'Female', 'Other'),
    address VARCHAR(255), 
    phone VARCHAR(20), 
    city VARCHAR(100),
    PRIMARY KEY (CustomerId)
) ENGINE=InnoDB;


-- Create the 'product' table
CREATE TABLE product(
    ProductId VARCHAR(100), 
    ProductName VARCHAR(100),
    employer_name VARCHAR(100), 
    price INT UNSIGNED, 
    qtd INT UNSIGNED, 
    transaction_date DATE, 
    CustomerId INT NOT NULL,  
    PRIMARY KEY (ProductId),
    FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Create the 'Suppliers' table
CREATE TABLE Suppliers(
    SupplierId INT AUTO_INCREMENT, 
    supplier_name VARCHAR(100), 
    ProductId VARCHAR(100), 
    StockQty INT UNSIGNED, 
    delivery_date DATE, 
    PRIMARY KEY (SupplierId),
    FOREIGN KEY (ProductId) REFERENCES product(ProductId) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Load the data from CSV files into the 'Customers' table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv' 
INTO TABLE Customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerId, first_name, last_name, email, gender, address, phone, city);


-- Load the data from CSV files into the 'Product' table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product.csv' 
INTO TABLE product
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductId, ProductName, employer_name, price, qtd, transaction_date, CustomerId);

-- Load the data from CSV files into the 'Suppliers' table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/suppliers.csv' 
INTO TABLE Suppliers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SupplierId, supplier_name, ProductId, StockQty, delivery_date);


