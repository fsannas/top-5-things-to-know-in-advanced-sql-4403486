use Red30Tech

select *,
Rank() over (Order by [Last Name]) as RANK_name,
Dense_Rank() over (Order by [Last Name]) as DenseRANK_name
From dbo.EmployeeDirectory$

--- use? identify duplicates, trends 
WITH Reg_order as (
					select *,
					Dense_Rank() over (Partition by State Order by [Registration Date] asc) as ordering
					From dbo.ConventionAttendees$
)

Select * From Reg_order
Where ordering in (1,2,3)

WITH Reg_order as (
					select *,
					Rank() over (Partition by State Order by [Registration Date] asc) as ordering
					From dbo.ConventionAttendees$
)
Select * From Reg_order
Where ordering in (1,2,3)