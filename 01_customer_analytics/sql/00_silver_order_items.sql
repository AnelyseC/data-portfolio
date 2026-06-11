CREATE OR REPLACE TABLE silver_order_items AS

SELECT

    order_id,
    order_item_id,
    product_id,
    seller_id,

    CAST(price AS DOUBLE) AS price,
    CAST(freight_value AS DOUBLE) AS freight_value

FROM order_items;