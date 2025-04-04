create database sales_db;
use sales_db;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Region VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers VALUES
(1, 'Amit Sharma', 'North'),
(2, 'Sneha Verma', 'East'),
(3, 'Suresh Reddy', 'South'),
(4, 'Pooja Iyer', 'West'),
(5, 'Neha Gupta', 'North');

INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 1000.00),
(2, 'Mouse', 'Accessories', 25.00),
(3, 'Keyboard', 'Accessories', 50.00),
(4, 'Monitor', 'Electronics', 300.00),
(5, 'Printer', 'Electronics', 150.00);

INSERT INTO Sales VALUES
(1, 1, 1, '2024-03-01', 2),
(2, 2, 2, '2024-03-02', 5),
(3, 3, 3, '2024-03-03', 3),
(4, 4, 4, '2024-03-04', 1),
(5, 5, 5, '2024-03-05', 4),
(6, 1, 2, '2024-03-06', 3),
(7, 2, 1, '2024-03-07', 1),
(8, 3, 4, '2024-03-08', 2),
(9, 4, 5, '2024-03-09', 3),
(10, 5, 3, '2024-03-10', 2),
(11, 1, 4, '2024-03-11', 1),
(12, 2, 5, '2024-03-12', 2),
(13, 3, 1, '2024-03-13', 1),
(14, 4, 2, '2024-03-14', 5),
(15, 5, 3, '2024-03-15', 3),
(16, 1, 5, '2024-03-16', 2),
(17, 2, 4, '2024-03-17', 1),
(18, 3, 2, '2024-03-18', 4),
(19, 4, 1, '2024-03-19', 2),
(20, 5, 4, '2024-03-20', 1);


SELECT 
    S.CustomerID, 
    C.CustomerName, 
    S.SaleID, 
    P.ProductName, 
    S.Quantity, 
    S.SaleDate,
    RANK() OVER (PARTITION BY S.CustomerID ORDER BY S.Quantity DESC) AS 'Rank',
    DENSE_RANK() OVER (PARTITION BY S.CustomerID ORDER BY S.Quantity DESC) AS DenseRank,
    ROW_NUMBER() OVER (PARTITION BY S.CustomerID ORDER BY S.SaleDate) AS RowNum,
    SUM(S.Quantity) OVER (PARTITION BY S.CustomerID ORDER BY S.SaleDate) AS RunningTotal,
    ROUND(AVG(S.Quantity) OVER (PARTITION BY S.CustomerID ORDER BY S.SaleDate), 2) AS RollingAvg,
    LEAD(S.Quantity) OVER (PARTITION BY S.CustomerID ORDER BY S.SaleDate) AS NextSale,
    LAG(S.Quantity) OVER (PARTITION BY S.CustomerID ORDER BY S.SaleDate) AS PrevSale,
    FIRST_VALUE(S.Quantity) OVER (PARTITION BY S.CustomerID ORDER BY S.SaleDate) AS FirstSale
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
JOIN Products P ON S.ProductID = P.ProductID;
