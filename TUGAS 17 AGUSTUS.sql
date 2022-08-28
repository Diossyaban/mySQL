			select*from sales.orders
			select*from Northwind.dbo.customers

		--join order
	select cust_id,order_id,order_cust_id,cust
	from sales.costumers e
	join sales.orders o
	on e.cust_code = o.cust

	update ss
	set cust_code =( select CustomerID from Northwind.dbo.Customers
	where CompanyName = ss.cust_name)
	from sales.costumers ss

	select OrderID from Northwind.dbo.Orders
	intersect
	select order_id from sales.Orders

	select cust_id, order_id, cust from sales.costumers c join sales.Orders o
	on c.cust_code = o.cust

	update co
	set order_cust_id =(select distinct c.cust_id
	from sales.Orders o join sales.costumers c
	on o.cust = c.cust_code and o.cust = co.cust)
	from sales.orders co

	select *from sales.Orders_detail
	
	select distinct order_cust_id from sales.Orders