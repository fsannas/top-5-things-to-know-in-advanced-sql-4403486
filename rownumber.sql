use Red30Tech

SELECT CustName, count(distinct OrderNum)
FROM dbo.OnlineRetailSales$
Group by CustName



Select OrderNum,OrderDate,CustName, ProdName,Quantity,
ROW_NUMBER() over(partition by custname order by OrderDate desc) as row_num
FROM dbo.OnlineRetailSales$

---to get only the most recent one you have to get row_num is 1. 
--- you cannot do it in a where clause because the window function runs after the where clause and 
--- when you run the where clause the row_num will not exist yet
WITH ROW_NUMBERS as (
	Select OrderNum,OrderDate,CustName, ProdName,Quantity,
	---by using order date desc you get the most recent one first
	ROW_NUMBER() over(partition by custname order by OrderDate desc) as row_num
	FROM dbo.OnlineRetailSales$
	)
Select * from ROW_NUMBERS WHERE row_num = 1

WITH Totals as (
	SELECT OrderNum,OrderDate,CustName,ProdCategory,ProdName,[Order Total],
	ROW_NUMBER() over(partition by ProdCategory order by [Order Total] desc) as row_num
	FROM dbo.OnlineRetailSales$
	Where CustName = 'Boehm Inc.'
)

Select * from Totals Where row_num in (1,2,3)

