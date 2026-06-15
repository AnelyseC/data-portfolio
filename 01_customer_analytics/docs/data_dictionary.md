# Data Dictionary

## Overview

This document describes the analytical data model used in the Customer Analytics project.

The Gold layer follows a dimensional modeling approach composed of one fact table and multiple dimensions to support customer analytics, acquisition, retention, segmentation, and lifetime value analyses.

---

# Fact Tables

## fct_sales

### Description

Central fact table containing all delivered sales transactions.

### Grain

**One row per sold item.**

### Columns

| Column             | Data Type | Description                                          |
| ------------------ | --------- | ---------------------------------------------------- |
| order_id           | VARCHAR   | Unique order identifier                              |
| order_item_id      | INTEGER   | Item sequence within the order                       |
| customer_id        | VARCHAR   | Customer identifier used in the source system        |
| customer_unique_id | VARCHAR   | Unique customer identifier across multiple purchases |
| product_id         | VARCHAR   | Product identifier                                   |
| seller_id          | VARCHAR   | Seller identifier                                    |
| purchase_date      | TIMESTAMP | Order purchase timestamp                             |
| order_status       | VARCHAR   | Current order status                                 |
| price              | DOUBLE    | Product sale value                                   |
| freight_value      | DOUBLE    | Shipping cost associated with the item               |

### Business Rules

* Only delivered orders are included.
* Each record represents a single sold item.
* Revenue is calculated using the `price` column.
* Freight cost is stored separately in `freight_value`.

---

# Dimension Tables

## dim_customer

### Description

Customer dimension containing customer and geographic attributes.

### Grain

**One row per customer.**

### Columns

| Column                   | Data Type | Description                |
| ------------------------ | --------- | -------------------------- |
| customer_id              | VARCHAR   | Customer identifier        |
| customer_unique_id       | VARCHAR   | Unique customer identifier |
| customer_zip_code_prefix | INTEGER   | Customer ZIP code prefix   |
| customer_city            | VARCHAR   | Customer city              |
| customer_state           | VARCHAR   | Customer state             |

---

## dim_product

### Description

Product dimension containing product characteristics and category information.

### Grain

**One row per product.**

### Columns

| Column                     | Data Type | Description                   |
| -------------------------- | --------- | ----------------------------- |
| product_id                 | VARCHAR   | Product identifier            |
| product_category_name      | VARCHAR   | Product category              |
| product_name_lenght        | INTEGER   | Product name length           |
| product_description_lenght | INTEGER   | Product description length    |
| product_photos_qty         | INTEGER   | Number of product photos      |
| product_weight_g           | DOUBLE    | Product weight in grams       |
| product_length_cm          | DOUBLE    | Product length in centimeters |
| product_height_cm          | DOUBLE    | Product height in centimeters |
| product_width_cm           | DOUBLE    | Product width in centimeters  |

---

## dim_date

### Description

Date dimension used for time-based analysis.

### Grain

**One row per calendar day.**

### Columns

| Column     | Data Type | Description                         |
| ---------- | --------- | ----------------------------------- |
| date_day   | DATE      | Calendar date                       |
| year       | INTEGER   | Calendar year                       |
| month      | INTEGER   | Calendar month                      |
| day        | INTEGER   | Day of month                        |
| year_month | VARCHAR   | Year-month representation (YYYY-MM) |

---

# Entity Relationship Model

```text
dim_customer
      │
      │
      ▼
   fct_sales
      ▲
      │
      │
dim_product

      ▲
      │
      │
  dim_date
```

---

# Data Lineage

```text
Raw Layer
    │
    ▼
Silver Layer
    ├── silver_customers
    ├── silver_orders
    ├── silver_order_items
    ├── silver_products
    └── silver_payments
    │
    ▼
Gold Layer
    ├── fct_sales
    ├── dim_customer
    ├── dim_product
    └── dim_date
```
