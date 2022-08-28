select*from sales.costumers
select*from Northwind.dbo.Customers
select*from Northwind.dbo.Orders
select*from CompanyName,City,CostumerID From Nortwind.dbo.Costumers

--alter table sales.customer // Menambahkan Table
alter table sales.costumers add cust_code nchar (5)

--Migrate data from nortwind.dbo.costumer into sales.costumer // Migrasi data 
insert into sales.costumers(cust_name,cust_city,cust_code)
select CompanyName,City,CustomerID From Northwind.dbo.Customers

--menggunakan merge into
select*from sales.costumers
delete*from sales.costumers

--resert seed
DBCC CHECKIDENT ('sales.categories',RESEED,0);

merge into sales.costumers as tg
using (select CompanyName,City,CustomerID from Northwind.dbo.Customers)src
on tg.cust_code=src.customerid
when matched then
	update set cust_name = src.companyName
when not matched then
	insert (cust_name,cust_city,cust_code)
	values (src.companyname,src.city,src.customerid);

	select*from sales.costumers