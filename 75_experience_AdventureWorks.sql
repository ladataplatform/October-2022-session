-- Some things that could be better in AdventureWorks

use AdventureWorks;

select object_name(parent_object_id),name,definition 
from sys.check_constraints order by 1,2

/*
SalesOrderDetail	CK_SalesOrderDetail_OrderQty	([OrderQty]>(0))
SalesOrderDetail	CK_SalesOrderDetail_UnitPrice	([UnitPrice]>=(0.00))
SalesOrderDetail	CK_SalesOrderDetail_UnitPriceDiscount	([UnitPriceDiscount]>=(0.00))
*/
-- Discount could be greater than sales price, therefore we pay people to take bikes
-- OrderQty is smallint, 32K of certain items is not reasonable/feasible

/*
SpecialOffer	CK_SpecialOffer_MaxQty	([MaxQty]>=(0))
SpecialOffer	CK_SpecialOffer_MinQty	([MinQty]>=(0))
*/
-- MinQty could be greater than MaxQty

/*
Employee	CK_Employee_BirthDate	([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate()))
Employee	CK_Employee_HireDate	([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate()))
*/
-- they could have 90+ year old employees
-- someone could be hired before they were born

/*
SalesPerson	CK_SalesPerson_CommissionPct	([CommissionPct]>=(0.00))
*/
-- smallmoney can allow for ludicrous commission values
-- percentages are decimals, and would probably be the better data type for this
