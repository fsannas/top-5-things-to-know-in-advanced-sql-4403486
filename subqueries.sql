select * from dbo.OnlineRetailSales$
where [Order Total] >= 
	(Select AVG([Order Total]) from dbo.OnlineRetailSales$) 

select *, (Select AVG([Order Total]) from dbo.OnlineRetailSales$) as average_total 
from dbo.OnlineRetailSales$
where [Order Total] >= 
	(Select AVG([Order Total]) from dbo.OnlineRetailSales$) 

Select [Speaker Name], [Session Name], [Start Date], [End Date], [Room Name]
from dbo.SessionInfo$
where [Speaker Name] in 
(select Name from dbo.SpeakerInfo$ where Organization='Two Trees Olive Oil')

Select [Speaker Name], ses.[Session Name], [Start Date], [End Date], [Room Name]
from dbo.SessionInfo$ ses
inner join (select Name, [Session Name] from dbo.SpeakerInfo$ where Organization='Two Trees Olive Oil') as speak
on ses.[Session Name] = speak.[Session Name]

/*
write a query that outputs the first and last name , state, email address, and phone number of conference attendees who 
come from states that have no online retail sales
*/

SELECT [First name],[Last name],[State],Email,[Phone Number]
FROM dbo.ConventionAttendees$ as C
WHERE NOT EXISTS 
	(SELECT DISTINCT CustState FROM dbo.OnlineRetailSales$ as O WHERE C.state = O.CustState)

	/*
	challenge
	*/
select top(5)* from dbo.Inventory$

SELECT ProdCategory, ProdNumber, ProdName, [In Stock],(SELECT AVG([In Stock]) FROM dbo.Inventory$) as InStockAverage
FROM dbo.Inventory$
WHERE [In Stock] < 
		(SELECT AVG([In Stock]) FROM dbo.Inventory$)
					

