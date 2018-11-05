# SQL JOINS

Note Information:
* Note created by MaxineMann
* Resources provided by Udacity
* All queries are stored in the SQL file ([SQL-Lesson-2-SQL-JOINS.sql](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/SQL-Lesson-2-SQL-JOINS.sql))

Table of Content
----

* [Introduction to JOINS](#Introduction-to-JOINS)
	* [JOINS and ON](#JOINS-and-ON)
		* [JOIN](#JOIN)
       		* [ON](#ON)
	* [Database Normalization](#Database-Normalization)
	* [JOIN Application](#JOIN-Application)
        	* [What to Notice](#What-to-Notice)
        	* [Additional Information](#Additional-Information)
	* [Quiz Questions 1](#Quiz-Questions-1)
* [JOIN and Entity Relationship Diagrams](#JOIN-and-Entity-Relationship-Diagrams)
	* [Tables and Columns](#Tables-and-Columns)
	* [Keys](#Keys)
		* [Primary Key](#Primary-Key)
        	* [Foreign Key](#Foreign-Key)
        	* [Primary and Foreign Key Link](#Primary-and-Foreign-Key-Link)
          	* [ERD for the Link Between PK and FK](#ERD-for-the-Link-Between-PK-and-FK)
        	* [JOIN More than Two Tables](#JOIN-More-than-Two-Tables)
        	* [The Code](#The-Code)
* [Alias](#Alias)
	* [Alias for Tables](#Alias-for-Tables)
	* [Aliases for Columns in Resulting Table](#Aliases-for-Columns-in-Resulting-Table)
* [JOIN Practice 1](#JOIN-Practice-1)
	* [Practice Notice](#Practice-Notice)
* [JOIN Type](#JOIN-Type)
	* [INNER JOINS](#INNER-JOINS)
        	* [LEFT JOIN](#LEFT-JOIN)
        	* [RIGHT JOIN](#RIGHT-JOIN)
	* [JOIN Type Notice](#JOIN-Type-Notice)
	* [OUTER JOINS](#OUTER-JOINS)
	* [Quiz Questions 2](#Quiz-Questions-2)
* [JOIN and Filtering](#JOIN-and-Filtering)
* [JOIN Practice 2](#JOIN-Practice 2)
* [Recap](#Recap)
	* [Recap Primary and Foreign Keys](#Recap-Primary-and-Foreign-Keys)
	* [Recap JOINs](#Recap-JOINs)
	* [Recap Alias](#Recap-Alia)
	* [Looking Ahead](#Looking-Ahead)

## Introduction to JOINS

### JOINS and ON

You will notice, we have introduced two new parts to our regular queries: **JOIN** and **ON**. The **JOIN** introduces the second table from which you would like to pull data, and the **ON** tells you how you would like to merge the tables in the FROM and JOIN statements together.

#### JOIN

`JOINS`: Tell query an additional table from which you would like to pull data

The whole goal of **JOIN** statements is to allow us to pull from more than one table at a time. Again - **JOIN**s are useful for allowing us to pull data from multiple tables. This is both simple and powerful all at the same time.

The reason to use **JOIN** is that:

* Orders and accounts are different types of objects
* This allows queries to execute mire quickly

#### ON

`ON`: Specifies a logical statement to combine the table in **from** and **JOIN** statement

With the addition of the **JOIN** statement to our toolkit, we will also be adding the **ON** statement.


### Database Normalization

When creating a database, it is really important to think about how data will be stored. This is known as normalization, and it is a huge part of most SQL classes. If you are in charge of setting up a new database, it is important to have a thorough understanding of database normalization.

There are essentially three ideas that are aimed at database normalization:

* Are the tables storing logical groupings of the data?
* Can I make changes in a single location, rather than in many tables for the same information?
* Can I access and manipulate data quickly and efficiently?

This is discussed in detail [here](http://sqlmag.com/database-performance-tuning/sql-design-why-you-need-database-normalization).

However, most analysts are working with a database that was already set up with the necessary properties in place. As analysts of data, you don't really need to think too much about data normalization. You just need to be able to pull the data from the database, so you can start drawing insights. This will be our focus in this lesson.

### JOIN Application 

Using the following ERD:

![059af1b9231ee35efb916d566c4d5722.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/erd.png)

```
/* Example */
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

#### What to Notice
We are able to pull data from two tables:

1. orders
2. accounts

Above, we are only pulling data from the `orders` table since in the **SELECT** statement we only reference columns from the `orders` table.

The **ON** statement holds the two columns that get linked across the two tables. This will be the focus in the next concepts.

#### Additional Information
If we wanted to only pull individual elements from either the orders or accounts table, we can do this by using the exact same information in the **FROM** and **ON** statements. However, in your **SELECT** statement, you will need to know how to specify tables and columns in the **SELECT** statement:

1. The table name is always before the period.
2. The column you want from that table is always after the period.

For example, if we want to pull only the account name and the dates in which that account placed an order, but none of the other columns, we can do this with the following query:

```
SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

This query only pulls two columns, not all the information in these two tables. Alternatively, the below query pulls all the columns from _ both_ the `accounts` and `orders` table.

```
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

And the first query you ran pull all the information from only the `orders` table:

```
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

Joining tables allows you access to each of the tables in the **SELECT** statement through the table name, and the columns will always follow a "." after the table name.

### Quiz Questions 1

1. Try pulling all the data from the accounts table, and all the data from the orders table.
```
SELECT accounts.*, orders.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;
```

2. Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
```
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

## JOIN and Entity Relationship Diagrams

### Tables and Columns

In the Parch & Posey database there are 5 tables:

1. web_events
2. accounts
3. orders
4. sales_reps
5. region

You will notice some of the columns in the tables have **PK** or **FK** next to the column name, while other columns don't have a label at all.

The **PK** is associated with the first column in every table. The **PK** here stands for primary key. A primary key exists in every table, and it is a column that has a unique value for every row.

If you look at the first few rows of any of the tables in our database, you will notice that this first, **PK**, column is always unique. For this database it is always called `id`, but that is not true of all databases.

### Keys

#### Primary Key

A primary key is a unique column in a particular table. The primary key is a single column that must exist in each table of a database. Again, these rules are true for most major databases, but some databases may not enforce these rules.

This is the first column in each of our tables. Here, those columns are all called id, but that doesn't necessarily have to be the name. It is common that the primary key is the first column in our tables in most databases.

#### Foreign Key

A foreign key is when we see a primary key in another table. We can see these in the previous ERD the foreign keys are provided as:

1. region_id
2. account_id
3. sales_rep_id


#### Primary and Foreign Key Link

Each of **Foreign Key** is linked to the **Primary Key** of another table. An example is shown in the image below:

![b739bf3e4634f98908cfc5df136c9da4.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/screen-shot-2017-08-10-at-8.23.48-pm.png)

In the above image you can see that:

1. The region_id is the foreign key.
2. The region_id is linked to id - this is the primary-foreign key link that connects these two tables.
3. The crow's foot shows that the FK can actually appear in many rows in the sales_reps table.
4. While the single line is telling us that the PK shows that id appears only once per row in this table.

`Primaru Key`: Has a unique value for every row in that column. There is one in every table.

`Foreign Key`: The link to the primary key that exists in another table.

#### ERD for the Link Between PK and FK

Notice our SQL query has the two tables we would like to join - one in the FROM and the other in the JOIN. Then in the ON, we will ALWAYs have the PK equal to the FK. The way we join any two tables is in this way: linking the PK and FK (generally in an ON statement).

```
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

![dafa784d23c7b81a622ddf4d32ec772a.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/screen-shot-2017-08-11-at-11.54.30-am.png)

If we wanted to join the `sales_reps` and `region` tables together:

```
ON sales_reps.region_id = region.id
```

![f772f725e47e308fa3d098a4e0622ebb.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/screen-shot-2017-08-10-at-8.10.13-pm.png)

#### JOIN More than Two Tables

This same logic can actually assist in joining more than two tables together. Look at the three tables below.

![7266ce0db5af4e83633b037bac8a210a.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/screen-shot-2017-08-11-at-3.21.34-pm.png)

#### The Code

If we wanted to join all three of these tables, we could use the same logic. The code below pulls all of the data from all of the joined tables.

```
SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id
```

Alternatively, we can create a **SELECT** statement that could pull specific columns from any of the three tables. Again, our **JOIN** holds a table, and **ON** is a link for our **PK** to equal the **FK**.

To pull specific columns, the **SELECT** statement will need to specify the table that you are wishing to pull the column from, as well as the column name. We could pull only three columns in the above by changing the select statement to the below, but maintaining the rest of the **JOIN** information:

```
SELECT web_events.channel, accounts.name, orders.total
```

We could continue this same process to link all of the tables if we wanted. For efficiency reasons, we probably don't want to do this unless we actually need information from all of the tables.

## Alias

### Alias for Tables

When we **JOIN** tables together, it is nice to give each table an **alias**. Frequently an alias is just the first letter of the table name. You actually saw something similar for column names in the **Arithmetic Operators** concept.

Example:

```
FROM tablename AS t1
JOIN tablename2 AS t2
```

Before, you saw something like:

```
SELECT col1 + col2 AS total, col3
```

Frequently, you might also see these statements without the **AS** statement. Each of the above could be written in the following way instead, and they would still produce the exact same results:

```
FROM tablename t1
JOIN tablename2 t2
```

and

```
SELECT col1 + col2 total, col3
```

### Aliases for Columns in Resulting Table

While aliasing tables is the most common use case. It can also be used to alias the columns selected to have the resulting table reflect a more readable name.

Example:

```
Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2
```

The alias name fields will be what shows up in the returned table instead of `t1.column1` and `t2.column2`

| aliasname | aliasname2|
|---|---|
|example row | example row |
|example row | example row |

We can simply write our alias directly after the column name (in the **SELECT**) or table name (in the **FROM** or **JOIN**) by writing the alias directly following the column or table we would like to alias. This will allow you to create clear column names even if calculations are used to create the column, and you can be more efficient with your code by aliasing table names.

## JOIN Practice 1

![059af1b9231ee35efb916d566c4d5722.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/erd.png)

1. Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen. 

```
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';
```

2. Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

```
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;
```

3. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

```
SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;
```

#### Practice Notice

You have had a bit of an introduction to these **one-to-one** and **one-to-many** relationships when we introduced **PK**s and **FK**s. Notice, traditional databases do not allow for many-to-many relationships, as these break the schema down pretty quickly. A very good answer is provided here.

The types of relationships that exist in a database matter less to analysts, but you do need to understand why you would perform different types of JOINs, and what data you are pulling from the database. These ideas will be expanded upon in the next concepts.

In addition, there are some statements from the quiz:
* [X]  The ON statement should always occur with the foreign key being equal to the primary key.
* [X] JOIN statements allow us to pull data from multiple tables in a SQL database.
* [X] You can use all of the commands we saw in the first lesson along with JOIN statements.
* [ ] SQL requires the ON statement always occur with the foreigh key being equal to the primary key.
* [ ] The only way to pull data together from multiple tables is using a JOIN statement.

## JOIN Type

* `INNER JOIN`: Only returns rows that appear in both tables
    * `LEFT JOIN`
    * `RIGHT JOIN`
* `OUTER JOIN`: Each of these joins will provide all the resulting rows of an innter join, but we may also gain some additional rows
    * `FULL OTHER JOIN`

The table listed in the FROM statement is considered the left table while the table listed in the LEFT JOIN statement is considered the right table. 

### INNER JOINS

#### LEFT JOIN

`LEFT JOIN` will return any results that match both tables and that are in the left table.

```
SELECT
FROM left table
LEFT JOIN right table
```
![e1d125319ec22ce07ccdfa7949fac172.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/Screen%20Shot%202018-11-04%20at%208.33.47%20PM.png)

#### RIGHT JOIN

`RIGHT JOIN` will return any results that match both tables and that are in the right table.

```
SELECT
FROM left table
RIGHT JOIN right table
```
![91efd98287f6b18584b550b6d5d8357a.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/Screen%20Shot%202018-11-04%20at%208.33.24%20PM.png)


### JOIN Type Notice
The LEFT JOIN and RIGHT JOIN are transferable.

The query:
```
SELECT a.id, a.name, o.tatal
FROM orders o
RIGHT JOIN accounts a
ON o.account_id = a.id
```

is the **same** as the query:

```
SELECT a.id, a.name, o.tatal
FROM accounts a
LEFt JOIN orders o
ON o.account_id = a.id
```

Notice every JOIN we have done up to this point has been an **INNER JOIN**. That is, we have always pulled rows only if they exist as a match across two tables.

Each of these new **JOIN** statements pulls all the same rows as an INNER JOIN, which you saw by just using JOIN, but they also potentially pull some additional rows. 

If there is not matching information in the JOINed table, then you will have columns with empty cells. These empty cells introduce a new data type called NULL. You will learn about NULLs in detail in the next lesson, but for now you have a quick introduction as you can consider any cell without data as NULL.

You might see the SQL syntax of `LEFT OUTER JOIN` OR `RIGHT OUTER JOIN`. These are the exact same commands as the `LEFT JOIN` and `RIGHT JOIN` 

### OUTER JOINS

The last type of join is a **full outer join**. This will return the inner join result set, as well as any unmatched rows from either of the two tables being joined.

Again this returns rows that do not match one another from the two tables. The use cases for a full outer join are very rare.

You can see examples of outer joins at the link [here](http://www.w3resource.com/sql/joins/perform-a-full-outer-join.php) and a description of the rare use cases [here](https://stackoverflow.com/questions/2094793/when-is-a-good-situation-to-use-a-full-outer-join). We will not spend time on these given the few instances you might need to use them.

Similar to the above, you might see the language `FULL OUTER JOIN`, which is the same as `OUTER JOIN`.

### Quiz Questions 2

![a70626b9073cf051c51b4f2ff2a3ea59.png](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/image/screen-shot-2017-08-14-at-1.12.55-pm.png)

Above are two small tables for you to test your knowledge of JOINs. You can click on the image to get a better view.

* Country has 6 rows and 2 columns: countryid, countryName
* State has 6 rows and 3 columns: stateid, countryid, stateName

Use the above tables to determine the solution to the following questions.

**1. Table Description**

Match the results of the query to the description.

|Description | Result |
|---|---|
| The primary key of the Country table | Country.countryid |
| The primary key of the State table  | State.stateid |
| The foreign key that would be used in JOINing the tables | state.countryid |

**2. INNER JOIN**

If you were to perform the following query:

```
SELECT c.countryid, c.countryName, s.stateName
FROM Country c
JOIN State s
ON c.countryid = s.countryid;
```

Match the results of the query to the description.

|Description | Result |
|---|---|
| The number of columns in resulting table | 3 |
| The number of rows in the resulting table | 6 |
| The number of times countryid 1 will show up in resulting table | 2 |
| The number of times countryid 6 will show up in the resulting table | 0 |

Since this is a JOIN (INNER JOIN technically), we only get rows that show up in both tables. Therefore our resulting table will essentially look like the right table with the countryName pulled in as a column. Since 1, 2, 3, and 4 are countryids in both tables, this information will be pulled together. The countryids of 5 and 6 only show up in the Country table. Therefore, these will be dropped.

**3. INNER JOIN**

If you were to perform the following query:

```
SELECT c.countryid, c.countryName, s.stateName
FROM Country c
LEFT JOIN State s
ON c.countryid = s.countryid;
```

Match the results of the query to the description.

|Description | Result |
|---|---|
| The number of columns in resulting table | 3 |
| The number of rows in the resulting table | 8 |
| The number of times countryid 1 will show up in resulting table | 2 |
| The number of times countryid 6 will show up in the resulting table | 1 |

We have a column for each of the identified elements in our SELECT statement. We will have all of the same rows as in a JOIN statement, but we also will obtain the additional two rows in the Country table that are not in the State table for Sri Lanka and Brazil.

**4. Flip LEFT JOIN**

If we were to flip the tables, we would actually obtain the same exact result as the JOIN statement:

```
SELECT c.countryid, c.countryName, s.stateName
FROM State s
LEFT JOIN Country c
ON c.countryid = s.countryid;
```

This is because if State is on the LEFT table, all of the rows exist in the RIGHT table again.

## JOIN and Filtering

A simple rule to remember this is that, when the database executes this query, it executes the join and everything in the ON clause first. Think of this as building the new result set. That result set is then filtered using the WHERE clause.

The fact that this example is a left join is important. Because inner joins only return the rows for which the two tables match, moving this filter to the ON clause of an inner join will produce the same result as keeping it in the WHERE clause.

## JOIN Practice 2

1. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

```
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;
```

2. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name. 

```
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;
```

3. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

```
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;
```

4. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01). 

```
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;
```

5. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 

```
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;
```

6. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 

```
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;
```

7. What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.

```
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';
```

8. Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.

```
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;
```

## Recap

### Recap Primary and Foreign Keys
You learned a key element for JOINing tables in a database has to do with primary and foreign keys:

* primary keys - are unique for every row in a table. These are generally the first column in our database (like you saw with the id column for every table in the Parch & Posey database).
* foreign keys - are the primary key appearing in another table, which allows the rows to be non-unique.

Choosing the set up of data in our database is very important, but not usually the job of a data analyst. This process is known as Database Normalization.

### Recap JOINs
In this lesson, you learned how to combine data from multiple tables using JOINs. The three JOIN statements you are most likely to use are:

1. JOIN - an INNER JOIN that only pulls data that exists in both tables.
2. LEFT JOIN - a way to pull all of the rows from the table in the FROM even if they do not exist in the JOIN statement.
3. RIGHT JOIN - a way to pull all of the rows from the table in the JOIN even if they do not exist in the FROM statement.

There are a few more advanced JOINs that we did not cover here, and they are used in very specific use cases. [UNION and UNION ALL](https://www.w3schools.com/sql/sql_union.asp), [CROSS JOIN](http://www.w3resource.com/sql/joins/cross-join.php), and the tricky [SELF JOIN](https://www.w3schools.com/sql/sql_join_self.asp). These are more advanced than this course will cover, but it is useful to be aware that they exist, as they are useful in special cases.

### Recap Alias

You learned that you can alias tables and columns using AS or not using it. This allows you to be more efficient in the number of characters you need to write, while at the same time you can assure that your column headings are informative of the data in your table.

### Looking Ahead

The next lesson is aimed at aggregating data. You have already learned a ton, but SQL might still feel a bit disconnected from statistics and using Excel like platforms. Aggregations will allow you to write SQL code that will allow for more complex queries, which assist in answering questions like:

* Which channel generated more revenue?
* Which account had an order with the most items?
* Which sales_rep had the most orders? or least orders? How many orders did they have?
