### Preface 
### This script covers the creation of the database, insertion of the tables, and the population of these tables using DDL. 
### It makes use of a bridging table called "OrderItem". Details of both can be found down beside their respective piece of SQL.

### Set up and data prep
# Load the 3 CSV files into C:\ProgramData\MySQL\MySQL Server 8.0\Uploads

### Creation of corresponding database using DDL.

### Create Retail Database and Tables

DROP DATABASE IF EXISTS Retail;
CREATE DATABASE Retail;
USE Retail;

CREATE TABLE Customers(
CustomerId MEDIUMINT NOT NULL AUTO_INCREMENT, 
first_name VARCHAR(100),
last_name  VARCHAR(100),
email VARCHAR(100),
gender VARCHAR(100),
address VARCHAR(255), 
phone VARCHAR(100), 
city VARCHAR(100),
PRIMARY KEY (CustomerId)
);

CREATE TABLE product(
ProductId VARCHAR(100), 
ProductName VARCHAR(100),
employer_name VARCHAR(100), 
price INT, 
qtd INT, 
transaction_date VARCHAR(100),
CustomerId MEDIUMINT NOT NULL,  
PRIMARY KEY (ProductId),
FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
);

CREATE TABLE Suppliers(
SupplierId VARCHAR(100), 
supplier_name VARCHAR(100), 
ProductId VARCHAR(100), 
StockQty VARCHAR(100),
delivery_date VARCHAR(100),
PRIMARY KEY (SupplierId),
FOREIGN KEY (ProductId) REFERENCES product(ProductId)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv' 
INTO TABLE Customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerId, first_name, last_name,email,gender,address,phone,city);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product.csv' 
INTO TABLE product
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductId,ProductName,employer_name,price,qtd,transaction_date,CustomerId);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/suppliers.csv' 
INTO TABLE Suppliers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SupplierId,supplier_name ,ProductId,StockQty,delivery_date);


