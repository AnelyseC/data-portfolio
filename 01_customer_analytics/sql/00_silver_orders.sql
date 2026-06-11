CREATE OR REPLACE TABLE silver_orders AS

SELECT

    order_id,
    customer_id,

    CAST(order_purchase_timestamp AS TIMESTAMP) AS purchase_date,

    CAST(order_approved_at AS TIMESTAMP) AS approved_at,

    CAST(order_delivered_customer_date AS TIMESTAMP) AS delivered_date,

    order_status

FROM orders;