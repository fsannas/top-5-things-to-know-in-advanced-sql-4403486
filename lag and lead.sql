use Red30Tech;

SELECT [Start Date],[End Date],[Session Name],
LAG([Session Name],1) over(order by [Start Date] asc) as PreviousSession,
LAG([Start Date],1) over(order by [Start Date] asc) as PreviousSessionStart,
LEAd([Session Name],1) over(order by [Start Date] asc) as NextSession,
Lead([Start Date],1) over(order by [Start Date] asc) as NextSessionStart
FROM dbo.SessionInfo$
where [Room Name] = 'Room 102'
Order by [Start Date] ASC;

WITH ORDER_BY_DAYS as (
	SELECT OrderDate, SUM(Quantity) as daily_quantity
	From dbo.OnlineRetailSales$
	Where ProdCategory = 'Drones'
	Group by OrderDate
	)
SELECT OrderDate, daily_quantity,
LAG(daily_quantity,1,0) over(order by OrderDate asc) as previous_order,
LAG(daily_quantity,2,0) over(order by OrderDate asc) as second_previous_order,
LAG(daily_quantity,3,0) over(order by OrderDate asc) as third_previous_order,
LAG(daily_quantity,4,0) over(order by OrderDate asc) as forth_previous_order,
LAG(daily_quantity,5,0) over(order by OrderDate asc) as fifth_previous_order
From ORDER_BY_DAYS;
