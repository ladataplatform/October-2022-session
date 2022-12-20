-- USER-DEFINED DATA TYPES
use tempdb;
GO
CREATE TYPE date_only FROM DATETIME NOT NULL;
GO
-- uh, Rob, it's not actually a date only


-- DEFAULT OBJECTS
CREATE DEFAULT today AS DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0);
GO
EXEC sp_bindefault 'today', 'date_only';
GO
-- RULE OBJECTS
CREATE RULE date_only AS (
	DATEPART(HOUR,@value)=0 AND 
	DATEPART(MINUTE,@value)=0 AND 
	DATEPART(SECOND,@value)=0 AND 
	DATEPART(ms,@value)=0);
GO
EXEC sp_bindrule 'date_only', 'date_only';

-- Combo!
CREATE TABLE DateTest2(
	UDT date_only);

CREATE TABLE DateTest3(
	DateRule DATETIME NOT NULL);

-- rules can be bound to columns too
EXEC sp_bindrule 'date_only', 'dbo.DateTest3.DateRule';

INSERT DateTest2 VALUES('2/2/2012');	--succeeds
INSERT DateTest3 VALUES('3/3/2013');	--succeeds

INSERT DateTest2 VALUES(GETDATE());		--fails
INSERT DateTest3 VALUES(GETDATE());		--fails

SELECT * FROM DateTest2;
SELECT * FROM DateTest3;

-- clean up
DROP TABLE DateTest2,DateTest3;
DROP TYPE date_only;
DROP DEFAULT today;
DROP RULE date_only;
GO


-- ISO SQL DOMAIN (PostGres example)
/*
CREATE DOMAIN us_postal_code AS varchar(10)
NOT NULL
DEFAULT('00000')
CHECK(
   VALUE ~ '^\\d{5}$'
OR VALUE ~ '^\\d{5}-\\d{4}$'
);
*/
use tempdb;
GO
CREATE TYPE Zip FROM varchar(10) NOT NULL;
GO
CREATE RULE ZipWith4 AS (
@value LIKE '[0-9][0-9][0-9][0-9][0-9]'
OR @value LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
);
GO
EXEC sp_bindrule 'ZipWith4','Zip';

CREATE TABLE #zip(zip Zip);
INSERT #zip(zip) VALUES('10019')
INSERT #zip(zip) VALUES('10019-9999')

INSERT #zip(zip) VALUES('10019-')
INSERT #zip(zip) VALUES('10019-99999')

INSERT #zip(zip) VALUES('Yay!!')

SELECT * FROM #zip;
-- clean up
DROP TABLE #zip
DROP TYPE Zip;
DROP RULE ZipWith4;


-- Well, rules and defaults are deprecated
-- And have been for >10 years
-- Besides, those are all data integrity

-- :)

use tempdb;
GO
CREATE TYPE ID FROM int NOT NULL;
GO
CREATE RULE One_Rule_To_Rule_Them_All AS 
@value IS NOT NULL
AND ORIGINAL_LOGIN()<>'sa' 
AND OBJECT_NAME(@@PROCID) IS NOT NULL
AND @@CURSOR_ROWS=0
AND @@OPTIONS & 16=16
--AND IS_SRVROLEMEMBER('sysadmin')=0
--AND DATEPART(hour,GETDATE()) BETWEEN 0 AND 1
GO
exec sp_bindrule 'One_Rule_To_Rule_Them_All', 'ID';
GO
CREATE TABLE Test(ID ID DEFAULT(0));
GO
CREATE PROCEDURE TestInsert @val int AS SET NOCOUNT ON; INSERT Test(ID) VALUES(@val);
GO
-- ad-hoc SQL fails
INSERT Test DEFAULT VALUES;

EXEC TestInsert 1;

select * from Test;

-- active cursor fails
DECLARE c cursor for SELECT 1;
open c;
EXEC TestInsert -1;
close c; deallocate c;

-- ANSI_PADDING
SET ANSI_PADDING OFF;
EXEC TestInsert -2;
GO

SET ANSI_PADDING ON;
EXEC TestInsert -3;
GO

select * from Test;

-- clean up
DROP PROCEDURE TestInsert; DROP TABLE Test; 
DROP TYPE ID; DROP RULE One_Rule_To_Rule_Them_All;

