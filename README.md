
# **Phase 1 of Zomato Analytics Project: Zomato SQL Analysis**

![Zomato-Logo](https://github.com/user-attachments/assets/4b1fbcb4-476e-4f1c-a118-aa0515b290d4)

This Phase involved analyzing Zomato's database using SQL Server Management Studio to uncover key operational insights and customer trends. The project included data preparation, cleaning, exploratory analysis, and querying to generate actionable business insights.

Zomato is a leading global online food delivery and restaurant discovery platform, connecting customers with restaurants, delivery services, and food providers. As a Data Analyst, I applied advanced SQL techniques to analyze customer behavior, operational efficiency, and restaurant performance, helping Zomato make data-driven decisions.

 I collaborated with cross-functional teams to uncover trends in customer engagement, optimize delivery operations, and support business growth strategies. My analysis provided valuable insights into customer retention, restaurant performance, and market demand, contributing to the company's overall goals of improving user experience and operational efficiency.

## **Objective of the SQL Analysis**

This SQL analysis aims to extract meaningful insights from Zomato’s order and customer data to drive strategic decision-making. The key objectives include:

- **Understanding Customer Behavior** – Identifying top customers, order frequency, churn patterns, and spending trends to improve retention strategies.
- **Optimizing Restaurant Performance** – Ranking restaurants by revenue, repeat customers, and order fulfillment rates to enhance partnerships and service quality.
- **Improving Delivery Efficiency** – Analyzing rider performance, delivery times, and unfulfilled orders to streamline logistics and enhance customer satisfaction.
- **Identifying Market Trends** – Detecting seasonal order variations, peak time slots, and popular dishes to optimize marketing and operational planning.
- **Enhancing Financial Insights** – Evaluating average order values, restaurant profitability, and rider earnings to support data-driven financial planning.
- This analysis empowers Zomato to make informed business decisions, enhance customer experience, and drive overall operational efficiency.

### **Business Problem to solve in this Project**
- What are the top 5 most frequently ordered dishes by customer "Arjun Mehta" in the last 2 years?
- What are the most popular time slots for orders based on 2-hour intervals?
- What is the average order value (AOV) for customers who placed more than 750 orders?
- Who are the high-value customers who have spent more than 100K on orders?
- How many orders have not been delivered (unfulfilled orders)?
- How are restaurants ranked in terms of revenue from the last year?
- What is the most popular dish in each city?
- Who are the customers who placed orders in 2023 but not in 2024 (churn analysis)?
- What is the comparison of cancellation rates for restaurants between 2023 and 2024?
- What is the average delivery time for each rider?
- What is the monthly growth ratio of restaurants based on the number of delivered orders?
- How can we segment customers into "Gold" or "Silver" based on their total spending and compare them with the average order value (AOV)?
- What are the total monthly earnings of each rider based on 8% of the delivered order amount?
- How can we classify riders based on their delivery times and count their ratings (5, 4, or 3 stars)?
- What are the peak days by order frequency for each restaurant?
- What is the distribution of orders across different payment methods (e.g., Credit Card, Cash, etc.)?
- Which restaurants have the highest number of repeat customers (orders placed more than 3 times)?
- What are the average customer ratings for dishes in the last quarter?
- How can we determine if there are any seasonal trends in order volume (e.g., more orders in summer vs. winter)?
- What is the average time between the first and last order for a customer over a year?
  
---

## **Tools Used in Phase1:**

- Microsoft SQL SERVER database management system.
- SQL SERVER MANAGEMENT STUDIO (SSMS) for database setup, management, and query execution.

---

### **Key Skills Demonstrated in Phase1**

- **Advanced SQL Querying**: Data extraction using `SELECT`, `JOIN`, and functions like `COUNT()`, `SUM()`, `AVG()`.
- **Data Aggregation & Ranking**: Grouping with `GROUP BY`, ranking with `DENSE_RANK()`, and using subqueries.
- **Joins & Data Relationships**: Applied `INNER JOIN`, `LEFT JOIN`, and handled missing values.
- **Conditional Logic & Time Analysis**: Dynamic categorization with `CASE`, and time analysis using `DATEPART()`.
- **Performance Optimization**: Efficient queries with indexing strategies for faster execution.
- **Business Intelligence & Insights**: Identified trends, churn, and evaluated performance metrics.
- **Data Visualization Readiness**: Prepared data for dashboards and reporting.
- **Statistical & Mathematical Analysis**: Calculated growth rates, averages, and other key metrics.
- **Reporting & Decision Support**: Provided data-driven business recommendations.

---

### **Key Highlights:**

- **Database Design & Optimization:** Created a relational database (`Zomato_DB`) optimized for querying and scalability.
- **Data Import & Structuring:** Imported 5 CSV files into SQL Server, creating structured tables (Orders, Customers, Deliveries, Restaurants, Riders).
- **Data Integrity & Constraints:** Applied primary and foreign keys to enforce relationships and maintain consistency.
- **Data Quality Checks:** Identified missing values and ensured data completeness.
- **Exploratory Data Analysis (EDA):** Conducted data exploration to confirm accuracy, extract insights, and analyze customer trends.

![Er Diagram After Relationships](https://github.com/user-attachments/assets/25923c7d-d619-4c6b-84bc-31b4a9a2a2c9)


The optimized database design ensures efficient querying, scalability, and reliable insights, enabling data-driven decision-making for Zomato’s operations.

# Problems I Identified as a Data Analyst

Zomato's SQL analysis aims to extract valuable business insights across **customer behavior, restaurant performance, delivery efficiency, and business growth strategies**. Below is an **overall analysis** based on the given SQL questions.

## **Customer Behavior & Retention Strategy**

### **Understanding Ordering Patterns**

- By identifying the **top 5 most frequently ordered dishes** for customers like "Arjun Mehta," Zomato can **personalize recommendations** and push targeted discounts.
- Finding the **most popular dish in each city** helps in promoting **regional bestsellers**, ensuring restaurants optimize their menus.

### **Customer Segmentation & Loyalty Programs**

- **"Gold" and "Silver" customer segmentation** based on total spending allows Zomato to offer **tier-based loyalty rewards**, which boosts retention.
- Tracking **customers who ordered in 2023 but not in 2024 (churn analysis)** helps Zomato detect and re-engage **lost customers** with special offers or feedback collection.

### **High-Value Customer Identification**

- Finding customers who have **spent more than ₹100K** allows Zomato to create **exclusive programs** for their **top spenders** (e.g., priority delivery, premium memberships).
- Calculating **Average Order Value (AOV)** for customers who placed **more than 750 orders** helps optimize **pricing strategies** and drive **higher order values**.

---

## Operational Efficiency & Delivery Optimization

### **Demand Forecasting & Delivery Performance**

- Identifying the **most popular time slots for orders (2-hour intervals)** allows Zomato to **optimize delivery staff allocation** and reduce wait times.
- **Tracking monthly restaurant growth** based on delivered orders helps Zomato decide **which restaurants to promote or assist**.

### **Delivery Speed & Rider Performance**

- Finding the **average delivery time per rider** helps in identifying **fast vs. slow-performing riders**, allowing Zomato to implement performance-based incentives.
- **Classifying riders** based on their **delivery times and ratings (5, 4, or 3 stars)** ensures **quality control and better customer satisfaction**.

### **Order Fulfillment & Cancellation Trends**

- Finding **the number of unfulfilled orders** allows Zomato to address **delivery failures** and **improve reliability**.
- Analyzing **cancellation rates between 2023 and 2024** highlights trends in **restaurant service quality** or **customer dissatisfaction**, helping in strategic intervention.

---

## **Restaurant Performance & Business Expansion**

### **Revenue-Based Restaurant Ranking**

- Ranking **restaurants by revenue from the last year** helps Zomato identify **high-performing partners** for **premium listing and marketing collaborations**.
- Tracking **repeat customers (orders placed more than 3 times)** helps in recognizing **customer loyalty to specific restaurants**.

### **Financial Insights & Monetization Opportunities**

- **Calculating total monthly earnings for riders (based on 8% of the delivered order amount)** helps Zomato assess **rider incentives and payouts**.
- Understanding the **distribution of orders across different payment methods (Credit Card, Cash, etc.)** helps in optimizing **payment processing and offers**.

---

### **Market Trends & Seasonal Analysis**

- Identifying **seasonal trends in order volume (e.g., summer vs. winter demand)** helps in **predicting demand surges** and adjusting marketing campaigns accordingly.
- Calculating the **average time between the first and last order for a customer over a year** helps in analyzing **customer lifetime value (CLV)** and retention strategies.

---

 **For Solution of the Business Problem which I Identified for Zomato’ s Team as Data Analyst**

- You can See my Solution Pdf  file : <a href ="ZOMATO SQL ANALYSIS.pdf"> Zomato SQL Queries and Solution PDF file </a>

- You can See my Solution Document file :  <a href = "ZOMATO SQL ANALYSIS.docx"> Zomato SQL Queries and Solution Document file </a>

- You can see the SQL Script which I created in this Project : <a href ="Zomato SQL Script.sql"> Zomato SQL Script </a>

## OUTCOME

The key impact of Phase1 for Zomato by solving those business problems includes:

**Improved Customer Retention and Loyalty**:

- By personalizing recommendations, offering targeted discounts, and segmenting customers into loyalty tiers, the project helps retain valuable customers and encourages repeat purchases, directly enhancing customer lifetime value (CLV).

**Optimized Operational Efficiency**:

- Demand forecasting and optimizing delivery staff allocation reduce wait times, increase delivery speed, and ensure better resource utilization. This improves customer satisfaction and operational cost-efficiency.

**Boosted Restaurant Performance**:

- By ranking restaurants based on revenue and tracking repeat customers, Zomato can promote high-performing restaurants, leading to better partnerships, increased visibility, and more marketing opportunities for top performers.

**Enhanced Rider Performance and Cost Management**:

- Identifying high-performing riders and incentivizing them based on delivery times and ratings can boost rider efficiency, reduce delivery times, and improve service quality, which benefits both Zomato and its customers.

**Data-Driven Business Expansion**:

- Financial insights, customer segmentation, and market trend analysis provide Zomato with key data to adjust marketing campaigns, predict demand surges, and optimize payment methods, driving more targeted business expansion and increasing revenue.

**Strategic Market Adaptation**:

- Analyzing seasonal trends and customer behavior over time allows Zomato to better adapt to market fluctuations, adjust its offerings, and ensure its business strategies remain competitive and responsive to changing consumer needs.
 
