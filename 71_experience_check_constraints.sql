-- Some things that are often forgotten/left out

CREATE TABLE #Birth(Date_of_Birth DATETIME);
-- do you really care the actual millisecond of birth?
-- why store 8 bytes when 3 are beyond sufficient

-- SalesCommissionPct smallmoney
-- percentages are a special case of storing decimals
-- smallmoney/money are tempting, but not ideal
-- type also allows negatives

