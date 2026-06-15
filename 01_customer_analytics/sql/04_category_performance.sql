-- Category Performance
-- This query analyzes product category performance by revenue, order volume, satisfaction, and delay rate.

WITH items AS (
    SELECT
        order_id,
        product_id,
        product_category_name_english,
        price,
        freight_value
    FROM read_parquet('../data/gold/fact_order_items.parquet')
),

orders AS (
    SELECT
        order_id,
        customer_unique_id,
        review_score,
        is_delayed
    FROM read_parquet('../data/gold/fact_orders.parquet')
)

SELECT
    items.product_category_name_english,
    COUNT(DISTINCT items.order_id) AS orders,
    COUNT(DISTINCT orders.customer_unique_id) AS customers,
    SUM(items.price) AS product_revenue,
    SUM(items.freight_value) AS freight_revenue,
    SUM(items.price + items.freight_value) AS total_revenue,
    AVG(items.price) AS avg_item_price,
    AVG(orders.review_score) AS avg_review_score,
    AVG(orders.is_delayed) AS delay_rate
FROM items
LEFT JOIN orders
    ON items.order_id = orders.order_id
WHERE items.product_category_name_english IS NOT NULL
GROUP BY
    items.product_category_name_english
ORDER BY
    total_revenue DESC