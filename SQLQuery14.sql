			select*from sales.orders
			select*from sales.Orders_detail
			select*from sales.Orders where order_shipped_date is null

		--	declare @ordet_price int;
		--	declare @ordet_quantity int;
		--	declare cursor_orders CURSOR FORWARD_ONLY READ_ONLY FOR

			declare @order_id int;
			declare @ordet_price money ;
			declare @ordet_quantity smallint ;
			declare @status nvarchar (40);
			declare cursor_orders CURSOR FORWARD_ONLY READ_ONLY FOR
			Select top(5) order_id from sales.Orders where order_shipped_date is null
			begin

			---open cursor
			open cursor_orders;
			---process and fetch until no more row availibe
		
			while @@FETCH_STATUS=0
			begin

			fetch from cursor_orders
			into @order_id
			
			select @ordet_price=sum(ordet_price),@ordet_quantity =sum (ordet_quantity), @status=' shipped' 
			from sales.Orders_detail where ordet_order_id=@order_id
			select @order_id as order_id, @ordet_price as ordet_price, @ordet_quantity as order_quantity, @status as status 

			end;
			-- close cusor
			close cursor_orders;
			-- hapus cursor di memory database
			deallocate cursor_orders;
			end;
