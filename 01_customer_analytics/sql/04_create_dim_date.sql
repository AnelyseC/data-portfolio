CREATE OR REPLACE TABLE dim_date AS

SELECT DISTINCT

    CAST(purchase_date AS DATE) AS date_day,

    EXTRACT(YEAR FROM purchase_date) AS year,
    EXTRACT(MONTH FROM purchase_date) AS month,
    EXTRACT(DAY FROM purchase_date) AS day,

    STRFTIME(
        CAST(purchase_date AS DATE),
        '%Y-%m'
    ) AS year_month

FROM fct_sales;