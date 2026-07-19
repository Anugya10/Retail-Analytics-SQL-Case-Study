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
     select 
          p.category, 
          sum(s.quantitypurchased) as TotalUnitsSold,
          sum(s.price * s.quantitypurchased) as TotalSales
     from Sales_transaction s
     join product_inventory p 
          on s.productid = p.productid
     group by p.category
     order by TotalSales desc;

--8. Write a SQL query to find the top 10 products with the highest total sales revenue from the sales transactions. 
--   This will help the company to identify the high-sales products which needs to be focused to increase the revenue of the company.
     select
          ProductID,
          sum(price * Quantitypurchased) as TotalRevenue
     from Sales_transaction
     group by ProductID
     order by TotalRevenue desc
     limit 10;

--9. Write a SQL query to find the ten products with the least amount of units sold from the sales transactions, 
--   provided that at least one unit was sold for those products.
     select 
          ProductID,
          sum(QuantityPurchased) as TotalUnitsSold 
     from Sales_transaction
     group by ProductID
     having sum(QuantityPurchased) > 0
     order by TotalUnitsSold asc
     limit 10;

--10. Write a SQL query to identify the sales trend to understand the revenue pattern of the company.
      select 
           TransactionDate as DateTrans,
           count(transactionID) as Transaction_count,
           sum(quantitypurchased) as TotalUnitsSold,
           round(sum(price * quantitypurchased),2) as TotalSales
      from sales_transaction
      group by TransactionDate
      order by DateTrans desc;

--11. Write a SQL query to understand the month-on-month growth rate of sales of the company, which will help understand the growth trend of the company.
      With CTE as (
            select 
               month(transactiondate) as month,
               round(sum(price * quantitypurchased),2) as Total_Sales,
               lag(
                  round(sum(price * quantitypurchased),2)) 
                  over(order by month(transactiondate)) as previous_month_sales
            from sales_transaction
            group by month(transactiondate)
      )
      select 
           month,
           Total_Sales,
           previous_month_sales,
           round(
              (Total_Sales - previous_month_sales) / 
               previous_month_sales *100, 2) as mom_growth_percentage
     from CTE
     order by month asc;

--12. Write a SQL query that describes the number of transactions along with the total amount spent by each customer which are on the higher side 
--    and will help us understand the customers who are high-frequency purchase customers in the company.
      select 
           CustomerID,
           count(TransactionID) as NumberofTransactions,
           sum(price * quantitypurchased) as TotalSpent
     from sales_transaction
     group by CustomerID
     having count(TransactionID) > 10 
        and sum(price * quantitypurchased) > 1000
     order by TotalSpent desc;

--13. Write a SQL query that describes the number of transactions along with the total amount spent by each customer, 
--    which will help us understand the customers who are occasional customers or have low purchase frequency in the company.
      select 
           CustomerID,
           count(TransactionID) as NumberofTransactions,
           sum(price * quantitypurchased) as TotalSpent
      from sales_transaction
      group by CustomerID
      having count(TransactionID) <= 2 
      order by NumberofTransactions asc, TotalSpent desc;

--14. Write a SQL query that describes the total number of purchases made by each customer against each productID 
--    to understand the repeat customers in the company.
      select
           CustomerID,
           ProductID,
           count(*) as TimesPurchased 
      from Sales_transaction
      group by CustomerID, ProductID
      having count(*) > 1
      order by TimesPurchased desc;

--15. Write a SQL query that describes the duration between the first and the last purchase of the customer in that particular company to understand 
--    the loyalty of the customer.
      select 
           CustomerID,
           min(transactionDate_updated) as FirstPurchase,
           max(transactionDate_updated) as LastPurchase,
           datediff(
                max(transactionDate_updated), 
                min(transactionDate_updated)
           ) as DaysBetweenPurchases
      from Sales_transaction 
      group by CustomerID
      having DaysBetweenPurchases > 0
      Order by DaysBetweenPurchases desc;

--16. Write an SQL query that segments customers based on the total quantity of products they have purchased. 
--    Also, count the number of customers in each segment, which will help us target a particular segment for marketing.
      create table customer_segment as
      select
           cp.customerid,
           coalesce(sum(st.quantitypurchased),0) AS total_quantity,
      case
        when coalesce(sum(st.quantitypurchased),0) = 0 then 'None'
        when coalesce(sum(st.quantitypurchased),0) between 1 and 10 then 'Low'
        when coalesce(sum(st.quantitypurchased),0) between 11 and 30 then 'Med'
        else 'High'
      end as customersegment
      from customer_profiles cp
      left join sales_transaction st
        on cp.customerid = st.customerid
      group by cp.customerid;

      select 
           CustomerSegment,
           Count(*)
      from customer_segment
      where customersegment <> 'None'
      group by CustomerSegment;
