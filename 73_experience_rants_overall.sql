-- Don't get too fancy with fudging types to fit

-- Numeric codes stored as numbers
CREATE TABLE #smallZip(zip smallmoney);
-- zip + 4 is numeric with 4 guaranteed decimals
-- problem: -0000 is not always valid +4
-- problem: smallmoney allow negative, and 6 digits

CREATE TABLE #CC(Card# bigint);
-- card number is technically numeric, but still an ID
-- problem: type allows negatives
-- problem: while no leading zeros now, could be changed
-- problem: some cards go up to 19 digits, exceeds
-- problem: need to address different digit sections

CREATE TABLE #SSN(Social_Security_Number int);
-- once again, it's an ID, not a number
-- type allows negatives, and invalid identifiers
-- however, it does fit the scope of the SSN definition
-- in any case, DO NOT STORE SSN as numeric

-- If you are adding, subtracting, multiplying, dividing, then it's a number
-- Otherwise it's a numeric code, which is a string

-- Dates
-- DATES DO NOT HAVE A FORMAT. DATES ARE VALUES ONLY.
-- DO NOT MISTAKE PRESENTATION FOR VALUE.
-- DATES HAVE THEIR OWN STRUCTURE AND LOGIC, THEY ARE A COMPOUND DATA TYPE. 
-- IT IS WAY MORE COMPLICATED. YOU ARE NOT THAT GOOD A PROGRAMMER. 
-- IF YOU'RE USING DATE TYPES IN YOUR APP, SO MUST THE DATABASE
-- USE ISO DATES YYYYMMDD OR YYYY-MM-DD WHEN PASSING TO DB IF YOU CAN'T USE PROPER TYPES
-- YYYYMMDD IS INTERPRETED CORRECTLY AS A STRING, AN INTEGER, AND DATE TYPE, AND SORTS PROPERLY
-- Expiration, birth, death, many, many dates do not require time components, use date type
-- CC expiration MMYY is incomplete, does it expire first or last day of month?
-- How do you determine leap year from MMYY?

-- Times
-- https://gist.github.com/timvisee/fcda9bbdff88d45cc9061606b4b923ca

-- Timezones
-- https://www.zainrizvi.io/blog/falsehoods-programmers-believe-about-time-zones/

-- Geometry and geography
-- built-in type support since SQL 2008, reconsider using geography
-- if you are storing latitude and longitude as 2 different numeric columns
-- SIN/COS calculations on scalar lat/long are imprecise, they are planar functions
-- on spherically mapped data
