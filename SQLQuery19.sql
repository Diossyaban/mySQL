	declare @order_id int;
		declare @ordet_price money ;
		declare @ordet_quantity smallint ;
		declare @order_status nvarchar (40);
		declare cursor_orders CURSOR FORWARD_ONLY READ_ONLY FOR
				Select top(21) order_id from sales.Orders where order_shipped_date is null
		begin

		---open cursor
		open cursor_orders;
		---process and fetch until no more row availibe
		
		while @@FETCH_STATUS=0
		begin

		fetch from cursor_orders
		into @order_id
			
		select @ordet_price=
		sum(ordet_price),@ordet_quantity =
		sum (ordet_quantity), @order_status=
		'shipped' 
		from sales.Orders_detail where ordet_order_id=@order_id

		update sales.Orders 
		set order_subtotal=@ordet_price,
		order_total_qty=@ordet_quantity, 
		order_status=@order_status,
		order_shipped_date=GETDATE()
		where order_id=@order_id

		--update so 
		--set order_employee_id =(select distinct employee_id
		--from hr.employees e join sales.orders o on e.xemp_id = o.b_employee_id
		--where xemp_id is not null and o.b_employee_id =so.b_employee_id)

		select @order_id as order_id, @ordet_price as ordet_price, @ordet_quantity as order_quantity, @order_status as status 

		end;
			-- close cusor
		close cursor_orders;
	-- hapus cursor di memory database
		deallocate cursor_orders;
		end;

		select * from sales.Orders where order_subtotal is not null