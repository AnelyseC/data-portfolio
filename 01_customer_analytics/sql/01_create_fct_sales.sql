CREATE OR REPLACE TABLE fct_sales AS

SELECT

    oi.order_id,
    oi.order_item_id,

    c.customer_id,
    c.customer_unique_id,

    oi.product_id,
    oi.seller_id,

    o.purchase_date,

    o.order_status,

    oi.price,
    oi.freight_value

FROM silver_order_items oi

INNER JOIN silver_orders o
    ON oi.order_id = o.order_id

INNER JOIN silver_customers c
    ON o.customer_id = c.customer_id

WHERE o.order_status = 'delivered';