SELECT * 
FROM customer_data.customer_address;

--new items into column using insert
INSERT INTO customer_data.customer_address
  (customer_id, address, city, state,zipcode,country)
VALUES (2645, '333 SQL ROAD','Jackson','MI',49202,'US')

--update query
UPDATE customer_data.customer_address
SET address = '123 new adress'
where customer_id=2645

--checking an update
SELECT address 
FROM customer_data.customer_address
where customer_id=2645;

--new chapter-duplicates
select
DISTINCT customer_id
from `customer_data.customer_address`;

select
LENGTH(country) AS letters_in_country
from `customer_data.customer_address`;

--checking for lenght item specificaly 
select
  country
from `customer_data.customer_address`
where LENGTH(country) >2

--REMOVE DUPLICATES AND SHOW CUSTOMER_ID WITH COUNTRY LEN 2 AND ='US'
select
  DISTINCT customer_id
from `customer_data.customer_address`
where 
SUBSTR(country,1,2)= 'US'


--TRIM, TO FIND IF WE NEED TO USE TRIM FUNCTION, WE NEED TO SEE IF COLUMN IS COUNTING MORE LETTER THEN THERE IS, LIKE HERE
--WE CAN SEE 2 LETTERS BUT ITS SHOWING MORE THEN 2 LETTERS, SO IT MUST COUNT EMPTY SPACES ALSO SO WE USE TRIM
select
    state
from `customer_data.customer_address`
where 
  LENGTH(state) >2

--LETS USE TRIM
select
    DISTINCT customer_id
from `customer_data.customer_address`

where 
  TRIM(state)='OH'

--NEW DATABASE, TABLE AS WELL
--USING CAST FOR CONVERTING COLUMN FORMAT INTO WHAT WE NEED
--USING CAST FOR CONVERTING COLUMN FORMAT INTO WHAT WE NEED
SELECT 
  CAST(purchase_price AS FLOAT64)
from customer_data.customer_purchase

ORDER BY
   CAST(purchase_price AS FLOAT64) DESC

-- DATE  HOW MANY PURCHASES IN THIS TIMEFRAME?
SELECT  
  date,
  purchase_price
from customer_data.customer_purchase
where
  date BETWEEN '2020-12-01' AND '2020-12-31'

--using cast to convert date into date_only so we can see only date, not time as well
SELECT  
  CAST(date AS date)AS date_only,
  purchase_price
from customer_data.customer_purchase
where
  date BETWEEN '2020-12-01' AND '2020-12-31' 


--selecting special columns and putting together strings of 2columns
SELECT  
  CONCAT(product_code, product_color) AS new_product_code
from customer_data.customer_purchase

where
   product = 'couch'


--coalesce  -- all products
SELECT  
  COALESCE(product,product_code) AS product_info
from customer_data.customer_purchase
