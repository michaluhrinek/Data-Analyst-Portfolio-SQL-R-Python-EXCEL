--SELECT TOP 1*
--FROM dbo.nehody$
--WHERE rok=2021;

--SELECT ALL DATA FROM THE DATASET
select TOP 22*
from dbo.nehody$
where rok <2022;

SELECT alkohol_lathko zraneny
from dbo.nehody$;




--rename columns
exec sp_rename 'dbo.nehody$.alkohol _cyklista', 'alc_cyklista', 'COLUMN';
EXEC sp_rename 'dbo.nehody$.alkohol_lahko_zraneny', 'alco_lahko_zraneny', 'COLUMN';

--dbo.nehody$.[alkohol_lahko_zraneny] = ISNULL(dbo.nehody$.[alkohol_lahko_zraneny],0); have to look at this one


-- Type of columns, display the type of columns
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'nehody$' AND TABLE_SCHEMA = 'dbo';




select *
from dbo.nehody$;


----Latest data to work with/sorting data
SELECT TOP 1 nehody$.[alkohol _cyklista], nehody$.alkohol_auto, nehody$.alkohol_motorka, nehody$.alkohol_chodec, nehody$.nehody_alkohol_celkovo, nehody$.[zomreli alcohol celkom], nehody$.Zraska_s_divokou_zverou,nehody$.[ accidents involving pedestrians crossing], nehody$.[deaths caused by accidents involving pedestrians crossing], nehody$.[zomrel sofer], nehody$.Zomreli_koli_vodicovi_s_alkoholom
FROM dbo.nehody$
WHERE rok=2021;

--ALTER TABLE dbo.nehody$
--ADD average_month DECIMAL(10, 2);

-- Add new columns for average per month and per day for each existing column
ALTER TABLE dbo.nehody$
ADD average_month_alkohol_cyklista DECIMAL(10, 2),
    average_day_alkohol_cyklista DECIMAL(10, 2),
    average_month_alkohol_auto DECIMAL(10, 2),
    average_day_alkohol_auto DECIMAL(10, 2),
    average_month_alkohol_motorka DECIMAL(10, 2),
    average_day_alkohol_motorka DECIMAL(10, 2),
    average_month_alkohol_chodec DECIMAL(10, 2),
    average_day_alkohol_chodec DECIMAL(10, 2),
ALTER TABLE dbo.nehody$
ADD	
	average_month_alkohol_nehody DECIMAL(10,2),
	average_day_alkohol_nehody DECIMAL (10,2),
	average_month_alkohol_zomreli DECIMAL (10,2),
	average_day_alkohol_zomreli DECIMAL (10,2);

-- Update the new columns with the average per month and per day for each existing column
UPDATE dbo.nehody$
SET average_month_alkohol_cyklista = (nehody$.[alkohol _cyklista ]) / 12,
    average_day_alkohol_cyklista = (nehody$.[alkohol _cyklista]) / 365,
	average_month_alkohol_auto = (nehody$.[alkohol_auto]) /12,
	average_day_alkohol_auto =  (nehody$.[alkohol_auto]) /365,
	average_month_alkohol_motorka = (nehody$.[alkohol_motorka]) / 12,
	average_day_alkohol_motorka =  (nehody$.[alkohol_motorka]) / 365,
	average_month_alkohol_chodec = (nehody$.[alkohol_chodec]) /12,
	average_day_alkohol_chodec =  (nehody$.[alkohol_chodec]) /365;

UPDATE dbo.nehody$
SET average_month_alkohol_nehody = CAST(REPLACE(nehody$.[nehody_alkohol_celkovo], ' ', '') AS DECIMAL) / 12,
	average_day_alkohol_nehody =  CAST(REPLACE(nehody$.[nehody_alkohol_celkovo], ' ', '') AS DECIMAL) / 365,
	average_month_alkohol_zomreli = nehody$.Zomreli_koli_vodicovi_s_alkoholom /12 ,
	average_day_alkohol_zomreli = nehody$.Zomreli_koli_vodicovi_s_alkoholom /365 ;

	--create column
ALTER TABLE dbo.nehody$
ADD
	 avg_mesiac_zraska_s_divokou_zverou DECIMAL(10,2);
	 --update column
UPDATE dbo.nehody$
SET avg_mesiac_zraska_s_divokou_zverou = CAST(REPLACE(nehody$.Zraska_s_divokou_zverou, ',', '.') AS DECIMAL(10,2)) / 12;

ALTER TABLE dbo.nehody$
ADD 
	avg_day_zraska_s_divokou_zverou DECIMAL(10,2);

UPDATE dbo.nehody$
SET  
	avg_day_zraska_s_divokou_zverou = CAST(REPLACE(nehody$.Zraska_s_divokou_zverou, ',', '.') AS DECIMAL(10,2)) / 365;


--DELETE COLUMN avg_zraska_s_divokou_zverou;
ALTER TABLE dbo.nehody$
DROP COLUMN avg_zraska_s_divokou_zverou;


--list of columns
--rok, dopravne nehody celkom, zomreli-dopravne nehody, nehody sposobene autom, 
Zomreli po zraske s autom, 
auto+sofer nehody,
zomreli alcohol celkom,
zomreli spolujazdec, 
zomrel sofer, nehody_alkohol_celkovo, alkohol_motorka,
--alkohol-chodec
,alkohol_cyklista,
alkohol_auto,
Zomreli_koli_vodicovi_s_alkoholom,
alkohol_tazko_zraneny,
alkohol_lahko_zraneny,
Zraska_s_divokou_zverou, deaths caused by accidents involving pedestrians crossing, 
accidents involving pedestrians crossing, 
average_month, average_month_alkohol_cyklista, 
--average_day_alkohol_cyklista, 
average_month_alkohol_auto,average_day_alkohol_auto
,average_month_alkohol_motorka,average_day_alkohol_motorka,
--average_month_alkohol_chodec,average_day_alkohol_chodec, 
average_month_alkohol_nehody,average_day_alkohol_nehody, average_month_alkohol_zomreli, 
--average_day_alkohol_zomreli, avg_mesiac_zraska_s_divokou_zverou,avg_day_zraska_s_divokou_zverou


--Replacing NULL with 0 in entire table
UPDATE dbo.nehody$
SET 
    dbo.nehody$.[dopravne nehody celkom]  = ISNULL(dbo.nehody$.[dopravne nehody celkom], 0),
	dbo.nehody$.[nehody sposobene autom ] = ISNULL(dbo.nehody$.[nehody sposobene autom ],0),
	dbo.nehody$.[Zomreli po zraske s autom ] = ISNULL(dbo.nehody$.[Zomreli po zraske s autom ],0),
	dbo.nehody$.[auto+sofer nehody] = ISNULL(dbo.nehody$.[auto+sofer nehody],0),
	dbo.nehody$.[zomreli alcohol celkom] = ISNULL(dbo.nehody$.[zomreli alcohol celkom],0),
	dbo.nehody$.[zomreli spolujazdec] = ISNULL(dbo.nehody$.[zomreli spolujazdec],0),
	dbo.nehody$.[zomrel sofer] = ISNULL(dbo.nehody$.[zomrel sofer],0),
	dbo.nehody$.[alkohol_motorka] = ISNULL(dbo.nehody$.[alkohol_motorka],0),
	dbo.nehody$.[alkohol_chodec] = ISNULL(dbo.nehody$.[alkohol_chodec],0),
	dbo.nehody$.[alkohol_auto] = ISNULL(dbo.nehody$.[alkohol_auto],0),
	dbo.nehody$.[alkohol_tazko_zraneny] = ISNULL(dbo.nehody$.[alkohol_tazko_zraneny],0),
	
	dbo.nehody$.[Zraska_s_divokou_zverou] = ISNULL(dbo.nehody$.[Zraska_s_divokou_zverou],0),
	dbo.nehody$.[deaths caused by accidents involving pedestrians crossing] = ISNULL(dbo.nehody$.[deaths caused by accidents involving pedestrians crossing],0),
	dbo.nehody$.[accidents involving pedestrians crossing] = ISNULL(dbo.nehody$.[accidents involving pedestrians crossing],0)--have to look at this one 
	dbo.nehody$.[average_month] = ISNULL(dbo.nehody$.[average_month],0);

UPDATE dbo.nehody$
SET 
	dbo.nehody$.[average_month] = ISNULL(dbo.nehody$.[average_month],0),
	dbo.nehody$.[average_month_alkohol_cyklista] = ISNULL(dbo.nehody$.[average_month_alkohol_cyklista],0),
	dbo.nehody$.[average_day_alkohol_cyklista] = ISNULL(dbo.nehody$.[average_day_alkohol_cyklista],0),
	dbo.nehody$.[average_month_alkohol_auto] = ISNULL(dbo.nehody$.[average_month_alkohol_auto],0),
	dbo.nehody$.[average_day_alkohol_auto] = ISNULL(dbo.nehody$.[average_day_alkohol_auto],0);

--Getting rid of NULL values and replacing them with 0, another way.
Update dbo.nehody$ set  average_month_alkohol_chodec = 0 where average_month_alkohol_chodec is NULL;
Update dbo.nehody$ set	average_day_alkohol_chodec = 0 where average_day_alkohol_chodec is NULL;
Update dbo.nehody$ set  average_month_alkohol_nehody = 0 where average_month_alkohol_nehody is NULL;
Update dbo.nehody$ set  average_month_alkohol_zomreli = 0 where average_month_alkohol_zomreli is NULL;
Update dbo.nehody$ set  average_day_alkohol_zomreli = 0 where average_day_alkohol_zomreli is NULL;
Update dbo.nehody$ set  avg_mesiac_zraska_s_divokou_zverou = 0 where avg_mesiac_zraska_s_divokou_zverou is NULL;
Update dbo.nehody$ set  avg_day_zraska_s_divokou_zverou = 0 where avg_day_zraska_s_divokou_zverou is NULL;
Update dbo.nehody$ set  average_month_alkohol_motorka = 0 where average_month_alkohol_motorka is NULL;
Update dbo.nehody$ set  average_day_alkohol_motorka = 0 where average_day_alkohol_motorka is NULL;
Update dbo.nehody$ set  alc_cyklista = 0 where alc_cyklista is NULL;



