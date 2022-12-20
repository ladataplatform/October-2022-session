select distinct type_desc 
from sys.objects o where o.type_desc like '%constraint%'

select * from sys.check_constraints		-- CHECK_CONSTRAINT
select * from sys.default_constraints	-- DEFAULT_CONSTRAINT
select * from sys.foreign_keys			-- FOREIGN_KEY_CONSTRAINT
select * from sys.key_constraints		-- PRIMARY_KEY_CONSTRAINT, UNIQUE_CONSTRAINT

