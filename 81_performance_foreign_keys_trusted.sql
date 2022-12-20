-- Foreign Keys trusted vs. untrusted
-- set SHOWPLAN ON, set STATISTICS IO ON
USE AdventureWorks;

SET STATISTICS IO ON;
-- check execution plan and IO messages
select d.* 
from Sales.SalesOrderHeader h
inner join Sales.SalesOrderDetail d on h.SalesOrderID=d.SalesOrderID;

-- disable foreign key constraints (actually, disable all just for simplicity of demo)
alter table Sales.SalesOrderDetail nocheck constraint all;

-- check execution plan again
select d.* 
from Sales.SalesOrderHeader h
inner join Sales.SalesOrderDetail d on h.SalesOrderID=d.SalesOrderID;

-- enable constraints the easy way
alter table Sales.SalesOrderDetail check constraint all;

-- check execution plan again, hmmmm
select d.* 
from Sales.SalesOrderHeader h
inner join Sales.SalesOrderDetail d on h.SalesOrderID=d.SalesOrderID;

-- enable constraints the CORRECT way
alter table Sales.SalesOrderDetail with check check constraint all;

-- yay!
select d.* 
from Sales.SalesOrderHeader h
inner join Sales.SalesOrderDetail d on h.SalesOrderID=d.SalesOrderID
-- where h.SalesOrderID=43659  -- check your WHERE clauses, compare to JOIN criteria
-- where d.SalesOrderID=43659  -- check your WHERE clauses, compare to JOIN criteria
