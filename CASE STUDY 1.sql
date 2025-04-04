USE SalesAnalysisDB;
GO

-- Task 1
SELECT COUNT(DISTINCT State) AS NumberOfStates
FROM LocationTable;
GO

-- Task 2
SELECT COUNT(*) AS NumberOfRegularProducts
FROM ProductTable
WHERE Type = 'Regular';
GO

-- Task 3
SELECT SUM(Marketing) AS TotalMarketingSpending
FROM FactTable
WHERE ProductID = 1;
GO

-- Task 4
SELECT MIN(Sales) AS MinimumSales
FROM FactTable;
GO

-- Task 5
SELECT MAX(COGS) AS MaximumCOGS
FROM FactTable;
GO

-- Task 6
SELECT *
FROM ProductTable
WHERE ProductType = 'Coffee';
GO

-- Task 7
SELECT *
FROM FactTable
WHERE TotalExpenses > 40;
GO

-- Task 8
SELECT AVG(Sales) AS AverageSales
FROM FactTable
WHERE AreaCode = 719;
GO

-- Task 9
SELECT SUM(Profit) AS TotalProfit
FROM FactTable
WHERE AreaCode IN (SELECT AreaCode FROM LocationTable WHERE State = 'Colorado');
GO

-- Task 10
SELECT ProductID, AVG(Inventory) AS AverageInventory
FROM FactTable
GROUP BY ProductID;
GO

-- Task 11
SELECT DISTINCT State
FROM LocationTable
ORDER BY State;
GO

-- Task 12
SELECT ProductID, AVG(BudgetMargin) AS AverageBudgetMargin
FROM FactTable
GROUP BY ProductID
HAVING AVG(BudgetMargin) > 100;
GO

-- Task 13
SELECT SUM(Sales) AS TotalSales
FROM FactTable
WHERE Date = '2010-01-01';
GO

-- Task 14
SELECT Date, ProductID, AVG(TotalExpenses) AS AverageTotalExpenses
FROM FactTable
GROUP BY Date, ProductID;
GO

-- Task 15
SELECT f.Date, f.ProductID, p.ProductType, p.Product, f.Sales, f.Profit, l.State, f.AreaCode
FROM FactTable f
INNER JOIN ProductTable p ON f.ProductID = p.ProductID
INNER JOIN LocationTable l ON f.AreaCode = l.AreaCode;
GO

-- Task 16
SELECT ProductID, SUM(Sales) AS TotalSales, DENSE_RANK() OVER (ORDER BY SUM(Sales) DESC) AS SalesRank
FROM FactTable
GROUP BY ProductID;
GO

-- Task 17
SELECT l.State, SUM(f.Profit) AS TotalProfit, SUM(f.Sales) AS TotalSales
FROM FactTable f
INNER JOIN LocationTable l ON f.AreaCode = l.AreaCode
GROUP BY l.State;
GO

-- Task 18
SELECT l.State, p.Product, SUM(f.Profit) AS TotalProfit, SUM(f.Sales) AS TotalSales
FROM FactTable f
INNER JOIN ProductTable p ON f.ProductID = p.ProductID
INNER JOIN LocationTable l ON f.AreaCode = l.AreaCode
GROUP BY l.State, p.Product;
GO

-- Task 19
SELECT Date, ProductID, Sales, Sales * 1.05 AS IncreasedSales
FROM FactTable;
GO

-- Task 20
SELECT TOP 1 p.ProductID, p.ProductType, SUM(f.Profit) AS TotalProfit
FROM FactTable f
INNER JOIN ProductTable p ON f.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductType
ORDER BY TotalProfit DESC;
GO

-- Task 21
CREATE PROCEDURE GetProductsByType
    @ProductType VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM ProductTable
    WHERE ProductType = @ProductType;
END;
GO

-- Task 22
SELECT Date, ProductID, TotalExpenses,
    CASE WHEN TotalExpenses < 60 THEN 'Profit' ELSE 'Loss' END AS Status
FROM FactTable;
GO

-- Task 23
SELECT DATEPART(YEAR, Date) AS Year, DATEPART(WEEK, Date) AS Week, ProductID, SUM(Sales) AS TotalSales
FROM FactTable
GROUP BY ROLLUP(DATEPART(YEAR, Date), DATEPART(WEEK, Date), ProductID);
GO

-- Task 24
SELECT AreaCode FROM LocationTable
UNION
SELECT AreaCode FROM FactTable;
GO
SELECT AreaCode FROM LocationTable
INTERSECT
SELECT AreaCode FROM FactTable;
GO

-- Task 25
CREATE FUNCTION GetProductsByTypeFunc (@ProductType VARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM ProductTable
    WHERE ProductType = @ProductType
);
GO

-- Task 26
BEGIN TRANSACTION;
UPDATE ProductTable
SET ProductType = 'Tea'
WHERE ProductID = 1 AND ProductType = 'Coffee';
ROLLBACK TRANSACTION;
GO

-- Task 27
SELECT Date, ProductID, Sales
FROM FactTable
WHERE TotalExpenses BETWEEN 100 AND 200;
GO

-- Task 28
DELETE FROM FactTable
WHERE ProductID IN (SELECT ProductID FROM ProductTable WHERE Type = 'Regular');
DELETE FROM ProductTable
WHERE Type = 'Regular';
GO

-- Task 29
SELECT Product,
    CASE WHEN LEN(Product) >= 5 THEN ASCII(SUBSTRING(Product, 5, 1)) ELSE NULL END AS FifthCharacterASCII
FROM ProductTable;
GO