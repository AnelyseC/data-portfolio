-- Delivery and Satisfaction
-- This query compares delivery performance and customer satisfaction for delayed and on-time orders.

WITH orders AS (
    SELECT
        order_id,
        customer_unique_id,
        customer_state,
        order_status,
        delivery_days,
        estimated_delivery_days,
        delivery_delay_days,
        is_delayed,
        review_score,
        total_order_value
    FROM read_parquet('../data/gold/fact_orders.parquet')
)

SELECT
    CASE
        WHEN is_delayed = 1 THEN 'Delayed'
        ELSE 'On time'
    END AS delivery_status,
    COUNT(DISTINCT order_id) AS orders,
    AVG(delivery_days) AS avg_delivery_days,
    AVG(estimated_delivery_days) AS avg_estimated_delivery_days,
    AVG(delivery_delay_days) AS avg_delivery_delay_days,
    AVG(review_score) AS avg_review_score,
    SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END) * 1.0
        / COUNT(review_score) AS low_review_share,
    SUM(CASE WHEN review_score = 5 THEN 1 ELSE 0 END) * 1.0
        / COUNT(review_score) AS five_star_review_share,
    SUM(total_order_value) AS total_revenue
FROM orders
GROUP BY
    delivery_status
ORDER BY
    avg_review_score ASC