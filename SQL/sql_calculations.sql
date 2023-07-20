--SQL Calculations
SELECT * FROM `project-id-386504.avocado_data.avocado_prices` LIMIT 1000

SELECT
  Date,
  Region,
  Total_bags,
  Small_Bags,
  (Small_Bags / Total_Bags)*100 AS Small_bags_percent
FROM avocado_data.avocado_prices
WHERE Total_Bags <>0;
--
SELECT * FROM `project-id-386504.avocado_data.avocado_prices` LIMIT 1000

SELECT 
  Date,
  Region,
  Small_bags,
  Large_Bags,
  XLarge_Bags,
  Total_Bags,
  Small_bags + Large_Bags + XLarge_Bags AS Total_bags_calc

FROM avocado_data.avocado_prices;
--
SELECT * FROM `bigquery-public-data.new_york_citibike.citibike_trips` LIMIT 1000

SELECT 
  EXTRACT(YEAR FROM starttime) AS year,
  COUNT(*) AS number_of_rides
FROM 
bigquery-public-data.new_york_citibike.citibike_trips
GROUP BY 
  year 
ORDER BY
  year ASC

--
SELECT * FROM `bigquery-public-data.new_york_subway.subway_ridership_2013_present` WHERE DATE(_PARTITIONTIME) = "2023-05-16" LIMIT 1000

--which station has most change in year 2014? & what number of change of rides there is?
SELECT
    station_name,
    ridership_2013,
    ridership_2014,
    ridership_2014 - ridership_2013 AS change_2014_raw
FROM bigquery-public-data.new_york_subway.subway_ridership_2013_present
ORDER BY
   change_2014_raw DESC
--

-- Average rides in station "Atlantic Av - Barclays Ctr" in 2016-2018
SELECT 
    station_name,
    ridership_2016,
    ridership_2018,
    (ridership_2016 + ridership_2016) / 2 AS AVERAGE_in2years
FROM bigquery-public-data.new_york_subway.subway_ridership_2013_present
WHERE station_name ="Atlantic Av - Barclays Ctr"

--
SELECT * FROM `project-id-386504.sales.sales_info` LIMIT 1000

--select first 10sales data from the sales table
SELECT *
FROM
  sales.sales_info

LIMIT 10;
-- First data about sales were? Last data about sales where?
SELECT
  MIN(Date) AS min_date,
  MAX(Date) AS max_date
FROM
sales.sales_info;
--
--the total quantity sold for each ProductId grouped by the month and year it was sold: 
SELECT
  EXTRACT(YEAR FROM date) AS Year,
  EXTRACT(MONTH FROM date) AS Month,
  ProductId,
  ROUND(MAX(UnitPrice),2) AS UnitPrice,
  SUM(Quantity) AS UnitsSold
FROM
  sales.sales_info
GROUP BY
  Year,
  Month,
  ProductId
ORDER BY
  Year,
  Month,
  ProductId;

--
SELECT * FROM `bigquery-public-data.new_york_citibike.citibike_trips` LIMIT 1000

WITH  trips_over_1_hr AS (
  SELECT *
  FROM 
    bigquery-public-data.new_york_citibike.citibike_trips
  WHERE 
    tripduration >= 60
  ) 
## Count how many trips are 60+min long?

SELECT    
  count(*) AS count_number_of_trips
FROM 





