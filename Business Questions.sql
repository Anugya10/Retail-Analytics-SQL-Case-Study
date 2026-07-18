--1. Write a query to identify the number of duplicates in the "sales_transaction" table. 
--   Also, create a separate table containing the unique values, remove the original table from the database, 
--   and replace the name of the new table with the original name.
     select 
       transactionID, 
       count(*) 
     from sales_transaction
     group by TransactionID
     having count(*) > 1;

     create table sales_transaction_new
     select distinct *
     from sales_transaction;

     drop table sales_transaction;

     alter table sales_transaction_new
     rename to sales_transaction;

     select * from sales_transaction;

--2. Write a query to identify the discrepancies in the price of the same product in the "sales_transaction" and "product_inventory" tables. 
--   Also, update those discrepancies to match the price in both tables.
     -- 1. Identify discrepancies (before update)
           SELECT 
              s.TransactionID,
              s.price AS TransactionPrice,
              p.price AS InventoryPrice
           FROM sales_transaction s
           JOIN product_inventory p ON s.productID = p.productID
           WHERE s.price <> p.price;

     -- 2. Temporarily allow updates without a WHERE key
           SET sql_safe_updates = 0;

     -- 3. Update the sales_transaction prices to match product_inventory
           UPDATE sales_transaction s
           JOIN product_inventory p ON s.productID = p.productID
           SET s.price = p.price
           WHERE s.price <> p.price;

     -- 4. Verify all prices match after the update
           SELECT * from sales_transaction;

--3. Write a SQL query to identify the null values in the dataset and replace those with “Unknown”.
      --1. Identify the NULL in the dataset
           select 
                count(*) 
           from customer_profiles
           where location is null;

      --2. Update NULL with Unknown
           update customer_profiles
           set location = 'Unknown'
           where location is null;

      --3. Verify the updates
           select * from customer_profiles;

--4. Write a SQL query to clean the DATE column in the dataset.
--   Steps:
--     Create a separate table and change the data type of the DATE column, as it is in TEXT format, and name it as you wish to.
--     Remove the original table from the database.
--     Change the name of the new table and replace it with the original name of the table.
     --1. Create a new table and add a new column
          Create table sales_transaction_new as
          select *,
             cast(TransactionDate as date) as TransactionDate_updated
          from sales_transaction;

     --2. Drop the old table
          drop table sales_transaction;

     --3. Rename the new table with the old table name
          alter table sales_transaction_new
          rename to sales_transaction;

     --4. Verify the updates
          select * from sales_transaction;

--5. Write a SQL query to summarize the total sales and quantities sold per product by the company.
     select 
          ProductID,
          sum(QuantityPurchased) as TotalUnitsSold,
          sum(price* QuantityPurchased) as TotalSales
     from sales_transaction
     group by ProductID
     order by TotalSales desc;

--6. Write a SQL query to count the number of transactions per customer to understand purchase frequency.
     select 
          CustomerID,
          count(TransactionID) as NumberOfTransactions 
     from Sales_transaction
     group by CustomerID
     order by NumberOfTransactions desc;

--7. Write a SQL query to evaluate the performance of the product categories based on the total sales, 
--   which helps us understand the product categories need to be promoted in the marketing campaigns.

--8. Write a SQL query to find the top 10 products with the highest total sales revenue from the sales transactions. 
--   This will help the company to identify the high-sales products which needs to be focused to increase the revenue of the company.

--9. Write a SQL query to find the ten products with the least amount of units sold from the sales transactions, 
--   provided that at least one unit was sold for those products.

--10. Write a SQL query to identify the sales trend to understand the revenue pattern of the company.

--11. Write a SQL query to understand the month-on-month growth rate of sales of the company, which will help understand the growth trend of the company.

--12. Write a SQL query that describes the number of transactions along with the total amount spent by each customer which are on the higher side 
--    and will help us understand the customers who are high-frequency purchase customers in the company.

--13. Write a SQL query that describes the number of transactions along with the total amount spent by each customer, 
--    which will help us understand the customers who are occasional customers or have low purchase frequency in the company.

--14. Write a SQL query that describes the total number of purchases made by each customer against each productID 
--    to understand the repeat customers in the company.

--15. Write a SQL query that describes the duration between the first and the last purchase of the customer in that particular company to understand 
--    the loyalty of the customer.

--16. Write an SQL query that segments customers based on the total quantity of products they have purchased. 
--    Also, count the number of customers in each segment, which will help us target a particular segment for marketing.

