-- Query 1: Calculate the total sales amount for transactions made in the year 2019
SELECT SUM(transactions.sales_amount) 
FROM transactions 
INNER JOIN date 
ON transactions.order_date = date.date 
WHERE date.year = 2019;

-- Query 2: Count the distinct number of products (unique product codes) 
-- sold in transactions where the market code is "Mark001"
SELECT DISTINCT COUNT(product_code) 
FROM transactions 
WHERE market_code = "Mark001";

-- Query 3: Count the number of transactions where the sales amount is less than or equal to 0
SELECT COUNT(sales_amount) AS transaction_count 
FROM sales.transactions 
WHERE sales_amount <= 0;

-- Query 4: Calculate the difference between the total number of transactions 
-- and the number of transactions where the sales amount is less than or equal to 0
SELECT 
    (SELECT COUNT(sales_amount) 
     FROM sales.transactions) -- Count of all transactions
    -
    (SELECT COUNT(sales_amount) 
     FROM sales.transactions 
     WHERE sales_amount <= 0) -- Count of transactions where sales amount <= 0
    AS difference;

-- Query 5: Count the total number of transactions (all rows in the table, assuming sales_amount is not NULL)
SELECT COUNT(sales_amount) 
FROM sales.transactions;


-- Query 6: Problems for my transactions table

SELECT distinct(transactions.currency) FROM transactions ;

SELECT COUNT(transactions.sales_amount) FROM transactions WHERE transactions.currency = "INR\r";

-- Query 7: Sum of tansactions in year 2019

SELECT SUM(transactions.sales_amount) FROM transactions INNER JOIN 
date ON transactions.order_date = date.date
where date.year = 2019 and transactions.currency = "INR\r" or transactions.currency = "USD\r";

-- Query 8: Total revenue (Sum of transactions)  in year 2020, Month january

SELECT SUM(transactions.sales_amount) FROM transactions INNER JOIN
date ON transactions.order_date = date.date 
WHERE date.year = 2020 and date.month_name = "January" and 
((transactions.currency = "INR\r" ) or (transactions.currency = "USD\r"));


-- Query 9: Total revenue in year 2020 of market Chennai


SELECT SUM(transactions.sales_amount) FROM transactions INNER JOIN
date ON transactions.order_date = date.date
WHERE date.year = 2020 and transactions.market_code = "Mark001";

