# Data Model

## Overview

This project follows a layered data architecture:

```text
Raw Layer → Silver Layer → Gold Layer → Analytics & Dashboard
```

The goal is to transform raw transactional data from the Olist Brazilian E-commerce dataset into clean, structured, business-ready tables for customer analytics.

---

## Source Dataset

The raw dataset contains multiple CSV files related to the Olist marketplace.

| File                                    | Description                                       |
| --------------------------------------- | ------------------------------------------------- |
| `olist_customers_dataset.csv`           | Customer location and customer identifiers        |
| `olist_orders_dataset.csv`              | Order status and order timestamps                 |
| `olist_order_items_dataset.csv`         | Order items, products, sellers, price and freight |
| `olist_order_payments_dataset.csv`      | Payment method, installments and payment value    |
| `olist_order_reviews_dataset.csv`       | Customer review score and review timestamps       |
| `olist_products_dataset.csv`            | Product attributes and product category           |
| `olist_sellers_dataset.csv`             | Seller location                                   |
| `olist_geolocation_dataset.csv`         | Zip-code-level geolocation data                   |
| `product_category_name_translation.csv` | English translation for product category names    |

---

## Key Modeling Decision

For customer analytics, the main customer identifier is `customer_unique_id`.

In this dataset:

* `customer_id` identifies a customer instance related to a specific order.
* `customer_unique_id` identifies the anonymized unique customer.

Therefore, customer-level analysis, retention analysis, and RFM segmentation should be based on `customer_unique_id`.

---

## Data Layers

### Raw Layer

The Raw layer stores the original CSV files downloaded from Kaggle.

No transformations are applied in this layer.

Examples:

```text
data/raw/olist_orders_dataset.csv
data/raw/olist_customers_dataset.csv
data/raw/olist_order_items_dataset.csv
```

---

### Silver Layer

The Silver layer contains cleaned and standardized tables.

Typical transformations:

* Standardizing column names.
* Converting date columns to datetime.
* Removing duplicated records.
* Handling missing values.
* Enriching product data with category translations.
* Creating basic operational fields such as delivery time and delivery delay.

Expected Silver tables:

| Table                  | Grain                                         |
| ---------------------- | --------------------------------------------- |
| `customers`            | One row per `customer_id`                     |
| `orders`               | One row per `order_id`                        |
| `order_items`          | One row per `order_id` + `order_item_id`      |
| `payments`             | One row per `order_id` + `payment_sequential` |
| `reviews`              | One row per `review_id`                       |
| `products`             | One row per `product_id`                      |
| `sellers`              | One row per `seller_id`                       |
| `category_translation` | One row per product category                  |
| `geolocation`          | One row per zip code prefix / location record |

---

### Gold Layer

The Gold layer contains analytical tables used for customer analytics and dashboarding.

Expected Gold tables:

| Table               | Grain                            | Purpose                                                    |
| ------------------- | -------------------------------- | ---------------------------------------------------------- |
| `fact_orders`       | One row per order                | Order-level revenue, delivery, payment, and review metrics |
| `fact_order_items`  | One row per order item           | Product and seller-level sales analysis                    |
| `dim_customers`     | One row per `customer_unique_id` | Customer profile and location                              |
| `dim_products`      | One row per `product_id`         | Product attributes and category                            |
| `dim_sellers`       | One row per `seller_id`          | Seller location                                            |
| `customer_features` | One row per `customer_unique_id` | Customer-level behavioral metrics                          |
| `customer_rfm`      | One row per `customer_unique_id` | Recency, frequency, and monetary values                    |
| `customer_segments` | One row per `customer_unique_id` | Final customer segmentation                                |

---

## Conceptual Entity Relationship

Source relationship:

```text
customers
   |
   | customer_id
   v
orders
   |
   | order_id
   v
order_items -------- products
   |
   | seller_id
   v
sellers

orders
   |
   | order_id
   v
payments

orders
   |
   | order_id
   v
reviews
```

---

## Gold Data Model

The analytical model is designed around customer behavior.

```text
dim_customers
      |
      | customer_unique_id
      v
fact_orders
      |
      | order_id
      v
fact_order_items ---- dim_products
      |
      | seller_id
      v
dim_sellers

fact_orders
      |
      | customer_unique_id
      v
customer_features
      |
      v
customer_rfm
      |
      v
customer_segments
```

---

## Main Analytical Tables

### `fact_orders`

Grain: one row per `order_id`.

Main fields:

| Field                           | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| `order_id`                      | Unique order identifier                         |
| `customer_id`                   | Customer identifier at order level              |
| `customer_unique_id`            | Unique anonymized customer identifier           |
| `order_status`                  | Order status                                    |
| `order_purchase_timestamp`      | Purchase timestamp                              |
| `order_delivered_customer_date` | Actual customer delivery date                   |
| `order_estimated_delivery_date` | Estimated customer delivery date                |
| `order_value`                   | Total product value in the order                |
| `freight_value`                 | Total freight value in the order                |
| `items_count`                   | Number of items in the order                    |
| `payment_value`                 | Total payment value                             |
| `main_payment_type`             | Main payment method used                        |
| `review_score`                  | Customer review score                           |
| `delivery_days`                 | Days between purchase and delivery              |
| `delivery_delay_days`           | Days between estimated and actual delivery      |
| `is_delayed`                    | Flag indicating if the order was delivered late |

---

### `fact_order_items`

Grain: one row per `order_id` + `order_item_id`.

Main fields:

| Field                 | Description                    |
| --------------------- | ------------------------------ |
| `order_id`            | Unique order identifier        |
| `order_item_id`       | Item sequence within the order |
| `product_id`          | Product identifier             |
| `seller_id`           | Seller identifier              |
| `shipping_limit_date` | Seller shipping deadline       |
| `price`               | Item price                     |
| `freight_value`       | Item freight value             |

---

### `dim_customers`

Grain: one row per `customer_unique_id`.

Main fields:

| Field                      | Description                             |
| -------------------------- | --------------------------------------- |
| `customer_unique_id`       | Unique anonymized customer identifier   |
| `customer_city`            | Customer city                           |
| `customer_state`           | Customer state                          |
| `customer_zip_code_prefix` | Customer zip code prefix                |
| `first_order_date`         | First purchase date                     |
| `last_order_date`          | Most recent purchase date               |
| `total_orders`             | Number of orders placed by the customer |

---

### `dim_products`

Grain: one row per `product_id`.

Main fields:

| Field                           | Description                            |
| ------------------------------- | -------------------------------------- |
| `product_id`                    | Product identifier                     |
| `product_category_name`         | Original product category name         |
| `product_category_name_english` | Product category translated to English |
| `product_weight_g`              | Product weight in grams                |
| `product_length_cm`             | Product length in centimeters          |
| `product_height_cm`             | Product height in centimeters          |
| `product_width_cm`              | Product width in centimeters           |

---

### `dim_sellers`

Grain: one row per `seller_id`.

Main fields:

| Field                    | Description            |
| ------------------------ | ---------------------- |
| `seller_id`              | Seller identifier      |
| `seller_city`            | Seller city            |
| `seller_state`           | Seller state           |
| `seller_zip_code_prefix` | Seller zip code prefix |

---

### `customer_features`

Grain: one row per `customer_unique_id`.

Main fields:

| Field                    | Description                             |
| ------------------------ | --------------------------------------- |
| `customer_unique_id`     | Unique anonymized customer identifier   |
| `customer_city`          | Customer city                           |
| `customer_state`         | Customer state                          |
| `first_order_date`       | First purchase date                     |
| `last_order_date`        | Most recent purchase date               |
| `total_orders`           | Total number of orders                  |
| `total_spent`            | Total customer spending                 |
| `avg_order_value`        | Average order value                     |
| `total_items`            | Total number of purchased items         |
| `avg_review_score`       | Average customer review score           |
| `avg_delivery_days`      | Average delivery time in days           |
| `delayed_orders`         | Number of delayed orders                |
| `delay_rate`             | Share of delayed orders                 |
| `preferred_payment_type` | Most used payment type                  |
| `categories_bought`      | Number of distinct categories purchased |
| `favorite_category`      | Most purchased category                 |

---

### `customer_rfm`

Grain: one row per `customer_unique_id`.

Main fields:

| Field                | Description                                 |
| -------------------- | ------------------------------------------- |
| `customer_unique_id` | Unique anonymized customer identifier       |
| `recency_days`       | Days since the customer's most recent order |
| `frequency`          | Number of orders placed by the customer     |
| `monetary_value`     | Total amount spent by the customer          |
| `r_score`            | Recency score                               |
| `f_score`            | Frequency score                             |
| `m_score`            | Monetary score                              |
| `rfm_score`          | Combined RFM score                          |

---

### `customer_segments`

Grain: one row per `customer_unique_id`.

Main fields:

| Field                | Description                           |
| -------------------- | ------------------------------------- |
| `customer_unique_id` | Unique anonymized customer identifier |
| `recency_days`       | Days since most recent purchase       |
| `frequency`          | Number of orders                      |
| `monetary_value`     | Total amount spent                    |
| `rfm_score`          | Combined RFM score                    |
| `customer_segment`   | Final customer segment                |

---

## Important Dataset Consideration

The Olist dataset has a large share of one-time buyers. Because of this, customer segmentation should not rely only on repeat purchase behavior.

The analysis should also identify:

* High-value one-time buyers.
* Customers with poor delivery experience.
* Customers with high satisfaction.
* Customers with potential for reactivation.
* Operational factors related to low review scores.

---

## Analytical Use Cases Enabled by the Model

### Customer Segmentation

This model supports customer segmentation based on recency, frequency, and monetary value.

It can be used to identify:

* High-value customers.
* Inactive customers.
* At-risk customers.
* Recent customers.
* High-value one-time buyers.

### Retention Analysis

This model supports retention and repeat purchase analysis.

It can be used to measure:

* Repeat purchase rate.
* One-time buyer share.
* Purchase frequency.
* Revenue contribution by customer type.
* Time between purchases.

### Delivery Experience Analysis

This model supports delivery performance analysis.

It can be used to measure:

* Average delivery time.
* Delivery delay rate.
* Delivery performance by customer state.
* Differences between estimated and actual delivery dates.

### Satisfaction Analysis

This model supports customer satisfaction analysis.

It can be used to analyze:

* Review score distribution.
* Review scores for delayed versus on-time orders.
* Product categories associated with lower satisfaction.
* Operational drivers of poor customer experience.

### Product and Category Analysis

This model supports product and category behavior analysis.

It can be used to identify:

* Top product categories by revenue.
* Top product categories by order volume.
* Average order value by category.
* Category-level satisfaction.
* Category-level delivery performance.

---

## Next Steps

1. Create the Silver layer using Python.
2. Save cleaned tables as Parquet files.
3. Create Gold analytical tables.
4. Build RFM segmentation.
5. Create the Power BI dashboard.
