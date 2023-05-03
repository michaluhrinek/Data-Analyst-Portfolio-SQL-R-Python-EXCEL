--SORTING DATA

-- select all unique items in desc.order
SELECT 
DISTINCT customer_id,product,product_code, product_color, product_price
FROM  customer_data.customer_purchase
ORDER BY product_price DESC

--delete everything where column has null in it

DELETE FROM customer_data.customer_purchase
WHERE product IS NULL;

--see entire dataset
select *
from customer_data.customer_purchase

--look for specific value
select *
from  customer_data.customer_purchase
where product_color ='grey'

--replace specific value
UPDATE customer_data.customer_purchase
SET transaction_id = '69223689'
WHERE transaction_id = '0275040';

--
SELECT TRIM(product) AS trimmed_column
FROM customer_data.customer_purchase

--how many letters has product_code?
SELECT LENGTH(product_code) AS code_length
FROM customer_data.customer_purchase

--any datasets empty? 
SELECT COUNT(*) AS total_rows
FROM customer_data.customer_purchase
WHERE date IS NULL AND 
      transaction_id IS NULL AND 
      product IS NULL AND 
      product_code IS NULL AND 
      product_color IS NULL AND 
      product_price IS NULL AND 
      purchase_price IS NULL AND 
      purchase_size IS NULL AND 
      revenue IS NULL;

--CONVERTING DATE BECAUSE IT ORIGINALLY SHOWS DATE AND TIME TOO, WE WANT ONLY DATE
SELECT CAST(date AS DATE) AS date_only
FROM customer_data.customer_purchase

--create new column date_only
ALTER TABLE customer_data.customer_purchase ADD COLUMN date_only DATE;
--update date_only value with date value
UPDATE customer_data.customer_purchase
SET date_only = DATE(date)
WHERE date < '2023-01-01';

--delete original date value
ALTER TABLE customer_data.customer_purchase DROP COLUMN date;
--check entire table
select*
from customer_data.customer_purchase

