/*
 Data Import and Table Creation
Successfully imported 5 CSV files into SQL Server to create the foundational database tables:
Orders
Customers
Deliveries
Restaurants
Riders
Adjusted data types during import to ensure compatibility and efficiency (e.g., INT, VARCHAR, DATE).
Applied necessary constraints such as PRIMARY KEY to enforce data integrity and uniqueness.
*/

ALTER TABLE Deliveries
ADD CONSTRAINT FK_Deliveries_Orders
FOREIGN KEY (Order_id) REFERENCES Orders(order_id);

ALTER TABLE Deliveries
ADD CONSTRAINT FK_Deliveries_Orders
FOREIGN KEY (Order_id) REFERENCES Orders(order_id);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customer_id
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Restaurant_id
FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id);

ALTER TABLE Deliveries
ADD CONSTRAINT FK_Deliveries_rider_id
FOREIGN KEY (rider_id) REFERENCES Riders(rider_id);

/*
Established a relational database ready for data analysis, reporting, and optimization.
The design ensures:
Data Integrity: Only valid data can be inserted or updated.
Efficient Queries: Optimized structure for faster query performance.
Database is now robust and scalable for real-world business applications.
*/

-- Exploratory Data Analysis
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Riders
SELECT * FROM Deliveries


SELECT * FROM Customers
WHERE 
	customer_id IS NULL OR
	customer_name IS NULL OR
	reg_date IS NULL

SELECT * FROM Orders
WHERE 
	order_id IS NULL OR 
	order_item IS NULL OR
	order_date IS NULL OR
	Order_time IS NULL OR
	order_status IS NULL OR
	total_amount IS NULL

SELECT * FROM Riders
WHERE 
	rider_id IS NULL OR
	rider_name IS NULL OR 
	sign_up IS NULL

SELECT * FROM Restaurants
WHERE
	restaurant_name IS NULL OR 
	opening_hours IS NULL OR 
	city IS NULL

SELECT * FROM Deliveries
WHERE 
	delivery_id IS NULL OR
	order_id IS NULL OR
	rider_id IS NULL OR 
	delivery_status IS NULL

-- The last order's date in the Orders table
SELECT MAX(order_date) Last_Order_Date FROM Orders

-- here we are considering Today's date as this
SELECT CAST(GETDATE() AS date) Todays_Date

-- Q1 Write a query to find the top 5 most frequently ordered dishes by customer called "Arjun Mehta" in the last 2 year
SELECT DATEADD(YEAR,-2, CAST(GETDATE() AS date)) CurrentDate

SELECT customer_name, Dishes, Rank_of_dishes FROM 
	(SELECT 
		c.customer_id,
		c.customer_name,
		o.order_item as Dishes, 
		COUNT(o.order_item) Nr_of_time_item_Order,
		DENSE_RANK() OVER(Order by COUNT(o.order_item) DESC) Rank_of_dishes
	FROM Orders o
	JOIN Customers c
		ON o.customer_id = c.customer_id
	WHERE
		c.customer_name = 'Arjun Mehta'
		AND
		order_date > DATEADD(YEAR,-2,CAST(GETDATE() AS date))
	GROUP BY 
		c.customer_id,
		c.customer_name, 
		o.order_item
	) t1
WHERE Rank_of_dishes <= 5

--Q2 Popular Time slot: Identify the time Slots during which the most orders are placed. based on 2 hours interval

-- Here for 00:59:59--> 0 and 1:59:59-->1, so 0 to 1 is Slot of 2 hours

WITH Popular_time_slot
AS
(
SELECT *,
	CASE 
	WHEN DATEPART(HH,order_time) BETWEEN 0 AND 1 THEN '00:00 - 02:00'
	WHEN DATEPART(HH,order_time) BETWEEN 2 AND 3 THEN '02:00 - 04:00'
	WHEN DATEPART(HH,order_time) BETWEEN 4 AND 5 THEN '04:00 - 06:00'
	WHEN DATEPART(HH,order_time) BETWEEN 6 AND 7 THEN '06:00 - 08:00'
	WHEN DATEPART(HH,order_time) BETWEEN 8 AND 9 THEN '08:00 - 10:00'
	WHEN DATEPART(HH,order_time) BETWEEN 10 AND 11 THEN '10:00 - 12:00'
	WHEN DATEPART(HH,order_time) BETWEEN 12 AND 13 THEN '12:00 - 14:00'
	WHEN DATEPART(HH,order_time) BETWEEN 14 AND 15 THEN '14:00 - 16:00'
	WHEN DATEPART(HH,order_time) BETWEEN 16 AND 17 THEN '16:00 - 18:00'
	WHEN DATEPART(HH,order_time) BETWEEN 18 AND 19 THEN '18:00 - 20:00'
	WHEN DATEPART(HH,order_time) BETWEEN 20 AND 21 THEN '20:00 - 22:00'
	WHEN DATEPART(HH,order_time) BETWEEN 22 AND 23 THEN '22:00 - 00:00'
END AS Time_Slot 
FROM Orders
)
SELECT Time_Slot, COUNT(*) Total_Orders FROM Popular_time_slot 
GROUP BY Time_Slot
ORDER BY COUNT(order_id) DESC
----
-- Q3 Order Value Analysis: Find the Average Order value per customer who has placed more than 750 orders
-- Return Customer_name, and AOV(Average Order Value)

SELECT 
	c.customer_id,
	c.customer_name,
	CAST(AVG(O.total_amount) AS decimal(10,2)) Avg_Order_Value
FROM Customers c
JOIN Orders o
	ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING 
	COUNT(o.order_id) > 750
ORDER BY 
	AVG(total_amount) DESC

--Q4  High Value Customers: List the Customers who have spent more than 100K in total on food orders.
-- Return customer_name, and customer_id

SELECT 
	c.customer_id, 
	c.customer_name,
	SUM(o.total_amount) Total_Spent
FROM Customers c
JOIN Orders o
	ON c.customer_id = o.customer_id
GROUP BY c.customer_id, 
		c.customer_name
HAVING 
		SUM(o.total_amount) > 100000
ORDER BY 
		SUM(o.total_amount) DESC

-- Q5 Orders without Delivery: Write query to find orders that were placed but not delivered.
-- Return each restaurant name, city and number of not delivered orders

-- Here we have to include both cases where orders was not fulfilled and Delivery status is "Not delivered"
SELECT  
    r.restaurant_name, 
    r.city, 
    COUNT(o.order_id) AS Total_Not_Delivered_Orders
FROM 
    Orders o
LEFT JOIN Deliveries d 
	ON o.order_id = d.order_id
LEFT JOIN Restaurants r 
	ON r.restaurant_id = o.restaurant_id
WHERE 
    d.delivery_status = 'Not Delivered' 
    OR d.delivery_status IS NULL  -- Capture orders with no delivery entry
GROUP BY 
    r.restaurant_name, r.city
ORDER BY 
    Total_Not_Delivered_Orders DESC;

-- Q6 Restaurant Revenue Ranking: Rank restaurants by their total revenue from the last year. 
--including their name, Total Revenue, and rank within their city
SELECT
	r.city,
	r.restaurant_name, 
	SUM(o.total_amount) Revenue, 
	DENSE_RANK() OVER(PARTITION BY city ORDER BY SUM(total_amount) DESC) Rank_of_Restaurant
FROM Orders o
LEFT JOIN Restaurants r
	ON r.restaurant_id = o.restaurant_id
WHERE  YEAR(order_date) < 2024
GROUP BY city, r.restaurant_name;


-- Top 3 Restaurant in their City based on Their Highest Revenue Revenue
WITH Ranking_Table 
AS (
SELECT
	r.city City,
	r.restaurant_name Restaurant, 
	SUM(o.total_amount) Revenue, 
	DENSE_RANK() OVER(PARTITION BY city ORDER BY SUM(total_amount) DESC) Rank_of_Restaurant
FROM Orders o
LEFT JOIN Restaurants r
	ON r.restaurant_id = o.restaurant_id
WHERE  
	YEAR(order_date) < 2024
GROUP BY city, r.restaurant_name
)
SELECT * FROM Ranking_Table
WHERE Rank_of_Restaurant <= 3;

-- Q7 Most popular dish by City:
--Identify the Most Popular dish in each city based on the number of orders
WITH Most_Popular_dish
AS
(SELECT 
	city, 
	order_item as Dishes,
	COUNT(order_id) Nr_of_Orders, 
	DENSE_RANK() OVER(PARTITION BY city ORDER BY COUNT(order_id)DESC) Rank_of_Dish
FROM Orders o
LEFT JOIN Restaurants r
	ON r.restaurant_id = o.restaurant_id
GROUP BY city, order_item
)
SELECT * FROM Most_Popular_dish
WHERE Rank_of_Dish = 1
ORDER BY 
		Nr_of_Orders DESC

--Q8 Customer Churn
-- Find Customers who haven't placed an order in 2024 but did in 2023
SELECT DISTINCT c.* FROM Orders o
LEFT JOIN Customers c
	ON o.customer_id = c.customer_id
WHERE
	YEAR(o.order_date) = 2023
	AND 
	c.customer_id NOT IN 
		(SELECT DISTINCT customer_id FROM Orders
		WHERE YEAR(order_date) = 2024)
ORDER BY c.customer_id;

--Q9 Cancelled Rate Comparison:
-- Calculate and Compare the order Cancellation rate for each restaurant between the currrent year 
-- and previous year 
-- Solution:Step 1 

WITH CANCELLED_RATE 
AS 
(
SELECT
    o.restaurant_id,
    COUNT(o.order_id) AS Total_Orders, 
    COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS Nr_of_Cancelled_Orders 
FROM Orders o
LEFT JOIN Deliveries d
    ON d.order_id = o.order_id
WHERE YEAR(o.order_date) = 2023
GROUP BY o.restaurant_id
)
SELECT
    restaurant_id,
    Total_Orders,
    Nr_of_Cancelled_Orders,
    CAST(CAST(Nr_of_Cancelled_Orders AS decimal(10,2)) 
	/ CAST(Total_Orders AS decimal(10,2)) * 100 AS decimal(10,2)) AS Cancel_Percent
	FROM CANCELLED_RATE
ORDER BY Total_Orders DESC

WITH CANCELLED_RATE_2024 
AS 
(
SELECT
    o.restaurant_id,
    COUNT(o.order_id) AS Total_Orders, 
    COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS Nr_of_Cancelled_Orders 
FROM Orders o
LEFT JOIN Deliveries d
    ON d.order_id = o.order_id
WHERE YEAR(o.order_date) = 2024
GROUP BY o.restaurant_id
)
SELECT
    restaurant_id,
    Total_Orders,
    Nr_of_Cancelled_Orders,
    CAST(CAST(Nr_of_Cancelled_Orders AS decimal(10,2)) 
	/ CAST(Total_Orders AS decimal(10,2)) * 100 AS decimal(10,2)) AS Cancel_rate
FROM CANCELLED_RATE_2024
ORDER BY Total_Orders DESC

-- Final Solution of Quesiton 9, Rearranging CTEs

WITH CANCELLED_RATE_2023 
AS 
(
	SELECT
		o.restaurant_id,
		COUNT(o.order_id) AS Total_Orders,
		COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS Nr_of_Cancelled_Orders -- Keep as INT
	FROM Orders o
	LEFT JOIN Deliveries d
		ON d.order_id = o.order_id
	WHERE YEAR(o.order_date) = 2023
	GROUP BY o.restaurant_id
),
CANCELLED_RATE_2024 
AS 
(
	SELECT
		o.restaurant_id,
		COUNT(o.order_id) AS Total_Orders, 
		COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS Nr_of_Cancelled_Orders 
	FROM Orders o
	LEFT JOIN Deliveries d
		ON d.order_id = o.order_id
	WHERE YEAR(o.order_date) = 2024
	GROUP BY o.restaurant_id
),
Last_Year_Data
AS
(
	SELECT
		restaurant_id,
		Total_Orders,
		Nr_of_Cancelled_Orders,
	CAST(CAST(Nr_of_Cancelled_Orders AS decimal(10,2)) 
	/ CAST(Total_Orders AS decimal(10,2)) * 100 AS decimal(10,2)) AS Cancel_Percent
	FROM CANCELLED_RATE_2023
), 
Current_year_Data
AS
(
	SELECT
		restaurant_id,
		Total_Orders,
		Nr_of_Cancelled_Orders,
		CAST(CAST(Nr_of_Cancelled_Orders AS decimal(10,2)) 
		/ CAST(Total_Orders AS decimal(10,2)) * 100 AS decimal(10,2)) AS Cancel_Percent
	FROM CANCELLED_RATE_2024
)

SELECT 
	cy.restaurant_id, 
	ly.Cancel_Percent Cancellation_Percent_of_2023 , 
	cy.Cancel_Percent Cancellation_Percent_of_2024
FROM Current_year_Data cy
JOIN Last_Year_Data ly 
ON cy.restaurant_id = ly.restaurant_id
ORDER BY cy.restaurant_id

-- Q10 Rider Average Delivery Time
-- Determine each rider's average delivery time

WITH Riders_Avg_Delivery_Time
AS 
(
    SELECT 
        r.rider_id,
        r.rider_name, 
        o.order_time, 
        d.delivery_time,
		CAST(CASE 
		WHEN  d.delivery_time < o.order_time THEN (1440 - ABS(DATEDIFF(MINUTE,order_time,d.delivery_time)))
		ELSE ABS(DATEDIFF(MINUTE,order_time,d.delivery_time)) 
	END as decimal(10,2)) Time_Taken_to_deliver
    FROM Orders o
    LEFT JOIN Deliveries d ON o.order_id = d.order_id
    LEFT JOIN Riders r ON d.rider_id = r.rider_id
    WHERE d.delivery_status = 'Delivered'
)
SELECT 
    rider_id, 
    rider_name,
    CAST(ROUND(AVG(Time_Taken_to_deliver),2) AS decimal(10,2)) AS Avg_Time_By_Riders_in_MINs
FROM Riders_Avg_Delivery_Time
GROUP BY rider_id, rider_name
ORDER BY rider_id

-- Q11 Monthly Restaurant Growth Ratio:
-- Calculate each restaurant's growth ratio based on the total number of delivered orders since its joining

WITH Growth_Rate_of_Delived_Orders
AS
(
SELECT
	o.restaurant_id, 
	YEAR(o.order_date) Order_year, 
	MONTH(o.order_date) Order_Month,
	FORMAT(o.order_date, 'MMM yyyy') AS Month_year,
	CAST(COUNT(d.delivery_id) AS decimal(10,2)) AS Current_Month_Orders_Delivered,
	CAST(LAG(COUNT(d.delivery_id)) OVER(PARTITION BY o.restaurant_id 
								ORDER BY YEAR(o.order_date),MONTH(o.order_date)) AS decimal(10,2)) Prev_Month_Orders_delivered
FROM Orders o
LEFT JOIN Deliveries d
	ON o.order_id = d.order_id
WHERE d.delivery_status = 'Delivered'
GROUP BY 
	o.restaurant_id, 
	YEAR(o.order_date), 
	MONTH(o.order_date), 
	FORMAT(o.order_date, 'MMM yyyy')
)
SELECT 
restaurant_id,
Month_year,
Current_Month_Orders_Delivered,
Prev_Month_Orders_delivered,
ROUND(CAST((Current_Month_Orders_Delivered - Prev_Month_Orders_delivered)/Prev_Month_Orders_delivered * 100 AS decimal(10,2)),2) as Grow_Rate_in_Orders_Delivered
FROM Growth_Rate_of_Delived_Orders
ORDER BY 
	restaurant_id, 
	Order_year,
	Order_Month

--Q12 Customer Segmentations:
-- (1) Segment Customers into "Gold" or "Silver" groups based on their total spending
-- (2) Compare to the Average Order Value
-- If Customer's total spending  exceeds AOV Label them with gold other wise label them as  silver
-- Write a Query to Determine each segment's total number of orders and total revenue

SELECT 
	Customer_Category,
	SUM(Total_Spend) Total_Revenue,
	SUM(Nr_of_Orders) Total_Orders
FROM 
(
	SELECT 
	c.customer_name,
	COUNT(o.order_id) Nr_of_Orders,
	SUM(o.total_amount) Total_Spend,
	CASE
		WHEN SUM(o.total_amount)> (SELECT AVG(total_amount) from Orders) THEN 'Gold'
		ELSE 'Silver'
	END as Customer_Category
	FROM Orders o
	JOIN Customers c
		ON c.customer_id = o.customer_id
	GROUP BY 
		c.customer_id,
		c.customer_name
) as t2
GROUP BY Customer_Category;

-- Q13 Rider Monthly Earning:
-- Calculate each rider's total monthly earnings, assuming they earn 8% of the Delivered Order Amount

WITH Riders_Monthly_Earning
AS
(SELECT
	rd.rider_id ,
	rd.rider_name, 
	YEAR(o.order_date) Order_year, 
	Month(o.order_date) Order_Month,
	FORMAT(o.order_date,'MMMM yyyy') Month_year,
	CAST(SUM(total_amount) * 0.08 AS decimal(10,2)) Total_Earning_of_Rider
FROM Orders o
LEFT JOIN Deliveries d
	ON d.order_id = o.order_id
LEFT JOIN Riders rd
	ON rd.rider_id = d.rider_id
WHERE d.delivery_status = 'Delivered'
GROUP BY
	rd.rider_id,
	rd.rider_name,
	YEAR(o.order_date), 
	Month(o.order_date),
	FORMAT(o.order_date,'MMMM yyyy')
) 
SELECT rider_id, rider_name, Month_year, Total_Earning_of_Rider FROM Riders_Monthly_Earning;
 
--Q 14 Rider Rating Analysis:
-- Find the number of 5 Star. 4 star, and 3 star rating Each riders has.
-- Riders recieve this rating based on delivery time
-- IF orders are delivered less than 15 Minutes of order recieved time the rider get 5 star rating.
-- IF they delivery is 15 to 20 Minute then they get a 4 star rating
-- IF they deliver after 20 Minute they get 3 star rating.

WITH Main_cte
AS
(
	SELECT 
	d.rider_id as Rider_id, 
	o.order_time Order_time,
	d.delivery_time,
	CASE 
		WHEN  d.delivery_time < o.order_time THEN (1440 - ABS(DATEDIFF(MINUTE,order_time,d.delivery_time)))
		ELSE ABS(DATEDIFF(MINUTE,order_time,d.delivery_time)) 
	END Time_taken_to_Deliver
	FROM Orders o
	JOIN Deliveries d
	ON o.order_id = d.order_id
	WHERE d.delivery_status = 'Delivered'
),
Final
AS
(
	SELECT Rider_id, 
	CASE 
		WHEN Time_taken_to_Deliver <=15 THEN '5 star'
		WHEN Time_taken_to_Deliver > 15 AND Time_taken_to_Deliver <= 20 THEN '4 Star'
		ELSE '3 Star'
	END	STARS,
	Time_taken_to_Deliver
	FROM Main_cte
)
SELECT
	Rider_id,
	STARS, 
	COUNT(STARS) Total_Stars
FROM Final
GROUP BY 
	Rider_id, 
	STARS
ORDER BY 
	Rider_id, 
	COUNT(STARS) DESC;

-- Q 15 Order Frequency by Day:
-- Analyze order fequency per day of the week and identify the peak day for each restaurant

WITH Peak_day_for_Restaurant
AS
(
	SELECT
		o.restaurant_id,
		r.restaurant_name as Restaurant,
		DATEPART(WEEKDAY,o.order_date) Week_number,
		DATENAME(WEEKDAY, o.order_date)  Weekday_name, 
		COUNT(o.order_id) Nr_of_Orders,
		DENSE_RANK() OVER(PARTITION BY o.restaurant_id 
				ORDER BY COUNT(o.order_id) DESC ) as Rank_of_Week_Day
	FROM Orders o 
	LEFT JOIN Restaurants r
		ON r.restaurant_id = o.restaurant_id
	GROUP BY o.restaurant_id,
			r.restaurant_name,
			DATENAME(WEEKDAY, o.order_date), 
			DATEPART(WEEKDAY,o.order_date)
) 
SELECT Restaurant, Weekday_name, Nr_of_Orders, Rank_of_Week_Day FROM Peak_day_for_Restaurant
WHERE Rank_of_Week_Day = 1
ORDER BY Nr_of_Orders DESC

-- Q16 Customer Lifetime value(CLV)
-- Calculate the Total Revenue Generated by each customer over all  their orders
SELECT
	c.customer_id, 
	c.customer_name, 
	SUM(o.total_amount) Customer_Lifetime_Value FROM Orders o
JOIN Customers c
	ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY 
		SUM(o.total_amount) DESC;

-- Q 17 Monthly Sales Trends:
-- Identify Sales Trends by Comparing each month's total Sales to the previous months
WITH Monthly_Sales_Trends
AS
(
SELECT
YEAR(order_date) Year,
MONTH(Order_date) Month_Number,
DATENAME(MONTH,Order_date) Month_Name, 
SUM(total_amount) Current_Month_Sales,
LAG(SUM(total_amount)) OVER(ORDER BY MONTH(Order_date)) Prev_Month_Sales
FROM Orders
GROUP BY  
	DATENAME(MONTH,Order_date),
	YEAR(order_date),	
	MONTH(Order_date)
)
SELECT 
Year,
Month_Name,
Prev_Month_Sales,
Current_Month_Sales,
CAST(ROUND((Current_Month_Sales- Prev_Month_Sales)/Prev_Month_Sales* 100,2)AS decimal(10,2)) Percent_Growth_In_Sales
FROM Monthly_Sales_Trends
ORDER BY Year, Month_Number

-- Q 18 Rider Effeciency
-- Evaluate rider Effeciency by determining Average Delivery times and Identifying those with lowest 
-- And highest Average Delivery time

SELECT  -- By this You will get  Minimum and Maximum Average time taken to deliver
MIN(Avg_Time_Taken_to_Deliver) Min_Avg_Time_taken_to_deliver, 
MAX(Avg_Time_Taken_to_Deliver) Max_Avg_Time_taken_to_deliver
FROM
( -- By this Subquery you will get Average Time taken by Riders
SELECT Rider_Id, Rider_Name, CAST(ROUND(Avg_Time_taken_to_Deliver,2) AS decimal(10,2)) AS Avg_Time_Taken_to_Deliver FROM
(
SELECT
	r.rider_id as Rider_Id,
	rider_name as Rider_Name,
	AVG(CAST(CASE 
		WHEN  d.delivery_time < o.order_time THEN (1440 - ABS(DATEDIFF(MINUTE,order_time,d.delivery_time)))
		ELSE ABS(DATEDIFF(MINUTE,order_time,d.delivery_time)) 
	END as decimal(10,2))) Avg_Time_taken_to_Deliver 
FROM Orders o
LEFT JOIN Deliveries d
	ON o.order_id = d.order_id
LEFT JOIN Riders r
	ON r.rider_id = d.rider_id
WHERE 
	d.delivery_status = 'Delivered'
GROUP BY r.rider_id,rider_name
) as t1
-- ORDER BY Avg_Time_taken_to_Deliver DESC 
)t2

-- Q19 Order Item Popularity :
-- Track the Popularity of specific order items over time and identify seasonal demand spike

SELECT order_item,Season, COUNT(order_id) Nr_of_Orders
FROM (
	SELECT 
		*, 
		CASE 
		WHEN MONTH(order_date) BETWEEN 3 AND 5 THEN 'Summer' 
		WHEN MONTH(order_date) BETWEEN 6 AND 9 THEN  'Monsoon'
		WHEN MONTH(order_date) BETWEEN 10 AND 11 THEN  'Autumn'
		WHEN MONTH(order_date) IN ( 11, 12, 1, 2) THEN  'Winter'
		END Season
	FROM Orders
) t1
GROUP BY order_item,
		Season
ORDER BY 
	order_item,
	Nr_of_Orders DESC

-- Q 20 Rank each City based on the Total revenue for last year 2023
SELECT 
	r.city, 
	SUM(o.total_amount) Total_Revenue,
	RANK() OVER(ORDER BY SUM(o.total_amount) DESC) Rank_of_City_by_Revenue 
FROM Orders o
LEFT JOIN Restaurants r
ON r.restaurant_id = o.restaurant_id
WHERE YEAR(order_date) = 2023
GROUP BY r.city 