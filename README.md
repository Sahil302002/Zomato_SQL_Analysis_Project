# Zomato_SQL_Analysis_Project

![Zomato-Logo](https://github.com/user-attachments/assets/b0da08fe-34d1-4a20-b4ac-26e94b8bc662)

This project focuses on analyzing Zomato's database to uncover operational insights and customer trends using SQL Server Management Studio. It involves data preparation, cleaning, exploratory analysis, and formulating key business queries to generate actionable insights.

The project highlights the effectiveness of relational database design paired with SQL-driven analytics. By examining Zomato's operational data, it delivers valuable insights to optimize efficiency, boost revenue, and enhance customer satisfaction.

---

## **Design and Optimization of a Relational Database for Zomato Data Analysis and Scalability**

Created a relational database optimized for querying, analysis, and scalability.

**Database Name:** `Zomato_DB`

- **Imported Data:** Successfully imported 5 CSV files into SQL Server, creating the following database tables:
    - **Orders :  10,000 records with 8 attributes**
    - **Customers : 33 records with 3 attributes**
    - **Deliveries:  9,750 records with 5 attributes**
    - **Restaurants : 72 records with 5 attributes.**
    - **Riders : 34 records with 3 attributes**

![Er Diagram Before RelationShips](https://github.com/user-attachments/assets/f9c1957a-b95c-4c18-9475-d42620cb3588)

- **Data Type Adjustments:**
    - Ensured efficient and compatible data types, e.g., `INT`, `VARCHAR`, `DATE`, etc.
- **Constraints Applied:**
    - **Primary Keys:** 
    Applied `PRIMARY KEY` constraints to ensure data integrity (e.g., `rider_id`, `restaurant_id`, `order_id`, delivery_id).
    - **Foreign Keys:** Established relationships between tables:
        - `Deliveries (Order_id)` → `Orders (order_id)`
        - `Orders (customer_id)` → `Customers (customer_id)`
        - `Orders (restaurant_id)` → `Restaurants (restaurant_id)`
        - `Deliveries (rider_id)` → `Riders (rider_id)`
      
![Er Diagram After Relationships](https://github.com/user-attachments/assets/25923c7d-d619-4c6b-84bc-31b4a9a2a2c9)

## Outcome of the Task

- **Data Integrity:** Constraints were put in place to ensure that only valid data could be inserted or updated, enforcing the rules of the business domain.
- **Efficient Queries:** The database structure was designed to facilitate quick and efficient queries, ensuring smooth operations and fast data retrieval.
- **Scalability:** With proper relational design, the database is now scalable, ready to support growing data volumes and complex business applications.

---

## **Data Quality Checks**

In this section, the focus was on validating the integrity and completeness of the data across the tables. The key tasks included:

- **Missing Values Detection:** Checked critical columns in the `Customers`, `Orders`, `Riders`, `Restaurants`, and `Deliveries` tables for any missing or NULL values. This ensured that all necessary data was present for analysis and reporting.
- **Ensuring Data Consistency:** Identified rows with NULL values in key fields to maintain data integrity, ensuring that no essential data was left incomplete.

---

## **Exploratory Data Analysis (EDA)**

After confirming the data quality, exploratory analysis was conducted to gain deeper insights and confirm the database’s structure. The tasks performed included:

- **Full Data Exploration:** Queried all records from the `Customers`, `Orders`, `Riders`, and `Deliveries` tables to get an overview of the data and ensure that the data was correctly imported and structured.
    
    This helped in identifying any further data quality issues and ensured all necessary data was available for further analysis.
    
- **Extracting Insights:** Analyzed the most recent order date to understand the latest transactions and identified the freshness of the data.
- **Comparative Analysis:** Retrieved the current date to compare against the order date, helping assess the timeliness and relevance of the transactions.
---
Files Link

Sql script created in this Project: 

Pdf of SQlL Query and It’s solution:

Docx file of SQL Script and Query:

---

## Overview of Tasks done in this Project
### **Q1: Top 5 Most Frequently Ordered Dishes by Customer "Arjun Mehta" in the Last 2 Years**

**Overview:**

This query identifies the top 5 dishes ordered most frequently by a specific customer, "Arjun Mehta", in the last two years. Using the `DENSE_RANK()` window function, the query ranks dishes based on their frequency of orders.

**Key SQL Skills Used:**

- `COUNT()` function to calculate the frequency of orders.
- `DENSE_RANK()` for ranking dishes based on frequency.
- `JOIN` to combine `Customers` and `Orders` tables.
- `DATEADD()` and `CAST()` for date manipulation.

---

### **Q2: Popular Time Slots for Orders Based on 2-Hour Intervals**

**Overview:**

This query identifies the most popular time slots during which orders are placed, based on a 2-hour interval. It uses `DATEPART()` to extract hours from the `order_time` and categorizes them into time slots.

**Key SQL Skills Used:**

- `CASE` for conditional logic to categorize time slots.
- `DATEPART()` for extracting hours from a timestamp.
- `GROUP BY` and `COUNT()` to aggregate and count orders in each time slot.

---

### **Q3: Average Order Value (AOV) for Customers Who Placed More Than 750 Orders**

**Overview:**

This query calculates the average order value for customers who have placed over 750 orders, filtering results based on order count.

**Key SQL Skills Used:**

- `AVG()` to compute the average order value.
- `HAVING` to filter customers with more than 750 orders.
- `JOIN` to combine `Customers` and `Orders` tables.

---

### **Q4: High-Value Customers Who Spent More Than 100K on Orders**

**Overview:**

The query identifies customers who have spent over 100,000 on food orders, returning customer details and their total expenditure.

**Key SQL Skills Used:**

- `SUM()` to calculate total spending.
- `JOIN` for combining customer and order data.
- `HAVING` to filter based on total spending.

---

### **Q5: Orders Not Delivered (Unfulfilled Orders)**

**Overview:**

This query identifies orders that were placed but not delivered. It accounts for both unfulfilled orders and those with a 'Not Delivered' status.

**Key SQL Skills Used:**

- `LEFT JOIN` to handle missing delivery records.
- `COUNT()` to calculate the number of undelivered orders.
- `GROUP BY` for aggregation by restaurant.

---

### **Q6: Restaurant Revenue Ranking (Last Year)**

**Overview:**

The query ranks restaurants within each city based on their total revenue from the previous year. It uses `DENSE_RANK()` to rank restaurants by revenue.

**Key SQL Skills Used:**

- `SUM()` for calculating total revenue.
- `DENSE_RANK()` for ranking within each city.
- `WHERE` clause for filtering data by year.

---

### **Q7: Most Popular Dish in Each City**

**Overview:**

This query finds the most popular dish in each city based on the number of orders placed. It uses `DENSE_RANK()` to rank dishes within each city by order count.

**Key SQL Skills Used:**

- `COUNT()` to determine the popularity of dishes.
- `DENSE_RANK()` to rank dishes by popularity.
- `GROUP BY` to group orders by city and dish.

---

### **Q8: Customer Churn Analysis (Orders in 2023 but Not in 2024)**

**Overview:**

This query identifies customers who placed an order in 2023 but have not placed any orders in 2024, helping with churn analysis.

**Key SQL Skills Used:**

- `DISTINCT` to get unique customers.
- `NOT IN` to filter customers who haven't ordered in 2024.
- `LEFT JOIN` to associate customers with orders.

---

### **Q9: Comparison of Cancellation Rates for Restaurants Between 2023 and 2024**

**Overview:**

This query compares the cancellation rates for each restaurant between 2023 and 2024, calculating cancellation percentages based on the number of cancelled orders.

This query calculates and compares the order cancellation rates for each restaurant between the years 2023 and 2024. It computes the cancellation rate as the percentage of orders that were canceled (i.e., no delivery was made) relative to the total number of orders for each restaurant in both years. The results show the cancellation rate for both years side by side for comparison.

### **Key SQL Skills Used:**

- **JOINs**: The query uses `LEFT JOIN` to combine data from the `Orders` and `Deliveries` tables, linking orders with their delivery information.
- **Conditional Logic (`CASE`)**: This is used to count canceled orders by checking if `delivery_id` is NULL, indicating that the order was not delivered.
- **Date Functions (`YEAR()`)**: Filters orders by year (2023 and 2024) to calculate cancellation rates for each year separately.
- **Aggregation (`COUNT()`)**: Counts the total number of orders and the number of canceled orders for each restaurant.
- **Subqueries**: There are multiple common table expressions (CTEs) to break down the calculations by year: `CANCELLED_RATE_2023` and `CANCELLED_RATE_2024`.
- **Mathematical Calculations**: The cancellation percentage is calculated by dividing the number of canceled orders by the total number of orders and multiplying by 100.
- **Casting (`CAST()`)**: Ensures that calculations involving decimals are done accurately by casting the values to `decimal(10,2)` for precision.
- **Comparison**: Joins the data from both years and compares the cancellation percentages for 2023 and 2024 for each restaurant.
- **Sorting (`ORDER BY`)**: Orders the results by `restaurant_id` for clarity in the output.

---

### **Q10 Rider Average Delivery Time**

**Objective:** Determine each rider's average delivery time.

This query calculates the average delivery time for each rider by computing the time taken to deliver each order and then averaging those times across all the orders completed by each rider. The time is measured in minutes and rounded to two decimal places. It filters out only the delivered orders.

### **Key SQL Skills Used:**

- **JOINs**: The query uses `LEFT JOIN` to combine data from `Orders`, `Deliveries`, and `Riders` tables, ensuring that relevant delivery and rider information is linked to the orders.
- **Date Functions (`DATEDIFF()`)**: Used to calculate the difference in minutes between the order time and delivery time.
- **Conditional Logic (`CASE`)**: Adjusts the time calculation if the delivery time is earlier than the order time, ensuring that the calculation takes into account day-over-day delivery (using 1440 minutes for a day adjustment).
- **Aggregation (`AVG()`)**: Calculates the average delivery time for each rider across multiple deliveries.
- **Rounding (`ROUND()`)**: Ensures that the average delivery time is rounded to two decimal places for consistency and precision.
- **Grouping (`GROUP BY`)**: Groups the data by rider ID and name to get the average delivery time per rider.
- **Ordering (`ORDER BY`)**: Sorts the results by rider ID for a structured output.

### **Q11 Monthly Restaurant Growth Ratio**

**Objective:** Calculate each restaurant's growth ratio based on the total number of delivered orders since its joining.

This query calculates the growth ratio for each restaurant based on the number of orders delivered each month. It compares the current month's total delivered orders with the previous month's total for each restaurant, determining the growth rate percentage. The result shows the monthly growth ratio in the number of delivered orders since the restaurant's joining.

### **Key SQL Skills Used:**

- **Window Functions (`LAG()`)**: Used to compare the current month's orders delivered with the previous month's orders within the same restaurant.
- **Aggregation (`COUNT()`)**: Counts the number of delivered orders per restaurant for each month.
- **Date Functions**: `YEAR()`, `MONTH()`, and `FORMAT()` are used to extract and format the date to group orders by month and year.
- **Casting (`CAST()`)**: Used to convert the counts and growth ratios into decimal format with two decimal places for precision.
- **Mathematical Operations**: Calculating the growth rate of orders delivered by subtracting the previous month's delivered orders from the current month's and then dividing by the previous month's total.
- **Filtering (`WHERE`)**: Filters orders to only include those with a delivery status of 'Delivered'.
- **Grouping (`GROUP BY`)**: Groups the data by restaurant, year, and month to calculate monthly totals.
- **Ordering (`ORDER BY`)**: Sorts the result by restaurant ID, year, and month to ensure chronological order of the data.

### **Q12 Customer Segmentation**

**Objective:** Segment customers into "Gold" or "Silver" based on their total spending and compare them with the Average Order Value (AOV).

- **Key Skills:**
    - **Aggregations**: `COUNT()`, `SUM()` for total orders and revenue.
    - **Subqueries**: Using a subquery to get the AOV.
    - **CASE Statements**: For segmentation based on total spend.
    - **JOINs**: Combining `Customers` and `Orders` tables.

### **Q13 Rider Monthly Earnings**

**Objective:** Calculate each rider's total monthly earnings based on 8% of the delivered order amount.

- **Key Skills:**
    - **Aggregations**: `SUM()` to calculate total earnings.
    - **Date Functions**: Extracting year and month with `YEAR()`, `MONTH()`.
    - **Calculations**: Multiplying the order amount by 8% to determine earnings.
    - **JOINs**: Combining `Orders`, `Deliveries`, and `Riders` tables.

### **Q14 Rider Rating Analysis**

**Objective:** Classify riders based on delivery times and count their ratings (5, 4, or 3 stars).

This task calculates the number of 5-star, 4-star, and 3-star ratings each rider receives based on their delivery time. It joins the `Orders` and `Deliveries` tables, calculates delivery times, and assigns ratings using a `CASE` statement. The results are grouped by rider and star rating, with the count of each rating per rider.

### **Key SQL Skills Used:**

- **CTEs**: To organize intermediate calculations.
- **JOINs**: To combine data from two tables.
- **`CASE` Statement**: For conditional logic to assign ratings.
- **Date/Time Functions**: For calculating delivery times.
- **Aggregation (`COUNT`, `GROUP BY`)**: To count ratings per rider.
- **Sorting**: To organize results by rider and rating frequency.

### **Q15  Restaurant Top days by Order Frequency**

**Objective:** Analyze the frequency of orders per day of the week and identify peak days for each restaurant.

This task analyzes the frequency of orders for each restaurant by day of the week, and identifies the peak day for orders at each restaurant. It calculates the number of orders placed on each day and ranks them per restaurant based on order frequency. The highest-ranked day (peak day) for each restaurant is selected and displayed, showing the restaurant name, peak weekday, order count, and its rank.

### **Key SQL Skills Used:**

- **CTEs**: Used to structure intermediate results for calculating the order frequency per day.
- **`LEFT JOIN`**: Combines data from `Orders` and `Restaurants` tables.
- **Date/Time Functions**: `DATEPART` and `DATENAME` to extract weekday information.
- **Aggregation (`COUNT`)**: Counts the number of orders for each day.
- **Window Functions (`DENSE_RANK()`)**: Assigns ranks based on the order frequency for each restaurant.
- **Filtering (`WHERE`)**: Filters out the highest-ranked (peak) day for each restaurant.
- **Sorting (`ORDER BY`)**: Orders the final result by the number of orders in descending order.

### **Q16 Customer Lifetime Value (CLV)**

**Objective:** Calculate the total revenue generated by each customer over all their orders.

- **Key Skills:**
    - **Aggregations**: `SUM()` to calculate total revenue.
    - **JOINs**: Joining `Orders` and `Customers` tables.
    - **Grouping**: Using `GROUP BY` for customer-level calculations.

### **Q17 Monthly Sales Trends**

**Objective:** Identify sales trends by comparing each month’s total sales to the previous month's sales.

This task analyzes monthly sales trends by comparing the total sales of each month with the previous month’s sales. The `LAG` function is used to retrieve the sales figure from the previous month for each month in the dataset. The sales growth percentage is then calculated and displayed, showing the year, month, previous month's sales, current month's sales, and the percentage growth in sales compared to the previous month.

### **Key SQL Skills Used:**

- **CTEs**: Used to organize and calculate intermediate results, including current and previous month's sales.
- **Date Functions**: `YEAR()`, `MONTH()`, and `DATENAME()` are used to extract and format year and month information.
- **Aggregation (`SUM()`)**: Used to calculate the total sales for each month.
- **Window Functions (`LAG()`)**: Retrieves sales data from the previous month for comparison.
- **Mathematical Operations**: Calculates the percentage growth in sales.
- **Type Casting (`CAST`)**: Used to round and format the percentage growth in a readable format.
- **Sorting (`ORDER BY`)**: Orders the results by year and month number to show trends in chronological order.

### **Q18 Rider Efficiency**

**Objective:** Evaluate rider efficiency by identifying those with the lowest and highest average delivery time.

This query evaluates the efficiency of riders by calculating their average delivery time. It identifies the riders with the lowest and highest average delivery times. The inner query calculates the average time each rider takes to deliver an order, while the outer query finds the minimum and maximum of these average times across all riders.

### **Key SQL Skills Used:**

- **Subqueries**: Used to calculate the average delivery time for each rider.
- **Aggregation (`AVG()`)**: Used to calculate the average delivery time for each rider.
- **Date Functions**: `DATEDIFF()` and `ABS()` are used to compute the delivery time based on order and delivery timestamps.
- **Type Casting (`CAST()`)**: Used to round the average delivery times to two decimal places and convert them into a decimal format.
- **MIN/MAX**: Used to find the minimum and maximum average delivery times.
- **JOINs**: `LEFT JOIN` is used to combine the `Orders`, `Deliveries`, and `Riders` tables to gather relevant data for analysis.
- **Filtering (`WHERE`)**: Ensures that only orders with a 'Delivered' status are considered in the calculation.

### **Q19 Order Item Popularity**

**Objective:** Track the popularity of order items and identify seasonal demand spikes.

- **Key Skills:**
    - **CASE Statements**: Identifying seasons based on months.
    - **Aggregations**: `COUNT()` to track the number of orders per item and season.
    - **Grouping**: `GROUP BY` to aggregate results by item and season.

### **Q20 Rank Cities by Total Revenue for Last Year**

**Objective:** Rank cities based on their total revenue for the year 2023.

- **Key Skills:**
    - **Aggregations**: `SUM()` to calculate total revenue.
    - **Window Functions**: `RANK()` to rank cities by revenue.
    - **Date Functions**: Filtering for the year 2023 using `YEAR()`.
    - **JOINs**: Combining `Orders` and `Restaurants` tables.
