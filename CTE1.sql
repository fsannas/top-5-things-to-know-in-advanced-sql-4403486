WITh AVGTOTAL (AVG_TOTAL) AS
---THIS SELECT STATEMENT CAN BE RUN ON ITS OWN
---THIS QUERY IS IN BRACKETS
---NON       RECURSIVE CTE
	(SELECT AVG([Order Total]) AS AVG_TOTAL
	FROM [Red30Tech].dbo.OnlineRetailSales$)

SELECT *
FROM [Red30Tech].dbo.OnlineRetailSales$, AVGTOTAL
WHERE [Order Total]>=AVG_TOTAL

---RECURSIVE CTE
WITH DirectReports AS (
---ANCHOR
		SELECT EmployeeID,[First Name],[Last Name],Manager
		FROM Red30Tech.dbo.EmployeeDirectory$
		WHERE EmployeeID = 42
		UNION ALL
		SELECT e.EmployeeID,e.[First Name],e.[Last Name],e.Manager
		FROM Red30Tech.dbo.EmployeeDirectory$ as e
		INNER JOIN DirectReports AS d ON e.Manager=d.EmployeeID
---THIS LAST JOIN MAKES SURE THAT THE QUERY STOPS AT A CERTAIN TIME
		)

SELECT COUNT(*) AS DIRECTREPORTS
FROM DirectReports AS d
WHERE d.EmployeeID != 42

WITH AVERAGE_STOCK (AVG_STOCK) AS (
	SELECT AVG([In Stock]) as AVG_STOCK
	FROM Red30Tech.dbo.Inventory$
	)

SELECT ProdCategory,ProdNumber,ProdName,[In Stock]
FROM Red30Tech.dbo.Inventory$, AVERAGE_STOCK
Where [In Stock]<AVG_STOCK
