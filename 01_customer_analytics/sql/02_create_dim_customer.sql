CREATE OR REPLACE TABLE dim_customer AS

SELECT DISTINCT

    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state

FROM silver_customers;