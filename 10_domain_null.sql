-- NULLs and try to avoid them wherever possible
CREATE TABLE #null(first_name varchar(10) null, last_name varchar(20) null)

INSERT #null(first_name,last_name)
VALUES(null,null),('Rob','Volk'),('Rob',null),(null,'Volk');

select * from #null;

select * from #null where first_name='Rob';
select * from #null where last_name='Volk';

-- since null is unknown, I can't compare them equally or unequally
select * from #null where first_name<>'Rob';
select * from #null where last_name<>'Volk';

select * from #null where first_name IS NULL;
select * from #null where last_name IS NULL;

DROP TABLE #null;
