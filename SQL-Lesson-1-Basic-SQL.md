# Basic SQL

Note Information:
* Note created by MaxineMann
* Resources provided by Udacity
* All queries are stored in the SQL file ([SQL-Lesson-1-Basic-SQL.sql](https://github.com/MaxineMann/SQL-Learning-Note/blob/master/SQL-Lesson-1-Basic-SQL.sql))

Table of Contents
==============
   * [Basic SQL](Basic-SQL)
   * [Table of Contents](Table-of-Contents)
      * [Entity Relationship Diagrams](Entity-Relationship-Diagrams)
         * [What to Notice](What-to-Notice)
         * [ERD Fundamentals](ERD-Fundamentals)
      * [Indroduction to SQL]()
         * [Why Do Data Analysts Use SQL?]()
            * [SQL vs. NoSQL]()
         * [Why Do Businesses Choose SQL?]()
            * [Why Businesses Like Databases]()
      * [Types of Database]()
         * [SQL Databases]()
         * [Small Differences]()
      * [Types of Statements]()
      * [Formatting Your Queries]()
         * [Capitalization]()
         * [Avoid Spaces in Table and Variable Names]()
         * [Use White Space in Queries]()
         * [SQL isn't Case Sensitive]()
         * [Semicolons]()
      * [Basic Statement]()
         * [SELECT &amp; FROM]()
         * [LIMIT]()
         * [ORDER BY]()
         * [WHERE]()
            * [Comparison Operators]()
         * [Derived Columns]()
            * [Order of Operations]()
      * [Logical Operators]()
         * [LIKE]()
            * [LIKE Practice]()
         * [IN]()
            * [IN Practice]()
         * [NOT]()
            * [NOT Practice]()
         * [AND &amp; BETWEEN]()
            * [AND &amp; BETWEEN Pratice]()
         * [OR]()
            * [OR Practice]()
      * [Recap]()
         * [Command]()
         * [Other Tips]()

## Entity Relationship Diagrams

An **entity relationship diagram** (ERD) is a common way to view data in a database. Below is the ERD for the database we will use from Parch & Posey. These diagrams help you visualize the data you are analyzing including:

1. The names of the tables.
2. The columns in each table.
3. The way the tables work together.

*You can think of each of the boxes below as a spreadsheet.*

[Pic]

*Note: glossy_qty is incorrect, it is actually gloss_qty in the database*

### What to Notice

In the Parch & Posey database there are five tables (essentially 5 spreadsheets):

1. web_events
2. accounts
3. orders
4. sales_reps
5. region

You can think of each of these tables as an individual spreadsheet. Then the columns in each spreadsheet are listed below the table name. For example, the **region** table has two columns: `id` and `name`. Alternatively the **web_events** table has four columns.

[pic]

The "crow's foot" that connects the tables together shows us how the columns in one table relate to the columns in another table.  In this first lesson, you will be learning the basics of how to work with SQL to interact with a single table.  In the next lesson, you will learn more about why these connections are so important for working with SQL and relational databases.

### ERD Fundamentals

* **primary_poc**: A column name in the Parch & Posey database.
* **web_events**: A table name in the Parch & Posey database.
* **Database**: A collection of tables that share connected data stored in a computer.
* **ERD**: A diagram that shows how data is structured in a database.
* **SQL**: A language that allows us to access data stored in a database.

## Indroduction to SQL

Before we dive into writing **Structured Query Language** (SQL) queries, let's take a look at what makes SQL and the databases that utilize SQL so popular.

I think it is an important distinction to say that SQL is a **language**. Hence, the last word of SQ**L** being **language**. SQL is used all over the place beyond the databases we will utilize in this class. With that being said, SQL is most popular for its interaction with databases. For this class, you can think of a **database** as a bunch of excel spreadsheets all sitting in one place. Not all databases are a bunch of excel spreadsheets sitting in one place, but it is a reasonable idea for this class.

### Why Do Data Analysts Use SQL?

There are some major advantages to using **traditional relational databases**, which we interact with using SQL. The five most apparent are:

- SQL is easy to understand.
- Traditional databases allow us to access data directly.
- Traditional databases allow us to audit and replicate our data.
- SQL is a great tool for analyzing multiple tables at once.
- SQL allows you to analyze more complex questions than dashboard tools like Google Analytics.

You will experience these advantages first hand, as we learn to write SQL to interact with data.

I realize you might be getting a little nervous or anxious to start writing code. This might even be the first time you have written in any sort of programming language. I assure you, we will work through examples to help assure you feel supported the whole time to take on this new challenge!

#### SQL vs. NoSQL

You may have heard of NoSQL, which stands for not only SQL. Databases using NoSQL allow for you to write code that interacts with the data a bit differently than what we will do in this course. These NoSQL environments tend to be particularly popular for <u>web based data</u>, but less popular for data that lives in spreadsheets the way we have been analyzing data up to this point. One of the most popular NoSQL languages is called MongoDB. Udacity has a full course on [MongoDB](https://www.mongodb.com/) that you can take for free [here](https://www.udacity.com/course/data-wrangling-with-mongodb--ud032), but these will not be a focus of this program.

NoSQL is not a focus of analyzing data in this Nanodegree program, but you might see it referenced outside this course!

### Why Do Businesses Choose SQL?

#### Why Businesses Like Databases

1. **Data integrity is ensured** - only the data you want entered is entered, and only certain users are able to enter data into the database. 
2. **Data can be accessed quickly** - SQL allows you to obtain results very quickly from the data stored in a database. Code can be optimized to quickly pull results.
3. **Data is easily shared** - multiple individuals can access data stored in a database, and the data is the same for all users allowing for consistent results for anyone with access to your database.

A few key points about data stored in SQL databases:

1. **Data in databases is stored in tables that can be thought of just like Excel spreadsheets.**
For the most part, you can think of a database as a bunch of Excel spreadsheets. Each spreadsheet has rows and columns. Where each row holds data on a transaction, a person, a company, etc., while each column holds data pertaining to a particular aspect of one of the rows you care about like a name, location, a unique id, etc.

2. **All the data in the same column must match in terms of data type.** 
An entire column is considered quantitative, discrete, or as some sort of string. This means if you have one row with a string in a particular column, the entire column might change to a text data type. This can be very bad if you want to do math with this column!

3. **Consistent column types are one of the main reasons working with databases is fast.**
Often databases hold a LOT of data. So, knowing that the columns are all of the same type of data means that obtaining data from a database can still be fast.

## Types of Database

### SQL Databases

There are many different types of SQL databases designed for different purposes. In this course we will use [Postgres](https://www.postgresql.org/) within the classroom, which is a popular open-source database with a very complete library of analytical functions.

Some of the most popular databases include:

* MySQL
* Access
* Oracle
* Microsoft SQL Server
* Postgres

You can also write SQL within other programming frameworks like Python, Scala, and HaDoop.

### Small Differences

Each of these SQL databases may have subtle differences in syntax and available functions -- for example, MySQL doesn’t have some of the functions for modifying dates as [Postgres](https://www.postgresql.org/). Most of what you see with Postgres will be directly applicable to using SQL in other frameworks and database environments. For the differences that do exist, you should check the documentation. Most SQL environments have great documentation online that you can easily access with a quick Google search.

The article [here](https://www.digitalocean.com/community/tutorials/sqlite-vs-mysql-vs-postgresql-a-comparison-of-relational-database-management-systems) compares three of the most common types of SQL: SQLite, PostgreSQL, and MySQL. Again, once you have learned how to write SQL in one environment, the skills are mostly transferable.

## Types of Statements

The key to SQL is understanding **statements**: tell the database what you'd like to do with the data. 

>SQL statements are code that can read and manipulate data. Basic syntax reminders: SQL isn't case sensitive - meaning you can write upper and lower case anywhere in the code. Additionally, you can end SQL statements with a semicolon, but some SQL environments don't require a semicolon at the end.

A few statements include:

1. **CREATE TABLE** is a statement that creates a new table in a database.
2. **DROP TABLE** is a statement that removes a table in a database.
3. **SELECT** allows you to read data and display it. This is called a **query**.

The **SELECT** statement is the common statement used by analysts. We will be using the SELECT statement, which is called a query. The DROP and CREATE statements actually change the data in the database. In most companies, analysts are not given permission to use these types of statements. This a good thing - ACTUALLY changing the data in the database is a powerful thing. This is generally reserved for database administrators exclusively.

## Formatting Your Queries

### Capitalization

You may have noticed that we have been capitalizing SELECT and FROM, while we leave table and column names lowercase. This is a common formatting convention. It is common practice to capitalize commands (SELECT, FROM), and keep everything else in your query lowercase. This makes queries easier to read, which will matter more as you write more complex queries. For now, it is just a good habit to start getting into.

### Avoid Spaces in Table and Variable Names
It is common to use underscores and avoid spaces in column names. It is a bit annoying to work with spaces in SQL. In Postgres if you have spaces in column or table names, you need to refer to these columns/tables with double quotes around them (Ex: FROM "Table Name" as opposed to FROM table_name). In other environments, you might see this as square brackets instead (Ex: FROM [Table Name]).

### Use White Space in Queries
SQL queries ignore spaces, so you can add as many spaces and blank lines between code as you want, and the queries are the same. This query

```
SELECT account_id FROM orders
```

is equivalent to this query:

```
SELECT account_id
    FROM orders
```

and this query (but please don't ever write queries like this):

```
SELECT     account_id
    FROM      orders
```

### SQL isn't Case Sensitive

If you have programmed in other languages, you might be familiar with programming languages that get very upset if you do not type the correct characters in terms of lower and uppercase. SQL is not case sensitive. The following query:

```
SELECT account_id
    FROM orders
```

is the same as:

```
select account_id
    from orders
```

which is also the same as:

```
selEct account_id
    fRom orders
```

However, I would again urge you to follow the conventions outlined earlier in terms of fully capitalizing the commands, while leaving other pieces of your code in lowercase.

### Semicolons

Depending on your SQL environment, your query may need a semicolon at the end to execute. Other environments are more flexible in terms of this being a "requirement." It is considered best practices to put a semicolon at the end of each statement, which also allows you to run multiple commands at once if your environment is able to show multiple results at once.

Best practice:

```
select account_id
    from orders;
```

Since, our environment here doesn't require it, you will see solutions written without the semicolon:

```
select account_id
    from orders;
```

## Basic Statement

### SELECT & FROM

* SELECT indicates which column(s) you want to be given the data for (filling out a form to get a set of results)
* FROM specifies from which table(s) you want to select the columns. Notice the columns need to exist in this table.

These questions are structured in the same order every time:
* What data do you want to pull from?
* Which elements from the database do you want to pull?

If you want to be provided with the data from all columns in the table, you use " * ", like so:

```
SELECT *
    FROM demo.orders
```

```
SELECT id, occurred.id
    FROM demo.orders
```

Note that using SELECT does not create a new table with these columns in the database, it just provides the data to you as the output of this command.

You will use this SQL SELECT statement in every query in this course, but you will be learning a few additional statements and operators that can be used along with them to ask more advanced questions of your data.


### LIMIT

The **LIMIT** statement is useful when you want to see just the first few rows of a table. This can be much faster for loading than if we load the entire dataset.

The **LIMIT** command is always the very last part of a query. An example of showing just the first 10 rows of the orders table with all of the columns might look like the following:

```
SELECT *
FROM orders
LIMIT 10;
```

### ORDER BY

The **ORDER BY** statement allows us to order our table by any row. If you are familiar with Excel, this is similar to the sorting you can do with filters.

The **ORDER BY** statement is always after the **SELECT** and **FROM** statements, but it is before the **LIMIT** statement. As you learn additional commands, the order of these statements will matter more. If we are using the **LIMIT** statement, it will always appear last.

Remember `DESC` can be added after the column in your **ORDER BY** statement to sort in descending order, as the default is to sort in ascending order, such A to Z(string), lowest to highest(number), earlist to latest(date) 

```
SELECT *
FROM orders
ORDER BY occured.id DESC
LIMIT 10;
```

We can **ORDER BY** more than one column at a time. The statement sorts according to columns listed from left first and those listed on the right after that. We still have the ability to flip the way we order using `DESC`.

### WHERE

`WHERE`: To filter a set of result based on specific criteria

Using the **WHERE** statement, we can subset out tables based on conditions that must be met. It goes after **SELECT** and **FROM** but before **ORDER BY** or **LIMIT**. 

#### Comparison Operators

`Comparison Operators`: Include =, !=, >, and < as well as other tools for comparing clolumns/values. 

Common symbols used within **WHERE** statements include:

* `>` (greater than)
* `<` (less than)
* `>=` (greater than or equal to)
* `<=` (less than or equal to)
* `=` (equal to)
* `!=` (not equal to)

The **WHERE** statement can also be used with non-numerical data. We can use the `=` and `!=` operators here. You also need to be sure to use single quotes (just be careful if you have quotes in the original text) with the text data.

Commonly when we are using WHERE with non-numeric data fields, we use the **LIKE**, **NOT**, or **IN** operators.

### Derived Columns

`Drived Column`: A new column that is a manipulation of the existing columns in your database. Common operators include:

* `*` (Multiplication)
* `+` (Addition)
* `-` (Subtraction)
* `/` (Division)

#### Order of Operations

Remember [PEMDAS](http://www.purplemath.com/modules/orderops.htm) from math class? If not, check out this link as a reminder. The same order of operations apply when using **arithmetic operators** in SQL.

The following two statements have very different end results:

1. standard_qty / standard_qty + gloss_qty + poster_qty
2. standard_qty / (standard_qty + gloss_qty + poster_qty)

It is likely the case you mean to calculate the statement in part 2.

## Logical Operators
In the next concepts, you will be learning about **Logical Operators**. 

Logical Operators include:

1. **LIKE**: This allows you to perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for.

2. **IN**: This allows you to perform operations similar to using WHERE and =, but for more than one condition.

3. **NOT**: This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.

4. **AND & BETWEEN**: These allow you to combine operations where all combined conditions must be true.

5. **OR**: This allow you to combine operations where at least one of the combined conditions must be true.

### LIKE

The **LIKE** operator is extremely useful for working with text. You will use **LIKE** within a **WHERE** clause.

The **LIKE** operator is frequently used with `%`. The `%` tells us that we might want any number of characters leading up to a particular set of characters or following a certain set of characters.

You will need to use **single quotes** for the text you pass to the LIKE operator, because of this lower and uppercase letters are not the same within the string. Searching for '**T**' is not the same as searching for '**t**'. In other SQL environments (outside the classroom), you can use either single or double quotes.

#### LIKE Practice

1. All the companies whose names start with 'C'.
```
SELECT *
FROM accounts
WHERE name LIKE 'C%';
```

2. All companies whose names contain the string 'one' somewhere in the name.
```
SELECT *
FROM accounts
WHERE name LIKE '%one%';
```

3. All companies whose names end with 's'. 
```
SELECT name
FROM accounts
WHERE name LIKE '%s';
```
### IN

`IN`: To filter data based on several possible values

The **IN** operator is useful for working with both numeric and text columns. This operator allows you to use an `=`, but for more than one item of that particular column. We can check one, two or many column values for which we want to pull data, but all within the same query. You can put as many values as you want inside these parentheses bu have to put a comma in between each pair of distinct values

In the upcoming concepts, you will see the **OR** operator that would also allow us to perform these tasks, but the **IN** operator is a cleaner way to write these queries.

In most SQL environments, you can use single or double quotation marks - and you may NEED to use double quotation marks if you have an apostrophe within the text you are attempting to pull. In the work spaces in the classroom, note you can include an apostrophe by putting two single quotes together. Example Macy's in our work space would be 'Macy''s'.

#### IN Practice 

1. Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
```
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');
```

2. Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
```
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');
```

### NOT

`NOT`: To provides the inverse results for IN, LIKE, and similar operators

The **NOT** operator is an extremely useful operator for working with the previous two operators we introduced: **IN** and **LIKE**. By specifying **NOT LIKE** or **NOT IN**, we can grab all of the rows that do not meet a particular criteria.

#### NOT Practice

1. All the companies whose names do not start with 'C'.
```
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';
```

2. All companies whose names do not contain the string 'one' somewhere in the name.
```
SELECT *
FROM accounts
WHERE name NOT LIKE '%one%';
```

3. All companies whose names do not end with 's'.
```
SELECT name
FROM accounts
WHERE name NOT LIKE '%s';
```

4. Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom. 
```
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');
```

5. Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
```
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');
```

### AND & BETWEEN

The **AND** operator is used within a **WHERE** statement to consider more than one logical clause at a time. Each time you link a new statement with an **AND**, you will need to specify the column you are interested in looking at. You may link as many statements as you would like to consider at the same time. This operator works with all of the operations we have seen so far including arithmetic operators (`+`, `*`, `-`, `/`). LIKE, IN, and NOT logic can also be linked together using the AND operator.

Sometimes we can make a cleaner statement using **BETWEEN** than we can using **AND**. Particularly this is true when we are using the same column for different parts of our **AND** statement. In the previous video, we probably should have used BETWEEN. Instead of writing :

`WHERE column >= 6 AND column <= 10`

we can instead write, equivalently:

`WHERE column BETWEEN 6 AND 10`
 
#### AND & BETWEEN Pratice

1. Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
```
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;
```

2. Using the accounts table find all the companies whose names do not start with 'C' and end with 's'.
```
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';
```

3. Use the web_events table to find all information regarding individuals who were contacted via organic or adwords and started their account at any point in 2016 sorted from newest to oldest.
```
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY occurred_at DESC;
```

### OR

Similar to the **AND** operator, the **OR** operator can combine multiple statements. Each time you link a new statement with an **OR**, you will need to specify the column you are interested in looking at. You may link as many statements as you would like to consider at the same time. This operator works with all of the operations we have seen so far including arithmetic operators (`+`, `*`, `-`, `/`). **LIKE**, **IN**, **NOT**, **AND**, and **BETWEEN** logic can also be linked together using the **OR** operator. 

**OR** can be combined with other operators for using parenthesses. When combining multiple of these operations, we frequently might need to use parentheses to assure that logic we want to perform is being executed correctly.

#### OR Practice

1. Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table. */
```
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;
```

2. Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000. */
```
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);
```

3. Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
```
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%';
```

## Recap

### Command


| Statement | How to Use It | Other Details |
| --- | --- | --- |
| `SELECT` | **SELECT** Col1, Col2, ... | Provide the columns you want |
| `FROM` | **FROM** Table | Provide the table where the columns exist |
| `LIMIT` | **LIMIT** 10 | Limits based number of rows returned |
| `ORDER BY` | **ORDER BY** Col | Orders table based on the column. Used with **DESC** |
| `WHERE` | **WHERE** Col > 5 | A conditional statement to filter your results |
| `LIKE` | **WHERE** Col **LIKE** '%me%' | Only pulls rows where column has 'me' within the text |
| `IN` | **WHERE** Col **IN** ('Y', 'N') | A filter for only rows with column of 'Y' or 'N' |
| `NOT` | **WHERE** Col **NOT IN** ('Y', 'N') | NOT is frequently used with LIKE and IN |
| `AND` | **WHERE** Col1 > 5 **AND** Col2 < 3 | Filter rows where two or more conditions must be true |
| `OR` | **WHERE** Col1 > 5 **OR** Col2 < 3 | Filter rows where at least one condition must be true |
| `BETWEEN` | **WHERE** Col **BETWEEN** 3 AND 5 | Often easier syntax than using an AND |

### Other Tips

Though SQL is not case sensitive (it doesn't care if you write your statements as all uppercase or lowercase), we discussed some best practices. The order of the key words does matter. Using what you know so far, you will want to write your statements as:

```
SELECT col1, col2
FROM table1
WHERE col3  > 5 AND col4 LIKE '%os%'
ORDER BY col5
LIMIT 10;
```

Notice, you can retrieve different columns than those being used in the **ORDER BY** and **WHERE** statements. Assuming all of these column names existed in this way (`col1`, `col2`, `col3`, `col4`, `col5`) within a table called `table1`, this query would run just fine.
