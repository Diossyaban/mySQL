									------------------------ 18 AGUSTUS 20220-----------------------------
									----------------------------------------------------------------------

				select*from sales.categories
				select*from sales.costumers
				select*from sales.products
				select*from sales.Orders
				select*from sales.Orders_detail
				select*from sales.suppliers
				select*from sales.shippers

		-----------------Range date-----------------

				select*
				from sales.Orders
				where order_date between '1996-07-05' and '1996-07-09'

		-----------------Pagination-----------------

				select*from sales.Orders
				select *from sales.Orders 
				order by order_id
				offset 0 rows fetch next 5 rows only

		-----------------Top-----------------

				select top(69) * from sales.Orders order by order_ship_city

		-----------------create view----------------
				create view sales.customer_order_view 
				as
				select cust_name, COUNT (order_id) as total_order 
				from sales.costumers c 
				join sales.Orders 
				on c.cust_id = order_cust_id
				group by cust_name

			-- use view 

			select*from sales.customer_order_view

			

