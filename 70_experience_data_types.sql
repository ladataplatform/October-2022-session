-- Quick example regarding zip codes

create table US_ZipCodes0(
	ZipCode int NOT NULL PRIMARY KEY);
-- Zip codes are 5 digits
-- Can't contain negative values

create table US_ZipCodes1(
	ZipCode numeric(5,0) NOT NULL PRIMARY KEY,
	CONSTRAINT CHK_ZipCode_Negative CHECK (ZipCode>0));
-- Zip codes are NOT numbers, no one does math on them
-- They are codes, consisting of digits only
-- Leading zeros are part of the code, padding with zeros may work but:
-- What happens if they move to 6 digits?  Does each 5 digit code automatically upgrade? 
-- 000000 is different from 00000 as codes (characters), but are the same as numerics
-- And as everyone will probably ask, what about Zip+4?  How to represent those as numerics?

create table US_ZipCodes2(
	ZipCode varchar(9) NOT NULL PRIMARY KEY,
	CONSTRAINT CHK_ZipCode_Valid 
		CHECK (ZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]'
			OR ZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'));
-- good for general purposes, but doesn't fully validate zip codes
