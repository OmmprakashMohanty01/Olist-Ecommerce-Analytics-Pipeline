# 🛒 E-Commerce Sales & Supply Chain Analytics Pipeline

## 📌 Executive Summary
This project demonstrates an end-to-end data engineering and business intelligence pipeline. Using the Olist Brazilian E-Commerce dataset, I built a relational PostgreSQL database, engineered analytical views, and developed an interactive Tableau dashboard to uncover supply chain bottlenecks and sales trends.

Dashboard Preview: A high-resolution preview is available in Dashboard_Screenshot.png, and the fully interactive dashboard can be downloaded via the Ecommerce_Sales.twbx file.

## 🛠️ Tech Stack & Tools
* **Database:** PostgreSQL
* **Data Visualization:** Tableau Desktop
* **Scripting & System Admin:** SQL, macOS Terminal (zsh), Homebrew
* **Drivers & Middleware:** JDBC, OpenJDK

## 🏗️ Architecture & Pipeline Build

### 1. Data Engineering & Modeling
* Provisioned a local **PostgreSQL** server to host raw e-commerce data (Customers, Orders, Products, Delivery routing).
* Engineered a master analytical view (`vw_ecommerce_sales`) using complex SQL `JOIN`s to flatten the snowflake schema into a highly performant, analytics-ready table.
* Calculated custom metrics directly in the database, such as `Total Order Value` and categorical `Delivery Status` (Late vs. On Time) based on timestamp differentials.

### 2. Overcoming System Connectivity Blockers
Connecting enterprise BI tools on modern macOS (Apple Silicon) often results in driver conflicts. During this build, I successfully troubleshot and bypassed native system blocks:
* **The Problem:** Tableau's native PostgreSQL connector failed to verify the `.jar` driver due to macOS Gatekeeper's quarantine protocols.
* **The Solution:** I utilized the macOS terminal to strip the extended attribute quarantine locks (`xattr -c`), deployed **OpenJDK** via Homebrew to provide the necessary Java runtime environment, and established a direct **JDBC** (Java Database Connectivity) bridge using a manual connection string (`jdbc:postgresql://localhost:5432/olist_db`).

### 3. Business Intelligence & Dashboard Design
Designed an interactive, executive-grade dashboard focusing on Z-pattern readability and UI/UX best practices:
* **High-Level KPIs:** Tracked $15.8M in Total Revenue, 98K+ Orders, and a $141 Average Order Value.
* **Time-Series Analysis:** Visualized revenue trends over time, highlighting a peak $1.2M sales month driven by Q4 holiday marketing.
* **Supply Chain Diagnostics:** Built dynamic filtering to expose bottlenecks. *Key Insight:* While the company has an overall 89% on-time delivery rate, the interactive dashboard reveals that the #1 highest-grossing product category ("Health & Beauty") experiences an above-average late delivery rate of nearly 8.8%. 

## 📂 Repository Structure
* `SQL_Scripts/` - Contains the DDL/DML scripts used to generate the database and views.
* `Ecommerce_Sales.twbx` - The packaged Tableau workbook containing the dashboard and extracted dataset.
* `Dashboard_Screenshot.png` - A static preview of the final dashboard.

## 🚀 How to Run Locally
1. Clone this repository.
2. Download the free [Tableau Reader](https://www.tableau.com/products/reader).
3. Open `Ecommerce_Sales.twbx` to interact with the fully functional dashboard.
