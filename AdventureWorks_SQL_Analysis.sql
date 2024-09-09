-- Script: AdventureWorks_SQL_Analysis.sql

-- 1. Retrieve the total number of customers.
-- This query counts the total number of customers in the Sales.Customer table.
SELECT COUNT(CustomerID) AS TotalCustomers
FROM Sales.Customer;
-- Retrieves the total count of unique customers in the AdventureWorks database.

-- 2. Retrieve the top 5 products with the highest list prices.
-- Fetches the products with the highest prices from the Production.Product table.
SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
-- Retrieves the top 5 products based on ListPrice in descending order.

-- 3. Retrieve the top 5 most expensive products based on ListPrice.
-- Fetches the same data as the previous query but with an emphasis on expensive products.
SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
-- Retrieves the most expensive products based on ListPrice.

-- 4. Retrieve order details for a specific customer (CustomerID: 11091).
-- This query retrieves order information for the customer with ID 11091.
SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
WHERE CustomerID = 11091;
-- Displays the order number, date, and total amount due for the specified customer.

-- 5. Calculate total revenue for each product.
-- Calculates revenue by multiplying the quantity ordered by the unit price for each product.
SELECT P.Name, SUM(SOD.OrderQty * SOD.UnitPrice) AS TotalRevenue
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON SOD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;
-- Returns the total revenue generated for each product, sorted by the highest revenue.

-- 6. Retrieve the top 3 best-selling products by total quantity sold.
-- This query retrieves the products with the highest quantity sold.
SELECT TOP 3 P.Name, SUM(SOD.OrderQty) AS TotalQuantitySold
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON SOD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalQuantitySold DESC;
-- Displays the top 3 products with the highest total quantity sold.

-- 7. Retrieve the number of orders placed each year.
-- This query groups and counts the total number of orders placed in each year.
SELECT YEAR(OrderDate) AS OrderYear, COUNT(SalesOrderID) AS TotalOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
-- Displays the number of orders placed for each year.

-- 8. Calculate the total sales amount for each year.
-- This query calculates the total revenue (TotalDue) for each year.
SELECT YEAR(OrderDate) AS SalesYear, SUM(TotalDue) AS TotalSalesAmount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY SalesYear;
-- Returns the total sales amount for each year.

-- 9. Calculate the total revenue for each sales territory.
-- This query calculates revenue by territory using TotalDue.
SELECT ST.Name AS TerritoryName, SUM(SOH.TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader SOH
JOIN Sales.SalesTerritory ST ON SOH.TerritoryID = ST.TerritoryID
GROUP BY ST.Name
ORDER BY TotalRevenue DESC;
-- Displays the total revenue generated in each sales territory.

-- 10. Calculate the average sales amount per order for each month in the year 2012.
-- This query calculates the average amount per order for each month in 2012.
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, 
       AVG(TotalDue) AS AvgSalesAmountPerOrder
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;
-- Returns the average sales amount per order for each month in the year 2012.
