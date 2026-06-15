-- Customer Overview
-- This query summarizes the customer base, order volume, revenue, and repeat purchase behavior.

WITH customer_base AS (
    SELECT
        customer_unique_id,
        total_orders,
        total_spent,
        avg_order_value
    FROM read_parquet('../data/gold/customer_features.parquet')
),

order_base AS (
    SELECT
        order_id,
        customer_unique_id,
        total_order_value,
        review_score,
        is_delayed
    FROM read_parquet('../data/gold/fact_orders.parquet')
)

SELECT
    COUNT(DISTINCT customer_base.customer_unique_id) AS total_customers,
    COUNT(DISTINCT order_base.order_id) AS total_orders,
    SUM(order_base.total_order_value) AS total_revenue,
    AVG(order_base.total_order_value) AS avg_order_value,
    AVG(customer_base.total_orders) AS avg_orders_per_customer,
    SUM(CASE WHEN customer_base.total_orders = 1 THEN 1 ELSE 0 END) AS one_time_buyers,
    SUM(CASE WHEN customer_base.total_orders > 1 THEN 1 ELSE 0 END) AS repeat_buyers,
    SUM(CASE WHEN customer_base.total_orders = 1 THEN 1 ELSE 0 END) * 1.0
        / COUNT(DISTINCT customer_base.customer_unique_id) AS one_time_buyer_share,
    SUM(CASE WHEN customer_base.total_orders > 1 THEN 1 ELSE 0 END) * 1.0
        / COUNT(DISTINCT customer_base.customer_unique_id) AS repeat_buyer_share,
    AVG(order_base.review_score) AS avg_review_score,
    AVG(order_base.is_delayed) AS delayed_order_rate
FROM customer_base
LEFT JOIN order_base
    ON customer_base.customer_unique_id = order_base.customer_unique_id