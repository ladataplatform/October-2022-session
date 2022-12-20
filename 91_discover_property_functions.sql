-- PROPERTY Functions

-- OBJECTPROPERTYEX()


-- not constraint related, but helpful
select s.name sch, t.name tbl, OBJECTPROPERTYEX(object_id,'Cardinality') row_count 
from sys.tables t 
inner join sys.schemas s on t.schema_id=s.schema_id
order by s.name, t.name
