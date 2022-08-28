
		----#1 Shippers----
select*from sales.Shippers
select*from Northwind.dbo.Shippers

	set identity_insert sales.shippers on;
	insert into Sales.shippers(Ship_ID,Ship_Name,Ship_Phone)
	select ShipperID,CompanyName,Phone from Northwind.dbo.Shippers
	set identity_insert sales.shippers off;


--#2 Suppliers
	select*from sales.Suppliers
	select*from Northwind.dbo.Suppliers
	delete from sales.Suppliers
	DBCC CHECKIDENT ('sales.suppliers',RESEED,0);
GO
	
	

	alter table sales.suppliers drop constraint supr_location_id

	set identity_insert sales.suppliers on ;
	insert into sales.suppliers(SupR_ID,Supr_Name,Supr_Contact_Name,Supr_City)
	select SupplierID,CompanyName,ContactName,City from Northwind.dbo.Suppliers
	set identity_insert sales.suppliers off;

	

--#3 Products


select*from sales.products
select*from Northwind.dbo.Products
delete from sales.products
	DBCC CHECKIDENT ('sales.products',RESEED,0);
GO
	

set identity_insert sales.Products on;
insert into sales.Products (prod_id,prod_name,prod_quantity,prod_price,prod_in_stock,prod_on_order,prod_reorder_level,prod_discountinued,prod_cate_id,prod_supr_id)
select ProductID,ProductName,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued,CategoryID,SupplierID
 from Northwind.dbo.Products
set identity_insert sales.products off;


---#4 Order
create table sales.Orders(
order_id int identity (1,1) constraint order_id_pk primary key,
order_date datetime,
order_required_date datetime,
order_shipped_date datetime,
order_freight money,
order_subtotal money,
order_total_qty smallint,
order_ship_city nvarchar (25),
order_ship_address nvarchar(60),
order_status nvarchar (25), 
order_employee_id int,
order_cust_id int,
order_ship_id int,
constraint order_employee_id_fk foreign key(order_employee_id) references hr.employees (employee_id),
constraint order_cust_id_fk foreign key (order_cust_id) references sales.costumers (cust_id),
constraint order_ship_id_fk foreign key (order_ship_id) references sales.shippers(ship_id)
);

alter table sales.Orders add employeeid nvarchar (69)

select*from Sales.Orders
select*from Northwind.dbo.Orders
alter table sales.orders add cust nvarchar (69)

set identity_insert sales.Orders on;
insert into sales.orders (order_id,order_date,order_required_date,order_shipped_date,order_freight,order_ship_city,order_ship_address,b_employee_id,cust,order_ship_id)
select OrderID,OrderDate,RequiredDate,ShippedDate,Freight,Shipcity,ShipAddress,EmployeeID,CustomerID,ShipVia
from Northwind.dbo.Orders
set identity_insert sales.orders off; 

create table sales.Orders_detail(
ordet_order_id int,
ordet_prod_id int,
constraint ordet_order_id_prod_id primary key(ordet_order_id,ordet_prod_id),
ordet_price money,
ordet_quantity smallint,
ordet_discount real,
constraint ordet_order_id_fk foreign key (ordet_order_id) references sales.orders (order_id),
constraint ordet_prod_id_fk foreign key (ordet_prod_id) references sales.products(prod_id));

select*from Sales.Orders_Detail
select*from Northwind.dbo.[Order Details]

set identity_insert sales.Orders_detail on;
insert into Sales.Orders_detail(Ordet_order_id,Ordet_Prod_id,Ordet_Price,Ordet_Quantity,Ordet_Discount)
select OrderID,ProductID,UnitPrice,Quantity,Discount
from Northwind.dbo.[Order Details]
set identity_insert sales.Orders_detail off;






					-------------------------------------------
					------------- 17 Agustus 2022--------------
					-------------------------------------------



select*from Northwind.dbo.customers

select*from Northwind.dbo.Orders

select*from hr.employees

select*from Northwind.dbo.Employees

select FirstName,LastName,HireDate,8000 Salary,
CASE	WHEN TITLE='Sales Representative' THEN 'SA_REP'
		WHEN TITLE='Vice President, Sales' THEN 'AD_VP'
		WHEN TITLE='Sales Manager' THEN 'AC_MGR'
		WHEN TITLE='Inside Sales Coordinator' THEN 'SH_CLERK'
	end title
	from Northwind.dbo.Employees

	--alter

	alter table hr.employees add xemp_id int

	---delete

	delete from hr.employees where email is null and phone_number is null and manager_id is null and commission_pct is null

		insert into hr.employees(t.xemp_id,first_name,last_name,hire_date,job_id,department_id,salary)
		select t.*,(select Min_Salary from hr.jobs where job_id=t.title) as salary from (
		select employeeid,FirstName,LastName,DATEADD( Year,20,HireDate) hiredate,
			CASE	WHEN TITLE='Sales Representative' THEN 'SA_REP'
		WHEN TITLE='Vice President, Sales' THEN 'AD_VP'
		WHEN TITLE='Sales Manager' THEN 'AC_MGR'
		WHEN TITLE='Inside Sales Coordinator' THEN 'SH_CLERK'
		end title,
			CASE	WHEN TITLE='Sales Representative' THEN 80
		WHEN TITLE='Vice President, Sales' THEN 90
		WHEN TITLE='Sales Manager' THEN 110
		WHEN TITLE='Inside Sales Coordinator' THEN 50
		end Department
		from Northwind.dbo.Employees) t


		select*from hr.jobs
		select*from sales.Orders


	select order_id,Order_Employee_id,b_employee_id
	from sales.Orders

	-- JOIN ORDERR


	select employee_id,order_id,order_employee_id,b_employee_ID
	from hr.employees e
	join sales.orders o
	on e.xemp_id = o.b_employee_ID

	-- update
	update xx
	set order_employee_id= (select TOP 1 EMPLOYEE_ID
	from hr.employees e join sales.orders o on e.xemp_id = o.b_employee_id and
	o.b_employee_id= xx.b_employee_id)
	from sales.orders as xx

	--update null
	update sales.orders set order_employee_id = null

	--order sales.order dan hr.employee

		select employee_id from hr.employees e join sales.orders on e.xemp_id = o.b_employee_id
		where xemp_id is not null
		order by employee_id

		select*from sales.orders

		update so 
		set order_employee_id =(select distinct employee_id
		from hr.employees e join sales.orders o on e.xemp_id = o.b_employee_id
		where xemp_id is not null and o.b_employee_id =so.b_employee_id)

		from sales.orders so
		
		select EmployeeID, count(*) as total_order
		from Northwind.dbo.Orders
		group by EmployeeID
		order by EmployeeID

		select Order_Employee_ID,b_employee_id, count(*) as total_order
		from sales.orders
		group by Order_Employee_ID, b_employee_id
		order by Order_Employee_ID, b_employee_id

		---Customer
		select*from Northwind.dbo.Customers

			select*from sales.orders
			select*from sales.orders
