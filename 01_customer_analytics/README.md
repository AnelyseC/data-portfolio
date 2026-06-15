# Customer Analytics & Analytics Engineering Project

## Overview

This project was built to demonstrate end-to-end Data Analytics and Analytics Engineering skills using the Olist Brazilian E-Commerce dataset.

The project covers the complete analytics lifecycle:

* Data ingestion
* Data cleaning and standardization
* Medallion Architecture (Raw → Silver → Gold)
* Dimensional modeling
* Customer analytics
* Business KPI development
* Dashboarding with Power BI

The final deliverable is an analytical data model capable of supporting customer acquisition, retention, segmentation, and lifetime value analyses.

---

## Business Problem

E-commerce businesses need to understand:

* How customer acquisition evolves over time
* Which customers generate the highest value
* Customer retention behavior
* Revenue growth drivers
* Customer lifetime value

This project builds a scalable analytical foundation to answer these questions.

---

## Dataset

**Source:** Olist Brazilian E-Commerce Public Dataset

The dataset contains approximately:

| Entity      | Records |
| ----------- | ------: |
| Customers   |  99,441 |
| Orders      |  99,441 |
| Order Items | 112,650 |
| Products    |  32,951 |
| Payments    | 103,886 |

Analysis period:

* Start Date: September 2016
* End Date: October 2018

---

## Technology Stack

| Category             | Tools        |
| -------------------- | ------------ |
| Programming          | Python       |
| Data Processing      | DuckDB       |
| Transformation Layer | SQL          |
| Storage Format       | Parquet      |
| Version Control      | Git & GitHub |
| Visualization        | Power BI     |
| Documentation        | Markdown     |

---

## Project Architecture

```text
Raw Layer (CSV)
        │
        ▼
Silver Layer (Cleaned Data)
        │
        ▼
Gold Layer (Analytical Model)
        │
        ▼
Business Metrics
        │
        ▼
Power BI Dashboard
```

---

## Medallion Architecture

### Raw Layer

Original source files stored without modifications.

Examples:

* Customers
* Orders
* Order Items
* Products
* Payments

---

### Silver Layer

Cleaned and standardized datasets.

Transformations include:

* Data type corrections
* Column standardization
* Basic quality checks
* Deduplication where applicable

Tables:

* silver_customers
* silver_orders
* silver_order_items
* silver_products
* silver_payments

---

### Gold Layer

Business-ready analytical model.

Tables:

#### Fact Table

* fct_sales

#### Dimension Tables

* dim_customer
* dim_product
* dim_date

---

## Data Model

### Fact Table

**fct_sales**

Grain:

> One row per sold item

Key business attributes:

* Customer
* Product
* Order
* Seller
* Revenue
* Freight Cost

---

### Dimensions

#### dim_customer

Customer attributes and geographic information.

#### dim_product

Product attributes and category information.

#### dim_date

Calendar dimension used for time-series analysis.

---

## Exploratory Data Analysis

Initial analysis revealed:

| KPI                  |             Value |
| -------------------- | ----------------: |
| Unique Customers     |            96,096 |
| Orders               |            99,441 |
| Products             |            32,951 |
| Revenue              | BRL 13.59 Million |
| Repeat Customer Rate |             3.12% |

Key finding:

Customer retention is extremely low, making retention and segmentation analyses highly relevant.

---

## Current Deliverables

### Analytics Engineering

* [x] Medallion Architecture
* [x] DuckDB Warehouse
* [x] SQL Transformation Layer
* [x] Parquet Materialization
* [x] Dimensional Modeling

### Analytics

* [x] Exploratory Data Analysis
* [ ] Customer Acquisition Analysis
* [ ] Cohort Analysis
* [ ] RFM Segmentation
* [ ] Customer Lifetime Value (LTV)
* [ ] Executive Dashboard

---

## Repository Structure

```text
01_customer_analytics/

├── data/
│   ├── raw/
│   ├── silver/
│   └── gold/
│
├── docs/
│
├── notebooks/
│   ├── 01_exploratory_analysis.ipynb
│   └── 02_data_modeling.ipynb
│
├── sql/
│   ├── Silver Layer
│   └── Gold Layer
│
├── customer_analytics.duckdb
│
└── README.md
```

---

## Next Steps

The next development phases will focus on:

1. Customer Acquisition Analysis
2. Cohort Retention Analysis
3. RFM Segmentation
4. Customer Lifetime Value Modeling
5. Power BI Executive Dashboard

---

## Author

Anelyse Cortez

Data Analytics | Analytics Engineering | Business Intelligence
