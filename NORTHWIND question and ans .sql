-- 1. We need a complete list of our suppliers to update our contact records. Can you pull all the information from the suppliers' table?
use Northwind;

SELECT * FROM suppliers;


-- 2. Our London sales team wants to run a local promotion. Could you get a list of all customers based in London?

SELECT *
FROM Customers
WHERE City = 'London';



-- 3. For our new 'Luxury Items' marketing campaign, I need to know our top 5 most expensive products.

SELECT ProductID,ProductName,Price
FROM Products
ORDER BY Price DESC
LIMIT 5;


-- 4. HR is planning a professional development program for our younger employees. Can you provide a list of all employees born after 1965?
SELECT EmployeeID, FirstName, LastName, BirthDate
FROM Employees
WHERE BirthDate > '1965-12-31'
ORDER BY BirthDate;


-- 5. A customer is asking about our 'Chef' products but can't remember the full name. Can you search for all products that have 'Chef' in their title?
SELECT ProductID,ProductName,Price
FROM Products
WHERE ProductName LIKE '%Chef%';

-- 6. We need a report that shows every order and which customer placed it. Can you combine the order information with the customer's name?
select * from customers;
select * from orders;

SELECT 
	o.orderID,o.orderDate,c.CustomerID, c.CustomerName, c.contactName , address 
    from orders o
    inner join customers c 
    on o.customerID = c.customerID 
    order by o.orderID desc;



-- 7. To organize our inventory, please create a list that shows each product and the name of the category it belongs to.
select * from categories; 
select * from products;
select p.productName , p.categoryId , categoryName 
from products p 
join categories c 
on 
c.categoryID = p.categoryID;



-- 8. We want to promote products sourced from the USA. Can you list all products provided by suppliers located in the USA?
select * from products;
select * from suppliers;
select p.productName, s.country 
from products p 
join suppliers s 
on 
p.supplierID = s.supplierID 
where s.country= 'usa';





-- 9. A customer has a query about their order. We need to know which employee was responsible for it. 
-- Can you create a list of orders with the corresponding employee's first and last name?
SELECT 
    o.OrderID,
    o.OrderDate,
    e.EmployeeID,
    e.FirstName,
    e.LastName
FROM Orders o
JOIN Employees e 
    ON o.EmployeeID = e.EmployeeID
ORDER BY o.OrderID;





-- 10. To help with our international marketing strategy, 
-- I need a count of how many customers we have in each country, sorted from most to least.
select* from customers;
SELECT 
    Country,
    COUNT(CustomerID) AS CustomerCount
FROM Customers
GROUP BY Country
ORDER BY CustomerCount DESC;





-- 11. Let's analyze our pricing. What is the average product price within each product category?

SELECT c.CategoryName,
    ROUND(AVG(p.Price), 2) AS AvgPrice
FROM Products p
JOIN Categories c 
ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY AvgPrice DESC;



-- 12. For our annual performance review, can you show the total number of orders handled by each employee?

SELECT e.EmployeeID,e.FirstName,
    e.LastName,
COUNT(o.OrderID) AS TotalOrders
FROM Employees e
JOIN Orders o 
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalOrders DESC;



-- 13. We want to identify our key suppliers. 
-- Can you list the suppliers who provide us with more than three products?

SELECT s.SupplierID,s.SupplierName,
COUNT(p.ProductID) AS ProductCount
FROM Suppliers s
JOIN Products p 
ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.SupplierName
HAVING COUNT(p.ProductID) > 3
ORDER BY ProductCount DESC;


-- 14. Finance team needs to know the total revenue for order 10250.
SELECT od.OrderID,
SUM(od.Quantity * p.Price) as Total_price
FROM OrderDetails od
join products p
on
od.productID= p.productID
WHERE od.orderID = 10250
GROUP BY od.orderID;




-- 15. What are our most popular products? I need a list of the top 5 products based on the total quantity sold across all orders.

SELECT 
    *
FROM
    orderdetails;

SELECT 
    p.productname, SUM(od.quantity) AS total_quantity_sold
FROM
    products p
        JOIN
    orderdetails od ON p.productid = od.productid
GROUP BY p.productname
ORDER BY total_quantity_sold DESC
LIMIT 5;




-- 16. To negotiate our shipping contracts, we need to know which shipping company we use the most. 
-- Can you count the number of orders handled by each shipper?

select s.shipperName,count(o.orderid) as total_orders_shipped
from shippers s 
join orders o
on
s.shipperID = o.shipperID
group by s.shipperName
order by total_orders_shipped desc;



-- 17. Who are our top-performing salespeople in terms of revenue? 
-- Please calculate the total sales amount for each employee.
select concat(e.firstname,' ',e.lastname) as full_emp_name , 
sum(od.quantity*p.price) as total_revenue 
from products p
 join orderdetails od
 on p.ProductID = od.ProductID 
 join orders o on o.orderid = od.orderid
 join employees e on e.employeeid = o.employeeid
 group by full_emp_name
 order by total_revenue
 desc;



-- 18. We are running a promotion on our 'Chais' tea. 
-- I need a list of all customers who have purchased this product before so we can send them a notification.

select distinct c.customerid, c.customername,p.productname 
from products p
 join orderdetails od 
 on od.productid=p.productid 
 join orders o on o.orderid=od.orderid 
 join customers c on c.customerid=o.customerid 
 where p.productname='chais';

-- 19. Which product categories are the most profitable? I need a report showing the total revenue generated by each category.
select ct.categoryid, ct.categoryname,
sum(od.quantity*p.price) as total_revenue 
from products p
 join orderdetails od on p.productid=od.productid 
 join categories ct on ct.categoryid=p.categoryid 
 group by categoryname,categoryid 
 order by total_revenue desc;


-- 20. We want to start a loyalty program for our most frequent customers. Can you find all customers who have placed more than 5 orders?
SELECT CustomerID,
    COUNT(OrderID) AS TotalOrders
from Orders
group by CustomerID
having COUNT(OrderID) > 5;


