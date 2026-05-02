---CHECKING THE ENTIRE TABLE
SELECT * 
FROM `workspace`.`default`.`car_sales_data`;


---CONVERTING TEXT-BASED PRICES TO NUMERIC FORMAT
SELECT
   CAST(sellingprice AS DECIMAL(10,2)) AS numeric_selling_price,
    CAST(mmr AS DECIMAL(10,2)) AS numeric_mmr
FROM `workspace`.`default`.`car_sales_data`;


---CHECKING UNIQUE CAR BRAND
SELECT DISTINCT make
FROM `workspace`.`default`.`car_sales_data`;

--------------------------------------------
---There are 97 unique car brands
---------------------------------------------

---CHECKING FOR UNIQUE CAR MODELS
SELECT DISTINCT model
FROM `workspace`.`default`.`car_sales_data`;

----------------------------------------------
---There are 974 unique car models
----------------------------------------------

---CHECKING FOR UNIQUE CAR TRIM
SELECT DISTINCT trim
FROM `workspace`.`default`.`car_sales_data`;

----------------------------------------------
---There are 1000+ unique car trims
----------------------------------------------

---CHECKING FOR UNIQUE CAR BODY PART
SELECT DISTINCT body
FROM `workspace`.`default`.`car_sales_data`;

---------------------------------------------
---There are 87 different body parts
---------------------------------------------

---CHECKING FOR UNIQUE TRANSMISSION TYPE
SELECT DISTINCT IFNULL(transmission, 'Unknown') AS transmission_type
FROM `workspace`.`default`.`car_sales_data`;

---------------------------------------------------------------------
---We have 2 known transmission types and 1 unknown transmission type
--------------------------------------------------------------------

---CHECKING FOR UNIQUE CAR VINS
SELECT DISTINCT IFNULL(vin, 'Not provided') as car_vin
FROM `workspace`.`default`.`car_sales_data`;


---CHECKING FOR DIFFERENT CAR COLOURS
SELECT DISTINCT
  IFNULL(
    CASE 
        WHEN color IS NULL THEN NULL
        WHEN TRIM(color) = '' THEN NULL
        WHEN TRIM(color) = '--' THEN NULL
        ELSE color
    END,'colorless')AS cleaned_color
FROM `workspace`.`default`.`car_sales_data`;


---CHECKING THE UNIQUE CAR INTERIOR
SELECT DISTINCT
  IFNULL(
    CASE 
        WHEN interior IS NULL THEN NULL
        WHEN TRIM(interior) = '' THEN NULL
        WHEN TRIM(interior) = '-' THEN NULL
        ELSE interior
    END,'interiorless')AS cleaned_interior
FROM `workspace`.`default`.`car_sales_data`;


---CHECKING DIFFERENT STATES
SELECT DISTINCT state
FROM `workspace`.`default`.`car_sales_data`;

--------------------------------------------------
---There are 38 states in which the cars are sold
--------------------------------------------------

---CHECKING FOR DIFFERENT CAR SELLERS
SELECT DISTINCT seller
FROM `workspace`.`default`.`car_sales_data`;

--------------------------------------------------
---There are 14 261 car sellers
--------------------------------------------------

---CREATING NEW COLUMN CALLED TOTAL REVENUE( selling price* unit sold)
SELECT year,
       make,
       model,
       trim,
       body,
       transmission,
       vin,
       state,
       condition,
       odometer,
       color
       interior,
       seller,
       mmr,
       sellingprice,
       saledate,
       SUM(sellingprice*condition) AS total_revenue
FROM `workspace`.`default`.`car_sales_data`
GROUP BY year,
       make,
       model,
       trim,
       body,
       transmission,
       vin,
       state,
       condition,
       odometer,
       color,
       interior,
       seller,
       mmr,
       sellingprice,
       saledate;


---TURNING TOTAL REVENUE TO NUMERIC FORMAT
SELECT year,
       make,
       model,
       trim,
       body,
       transmission,
       vin,
       state,
       condition,
       odometer,
       color,
       interior,
       seller,
       CAST(mmr AS DECIMAL(10,2)) AS numeric_mmr,
       CAST(sellingprice AS DECIMAL(10,2)) AS numeric_selling_price,
       saledate,
       CAST(total_revenue AS DECIMAL(10,2)) AS numeric_total_revenue
FROM `workspace`.`default`.cleaned_car_sales
GROUP BY year,
       make,
       model,
       trim,
       body,
       transmission,
       vin,
       state,
       condition,
       odometer,
       color,
       interior,
       seller,
       numeric_mmr,
       numeric_selling_price,
       saledate,
       numeric_total_revenue;


  ---CALCULATING TOTAL REVENUE
  -------------------------------------------------------------------------------
  ---Revenue was calcualted using selling price as each row represent a purchase
  --------------------------------------------------------------------------------
SELECT
    CAST(SUM(sellingprice) AS DECIMAL(18,2)) AS total_revenue
FROM `workspace`.`default`.`car_sales_data`;


---CALCULATING THE PROFIT MARGIN
SELECT
    ((sellingprice- mmr) / sellingprice) * 100 AS profit_margin
FROM `workspace`.`default`.`cleaned_car_sales`;


---COMPARING THE PROFIT MARGIN WITH THE CONDITION OF THE CAR
SELECT
    IFNULL(condition, 0) AS condition,
    ((sellingprice- mmr) / sellingprice) * 100 AS profit_margin
FROM `workspace`.`default`.`cleaned_car_sales`
GROUP BY condition, profit_margin
ORDER BY profit_margin DESC;


---CALCULATING THE AVERAGE PROFIT MARGIN
SELECT
    AVG(((sellingprice- mmr) / sellingprice) * 100) AS avg_profit_margin
FROM `workspace`.`default`.`cleaned_car_sales`;


---COMBINING THE AVERAGE PROFIT MARGIN WITH THE CONDITION OF THE CAR
SELECT
    IFNULL(condition, 0) AS condition,
    AVG((sellingprice- mmr) / sellingprice) AS avg_profit_margin
FROM `workspace`.`default`.`cleaned_car_sales`
GROUP BY condition
ORDER BY avg_profit_margin DESC;



---CALCULATING THE TOTAL UNITS SOLD
SELECT
    COUNT(*) AS total_units_sold
FROM `workspace`.`default`.`cleaned_car_sales`;


---CALCULATING REVENUE PER CAR MAKE
SELECT
    make,
    SUM(sellingprice) AS revenue_per_make
FROM `workspace`.`default`.`cleaned_car_sales`
GROUP BY make
ORDER BY revenue_per_make DESC;


---ADDING CASE STATEMENTS TO PROFIT MARGIN
SELECT
    IFNULL(condition, 0) AS condition,
    CASE 
        WHEN ((sellingprice- mmr) / sellingprice) * 100 < 0 THEN 'Low margin' 
       WHEN ((sellingprice- mmr) / sellingprice) * 100 BETWEEN 0 AND 10 THEN 'Medium margin' 
        ELSE 'High margin'
         END AS profit_margin
FROM `workspace`.`default`.`cleaned_car_sales`
GROUP BY condition, profit_margin
ORDER BY profit_margin DESC;



---TIME CASE STATEMENTS
SELECT saledate,
       TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss') AS sale_timestamp,
       TO_DATE(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss')) AS sale_date,
       DATE_FORMAT(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'EEEE') AS day_name,
       DATE_FORMAT(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'HH:mm:ss') AS sale_time
       FROM `workspace`.`default`.`car_sales_data`;

---DELETING NULLS THAT HAS 0 ROW COUNT
DELETE FROM `workspace`.`default`.`car_sales_data`
WHERE DATE_FORMAT(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'EEEE') IS NULL
OR CONCAT(YEAR(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss')),'-Q',QUARTER(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss'))) IS NULL;

---COMBINING THE WHOLE TABLE AND ADDING NEW COLUMNS
SELECT 
    year,
    ---Clean categorical columns
    IFNULL(transmission, 'Unknown') AS transmission_type,
    state,
    IFNULL(condition, 0) AS condition,
    COALESCE(odometer,AVG(odometer) OVER ()) AS odometer_filled,
    COALESCE(NULLIF(REGEXP_REPLACE(TRIM(body), '-', ''), ''), 'Unknown') AS body,
    COALESCE(NULLIF(REGEXP_REPLACE(TRIM(make), '-', ''), ''), 'Unknown') AS make,
    COALESCE(NULLIF(REGEXP_REPLACE(TRIM(model), '-', ''), ''), 'Unknown') AS model,
    COALESCE(NULLIF(REGEXP_REPLACE(TRIM(trim), '-', ''), ''), 'Unknown') AS trim, 
    COALESCE(NULLIF(REGEXP_REPLACE(TRIM(color), '[\\-—–]', ''), ''), 'colorless') AS cleaned_color,
     COALESCE(NULLIF(REGEXP_REPLACE(TRIM(interior), '[\\-—–]', ''), ''), 'Unknown' ) AS cleaned_interior,
    ---Numeric conversions
    CAST(mmr AS DECIMAL(10,2)) AS numeric_mmr,
    CAST(sellingprice AS DECIMAL(10,2)) AS numeric_selling_price,
    ---Revenue
    CAST(sellingprice AS DECIMAL(10,2)) AS numeric_total_revenue,
    ---Profit margin
    ((sellingprice - mmr) / sellingprice) * 100 AS profit_margin,
    ---Profit category
    CASE 
        WHEN ((sellingprice - mmr) / sellingprice) * 100 < 0 THEN 'Low margin' 
        WHEN ((sellingprice - mmr) / sellingprice) * 100 BETWEEN 0 AND 10 THEN 'Medium margin' 
        ELSE 'High margin'
    END AS profit_category,
    ---Time conversion
    TO_DATE(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss')) AS sale_date,
    DATE_FORMAT(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'EEEE') AS day_name,
    DATE_FORMAT(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss'), 'HH:mm:ss') AS sale_time,
    ---Time periods
CONCAT(YEAR(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss')),'-Q',QUARTER(TO_TIMESTAMP(SUBSTRING(saledate, 5), 'MMM dd yyyy HH:mm:ss'))) AS sale_quarter
FROM `workspace`.`default`.`car_sales_data`
ORDER BY profit_margin DESC;
