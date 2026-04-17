# Eco Essentials: End-to-End Data Warehouse & Analytics

This repository contains the **dbt (data build tool)** project for Eco Essentials, a comprehensive data engineering project designed to integrate disparate data sources into a centralized, high-performance Snowflake data warehouse. 

## Tech Stack
* **Data Warehouse:** Snowflake
* **Transformation:** dbt 
* **Business Intelligence:** Tableau Desktop
* **Orchestration & Logic:** SQL (Snowflake-specific), Jinja, dbt-utils

## Data Architecture: The Galaxy Schema
Rather than a traditional star schema, this project utilizes a **Galaxy Schema** to handle multiple business processes.

### Key Components:
* **Fact Tables:** `eco_fact_order` (Sales) and `eco_fact_email` (Marketing).
* **Conformed Dimensions:** `eco_dim_customer` and `eco_dim_date` act as the primary bridges. This allows for cross-functional analysis between marketing and sales.
* **Surrogate Keys:** Implemented using `dbt_utils.surrogate_key` to ensure data integrity across various source systems and to handle complex relationships in Tableau.

## Analytics & Business Insights
The final Tableau dashboard provides three primary layers of insight:

1.  **Marketing ROI Leaderboard:** A breakdown of total revenue generated per marketing campaign, identifying high-performing campaigns.
2.  **Sales Pulse:** A trend analysis showing monthly growth to assist in inventory planning.
3.  **Campaign Quality (AOV):** Analysis of the Average Order Value per campaign to distinguish between bargain hunters and premium customers.


## How to Run 
1.  **Install Dependencies:**
    ```bash
    dbt deps
    ```
2.  **Targeted Build:** To build and test **only** the Eco Essentials models (isolating them from other projects in this repository), use the selection flag:
    ```bash
    dbt build --select eco_essentials
    ```
