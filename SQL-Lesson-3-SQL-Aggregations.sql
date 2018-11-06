#SQL Aggregations

## SUM

/* 1. Find the total amount of poster_qty paper ordered in the orders table. */

SELECT SUM (poster_qty) AS total_poster_sales
FROM orders;

/* 2. Find the total amount of standard_qty paper ordered in the orders table. */

SELECT SUM (standard_qty) AS total_standard_sales
FROM orders;

/* 3. Find the total dollar amount of sales using the total_amt_usd in the orders table. */

SELECT SUM (total_amt_usd) AS total_dollar_sales
FROM orders;

/* 4. Find the total amount for each individual order that was spent on standard and gloss paper in the orders table. This should give a dollar amount for each order in the table.   */

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

/* 5. Though the price/standard_qty paper varies from one order to the next. I would like this ratio across all of the sales made in the orders table. */

SELECT SUM (standard_amt_usd) / SUM (standard_qty) AS standard_price_per_unit
FROM orders;

## MIN and MAX

SELECT MIN(standard_qty) AS standard_min, MAX(standard_qty) AS standard_max
FROM orders;

## AVG

SELECT AVG (standard_qty) AS standard_avg
FROM orders;

## MIN MAX AVG Practice

/* 1. When was the earliest order ever placed? */

SELECT MIN (occurred_at)
FROM orders;

/* 2. Try performing the same query as in question 1 without using an aggregation function. */

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

/* 3. When did the most recent (latest) web_event occur? */

SELECT MAX (occurred_at)
FROM web_events;

/* 4. Try to perform the result of the previous query without using an aggregation function. */

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/* 5. Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.*/

SELECT AVG (standard_qty) mean_standard_qty,
		AVG (gloss_qty) mean_gloss_qty,
		AVG (poster_qty) mean_poster_qty,
		AVG (standard_amt_usd) mean_standard_usd,
		AVG (gloss_amt_usd) mean_gloss_usd,
		AVG (poster_amt_usd) mean_poster_usd
FROM orders;

/* 6. Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders? Note, this is more advanced than the topics we have covered thus far to build a general solution, but we can hard code a solution in the following way. */

SELECT *
FROM (SELECT total_amt_usd
		FROM orders
		ORDER BY total_amt_usd
		LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

## Group By Part 1

SELECT a.name, MIN (o.occurred_at)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;


/* 1. Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order. */

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

/* 2. Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name. */

SELECT a.name, SUM (o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name

/* 3. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name. */

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

/* 4. Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used. */

SELECT w.channel COUNt(*)
FROM web_events
GROUP BY w.channel

/* 5. Who was the primary contact associated with the earliest web_event? */

SELECT a.primary_poc
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

/* 6. What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest. */

/* My Answer */
SELECT a.name, MIN(o.total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY smallest_order;

/* Standard Answer */

SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

/* 7. Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps. */

SELECT r.name, COUNT(*) number_reps
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
GROUP BY r.name
ORDER BY number_reps;


SELECT account_id, channel, COUNT(id) AS events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, channel

## Group By Part 2

SELECT account_id, channel, COUNT(id) AS events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, channel

/* 1. For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average spent on each of the paper types. */

SELECT a.name AVG(o.standard_qty) avg_standard, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_poster
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name;

/* standard answer */

SELECT a.name, AVG(o.standard_qty) avg_stand, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

/* 2. For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type. */

SELECT a.name AVG(o.standard_amt_usd) avg_standard, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_poster
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name;

/* standard answer */

SELECT a.name, AVG(o.standard_amt_usd) avg_stand, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

/* 3. Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first. */

SELECT s.name, w.channel, COUNT(*) number_events
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY number_events DESC;

/* standard answer */

SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

/* 4. Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first. */

SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY number_events DESC;

## DISTINCT

/* 1. Use DISTINCT to test if there are any accounts associated with more than one region. */

SELECT a.id AS "account id", r.id AS "region id", a.name AS "account name", r.name AS "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

SELECT DISTINCT id, name
FROM accounts;

/* 2. Have any sales reps worked on more than one account? */

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

SELECT DISTINCT id, name
FROM sales_reps;


## HAVING

/* 1. How many of the sales reps have more than 5 accounts that they manage? */

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;


/* 2. How many accounts have more than 20 orders? */

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

/* 3. Which account has the most orders? */

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

/* 4. How many accounts spent more than 30,000 usd total across all orders? */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

/* 5. How many accounts spent less than 1,000 usd total across all orders? */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

/* 6. Which account has spent the most with us? */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

/* 7. Which account has spent the least with us? */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

/* 8. Which accounts used facebook as a channel to contact customers more than 6 times? */

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

/* 9. Which account used facebook most as a channel? */

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

/* 10. Which channel was most frequently used by most accounts? */

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

## DATE

/* 1. Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals? */

SELECT DATE_PART('year', occurred_at) ord_year, SUM(total_amt_usd) total_spent
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

/* 2. Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset? */

SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

/* 3. Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset? */

SELECT DATE_PART('year', occurred_at) ord_year, COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

/* 4. Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset? */

SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

/* 5. In which month of which year did Walmart spend the most on gloss paper in terms of dollars? */

SELECT DATE_TRUNC('month', o.occurred_at) order_date, SUM(o.gloss_amt_usd) total_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

## CASE

/* 1. We would like to understand 3 different branches of customers based on the amount associated with their purchases. The top branch includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second branch is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first. */

SELECT a.name, SUM(total_amt_usd) total_spent,
		CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
		WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
		ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY 2 DESC;

/* 2. We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first. */

SELECT a.name, SUM(total_amt_usd) total_spent,
		CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
		WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
		ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE o.occurred_at > '2015-12-31'
GROUP BY 1
ORDER BY 2 DESC; 

/* 3. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table. */

SELECT s.name, COUNT(*) num_orders,
		CASE WHEN COUNT(*) > 200 THEN 'top'
		ELSE 'not' END AS sales_reps_level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY 1
ORDER BY 2 DESC;

SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;

/* 4. The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. */

SELECT s.name, COUNT(*), SUM(total_amt_usd) total_spent,
		CASE WHEN COUNT(*) >200 OR SUM(total_amt_usd) >750000 THEN 'top'
		WHEN COUNT(*) >150 OR SUM(total_amt_usd) > 500000 THEN 'middle'
		ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY 1
ORDER BY 3 DESC;


SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;