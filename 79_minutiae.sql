-- Data Typing lunacy
select cast('' as varbinary(16));
select cast(null as varbinary(16));
select cast(0 as varbinary(16));

select cast('' as date);
select cast('' as datetime);
select cast('' as datetime2);

select cast(null as date);
select cast(null as datetime);
select cast(null as datetime2);

select sql_variant_property(cast(null as date),'BaseType');
select sql_variant_property(cast(null as datetime),'BaseType');
select sql_variant_property(cast(null as datetime2),'BaseType');

select sql_variant_property(cast('' as date),'BaseType');
select sql_variant_property(cast('' as datetime),'BaseType');
select sql_variant_property(cast('' as datetime2),'BaseType');
