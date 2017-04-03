--Write a query to return all category names with their descriptions from the Categories table.
select CategoryName, Description
from Categories;

--Write a query to return the contact name, customer id, company name and city name of all Customers in London
select ContactName, CustomerID, CompanyName, City 
from Customers 
where City= 'London';
--Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
select SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage
from Suppliers 
where (ContactTitle= 'Marketing Manager' OR ContactTitle='Sales Representative') AND NOT Fax='NULL';

--Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units.
select CustomerId , RequiredDate
from Orders
where RequiredDate between 'Jan 1, 1997' And 'Dec 31,1997' And Freight<100;
--Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.
select CompanyName, ContactName 
from Customers
where Country ='Mexico' OR Country='Sweden' OR Country='Germany';
--Write a query to return a count of the number of discontinued products in the Products table.
select count(*) as NumberDiscontinued
from Products
where Discontinued = 1;
--Write a query to return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
select CategoryName, Description 
from Categories 
where CategoryName like 'Co%';
--Write a query to return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
select CompanyName, City, Country, PostalCode
from Suppliers
where Address like '%rue%'
order by CompanyName;
--Write a query to return the product id and the quantity ordered for each product labelled as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.
select ProductID, Quantity as [Quantity Purchased]
from [Order Details]
order by [Quantity Purchased] desc;
--Write a query to return the company name, address, city, postal code and country of all customers with orders that shipped using Speedy Express, along with the date that the order was made.
select Customers.CompanyName, Address, City, PostalCode, Country, OrderDate
from Customers join Orders on Customers.CustomerID=Orders.CustomerID join Shippers on  Orders.ShipVia= Shippers.ShipperID
where Shippers.CompanyName='Speedy Express'; 

--Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.
select Suppliers.CompanyName, Suppliers.ContactName, Suppliers.ContactTitle, Region.RegionID
from Suppliers 
	join Products on Suppliers.SupplierID=Products.SupplierID 
	join [Order Details] on [Order Details].ProductID=Products.ProductID
	join Orders on [Order Details].OrderID= Orders.OrderID
	join Employees on Employees.EmployeeID= Orders.EmployeeID
	join EmployeeTerritories on Employees.EmployeeID=EmployeeTerritories.EmployeeID
	join Territories on Territories.TerritoryID= EmployeeTerritories.TerritoryID
	join Region on Region.RegionID = Territories.RegionID;


--Write a query to return all product names from the Products table that are condiments.
select ProductName
from Products join Categories on Products.CategoryID=Categories.CategoryID
where Description like 'condiments';
--Write a query to return a list of customer names who have no orders in the Orders table.
select CompanyName 
from Customers
where CustomerID NOT IN (select CustomerID from Orders);
--Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.
--Insert into Shippers (CompanyName)
--Values ('Amazon');
--Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
--update Shippers
--set CompanyName='Amazon Prime Shipping'
--where CompanyName = 'Amazon';
--Write a query to return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
select CompanyName, Round(AVG(Freight),0)
from Shippers left join Orders on Shippers.ShipperID=Orders.ShipVia
group by CompanyName
--Write a query to return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
select CONCAT(LastName, ', ', FirstName) as DisplayName
from Employees;
--Write a query to add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
insert into Customers(ContactName)
values ('Tyler Austgen');
insert into  Orders(CustomerID)
values ((select CustomerID from Customers where CompanyName='Tyler Austgen'));
insert into [Order Details](OrderID,ProductID)
values ((select OrderID from Orders join Customers on Customers.CustomerID=Orders.CustomerID where CompanyName ='Tyler Austgen'), (select ProductID from Products where ProductName='Grandma''s Boysenberry Spread'))

--Write a query to remove yourself and your order from the database.
delete [Order Details] where OrderID=(select OrderID from Orders join Customers on Customers.CustomerID=Orders.CustomerID where CompanyName ='Tyler Austgen');
delete Orders where CustomerID=(select CustomerID from Customers where CompanyName='Tyler Austgen');
delete Customers where CompanyName='Tyler Austgen';
--Write a query to return a list of products from the Products table along with the total units in stock for each product. Include only products with TotalUnits greater than 100.
select ProductName, UnitsInStock from Products where UnitsInStock>100;