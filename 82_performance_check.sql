-- CHECK

-- set SHOWPLAN ON
create table #(a int not null check(a between 7 and 10));
insert # values(7),(8),(99);
--ALTER TABLE # WITH CHECK CHECK CONSTRAINT ALL

select * from # where a<1
select * from # where a<10
select * from # where a=10
select * from # where a>10
select * from # where a=11

select * from # where a<7
select * from # where a>9
GO

-- check out AdventureWorks
USE AdventureWorks;

select name,definition,is_disabled,is_not_trusted 
from sys.check_constraints
where parent_object_id=object_id('HumanResources.Employee');

-- (upper([Gender])='F' OR upper([Gender])='M')
SELECT BusinessEntityID FROM HumanResources.Employee WHERE Gender='Z';
SELECT BusinessEntityID FROM HumanResources.Employee WHERE Gender IN('Z');
SELECT BusinessEntityID FROM HumanResources.Employee WHERE UPPER(Gender)='Z';
SELECT BusinessEntityID FROM HumanResources.Employee WHERE UPPER(Gender) IN('Z');

-- ([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate()))
SELECT BusinessEntityID FROM HumanResources.Employee WHERE HireDate<'1995-01-01' --and HireDate>dateadd(day,(1),getdate());
SELECT BusinessEntityID FROM HumanResources.Employee WHERE HireDate>dateadd(day,(1),getdate());

--SELECT SalesOrderID FROM Sales.SalesOrderHeader WHERE [DueDate]<[OrderDate];
