-- Customer Segments
-- This query analyzes customer distribution, revenue contribution, and average customer behavior by segment.

WITH segments AS (
    SELECT
        customer_unique_id,
        customer_segment,
        recency_days,
        frequency,
        monetary_value
    FROM read_parquet('../data/gold/customer_segments.parquet')
),

features AS (
    SELECT
        customer_unique_id,
        total_orders,
        total_spent,
        avg_order_value,
        avg_review_score,
        delay_rate
    FROM read_parquet('../data/gold/customer_features.parquet')
)

SELECT
    segments.customer_segment,
    COUNT(DISTINCT segments.customer_unique_id) AS customers,
    SUM(features.total_spent) AS total_revenue,
    AVG(features.total_spent) AS avg_customer_value,
    AVG(features.avg_order_value) AS avg_order_value,
    AVG(segments.recency_days) AS avg_recency_days,
    AVG(segments.frequency) AS avg_frequency,
    AVG(segments.monetary_value) AS avg_monetary_value,
    AVG(features.avg_review_score) AS avg_review_score,
    AVG(features.delay_rate) AS avg_delay_rate,
    COUNT(DISTINCT segments.customer_unique_id) * 1.0
        / SUM(COUNT(DISTINCT segments.customer_unique_id)) OVER () AS customer_share,
    SUM(features.total_spent) * 1.0
        / SUM(SUM(features.total_spent)) OVER () AS revenue_share
FROM segments
LEFT JOIN features
    ON segments.customer_unique_id = features.customer_unique_id
GROUP BY
    segments.customer_segment
ORDER BY
    total_revenue DESC