# Analysis Plan

## Objective

This document defines the analytical plan for the Olist Customer Analytics project.

The goal is to transform the Gold analytical layer into business insights about customer behavior, value, retention, satisfaction, and delivery experience.

---

## Main Analytical Themes

The analysis is organized into five main themes:

1. Customer base overview
2. Customer value and revenue concentration
3. RFM segmentation
4. Delivery experience and satisfaction
5. Business recommendations

---

## 1. Customer Base Overview

This section analyzes the overall customer base.

Main questions:

- How many unique customers are in the dataset?
- How many total orders were placed?
- What is the average number of orders per customer?
- What share of customers purchased only once?
- What is the geographic distribution of customers?

Main metrics:

- Total customers
- Total orders
- Average orders per customer
- One-time buyer share
- Repeat customer share
- Customers by state

Expected insight:

The Olist customer base is expected to have a large share of one-time buyers, which makes retention and reactivation important analytical topics.

---

## 2. Customer Value and Revenue Concentration

This section analyzes how revenue is distributed across customers.

Main questions:

- What is the distribution of customer spending?
- Which customer segments generate the most revenue?
- What is the average order value by customer segment?
- Are there high-value customers who only purchased once?

Main metrics:

- Total revenue
- Average order value
- Total spent by customer
- Revenue by segment
- Average monetary value by segment
- High-value one-time buyer share

Expected insight:

A small share of customers may represent a meaningful share of revenue, and some one-time buyers may still be commercially relevant due to high order value.

---

## 3. RFM Segmentation

This section analyzes customer segments based on Recency, Frequency, and Monetary value.

Main questions:

- How many customers are in each RFM segment?
- Which segments are most valuable?
- Which segments are more recent?
- Which segments are at risk or lost?
- How relevant are one-time buyers in the segmentation?

Main metrics:

- Customers by segment
- Revenue by segment
- Average recency by segment
- Average frequency by segment
- Average monetary value by segment

Expected insight:

Because the dataset has a high number of one-time buyers, the segmentation should not only focus on loyalty. It should also highlight high-value one-time buyers and customers with potential for reactivation.

---

## 4. Delivery Experience and Satisfaction

This section analyzes the relationship between delivery performance and customer satisfaction.

Main questions:

- What percentage of orders were delivered late?
- What is the average review score for delayed and on-time orders?
- Which customer segments had worse delivery experience?
- Which states had higher delivery delays?
- Is delivery delay associated with lower review scores?

Main metrics:

- Delay rate
- Average delivery days
- Average delay days
- Average review score
- Review score by delay flag
- Delay rate by customer segment
- Review score by customer segment

Expected insight:

Delayed deliveries are expected to be associated with lower customer satisfaction, making delivery performance a relevant operational lever.

---

## 5. Business Recommendations

This section converts analytical findings into business recommendations.

Potential recommendation areas:

- Retention campaigns for recent high-value customers.
- Reactivation campaigns for at-risk and lost customers.
- Special treatment for high-value one-time buyers.
- Delivery improvement initiatives in states or categories with high delay rates.
- Customer experience actions for segments with low review scores.

Expected output:

The final analysis should provide practical recommendations that could be used by an e-commerce marketplace to improve customer retention, satisfaction, and revenue generation.

---

## Expected Outputs

The analysis should produce:

- Customer segment distribution.
- Revenue by customer segment.
- One-time versus repeat customer analysis.
- Delivery delay and review score analysis.
- Segment-level satisfaction metrics.
- Business recommendations.
- Visuals to be reused in the final README and Power BI dashboard.