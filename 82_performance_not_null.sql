-- NOT NULL
CREATE TABLE #check(some_column int NOT NULL);
INSERT #check(some_column) VALUES(1),(2),(3);

-- set SHOWPLAN ON
SELECT * FROM #check WHERE some_column IS NULL
SELECT * FROM #check WHERE some_column IS NOT NULL

SELECT * FROM #check WHERE some_column=NULL
SELECT * FROM #check WHERE some_column<>NULL

DECLARE @var int=NULL
SELECT * FROM #check WHERE some_column=@var
SELECT * FROM #check WHERE some_column<>@var


-- NULL logic is, well, not very logical
SELECT * FROM Sales.SalesOrderDetail d WHERE d.SalesOrderID IS NULL;

BEGIN TRAN

ALTER TABLE Sales.SalesOrderDetail DISABLE TRIGGER ALL;
DELETE Sales.SalesOrderDetail WHERE SalesOrderID=43659;
ALTER TABLE Sales.SalesOrderDetail ENABLE TRIGGER ALL;

-- SalesOrderID is not nullable in either table
SELECT h.* 
FROM Sales.SalesOrderHeader h
LEFT JOIN Sales.SalesOrderDetail d ON d.SalesOrderID=h.SalesOrderID
WHERE d.SalesOrderID IS NULL;

-- EXISTS/NOT EXISTS is more logical
SELECT h.* 
FROM Sales.SalesOrderHeader h
WHERE NOT EXISTS(	SELECT 1 
					FROM Sales.SalesOrderDetail d 
					WHERE d.SalesOrderID=h.SalesOrderID)

ROLLBACK TRAN

