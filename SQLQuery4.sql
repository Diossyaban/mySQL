										 --18 AGUSTUS 20202--
								---------------TSQL-----------------
								------------------------------------
							declare @N int=69;
							set @N=@N+69;
							print @n
							select @N as result;

						---get from table

				select*from sales.costumers
				declare @cust_id int;
				declare @cust_name nvarchar (40);

				select @cust_id=cust_id, @cust_name= cust_name 
				from sales.costumers 
				where cust_id=1;
				select @cust_id as customer_id , @cust_name as customer_name

				create procedure sales.Total_Product_By_Category as

				exec sales.Total_Product_By_Category;

						---cursor
						declare @cate_id int;
						declare @cate_name nvarchar (40);
						declare @total_product int ;
						declare cursor_category CURSOR FORWARD_ONLY READ_ONLY FOR
						SELECT TOP(10) cate_id, cate_name FROM SALES.categories;
						BEGIN

						--OPEN CURSOR

						OPEN CURSOR_CATEGORY;
						

						--Process and fetch new row until no more row availbe

						while @@FETCH_STATUS=0
						begin
							fetch next
							from cursor_category
							into @cate_id, @cate_name;

							--count product
							select @total_product =count (1) from sales.products where prod_cate_id=@cate_id;
						select	@cate_id as cate_id , @cate_name as cate_name, @total_product as total_product ;
						end;
						

						--FETCH ONE RECOARD DARI CUSROS
						FETCH NEXT 
						FROM CURSOR_CATEGORY
						into @cate_id ,@cate_name;

						--display value cate_id

						select @cate_id as category_id,@cate_name as category_name;

						--close

						close cursor_category;

					--	ngapus 

						deallocate cursor_category;  
						end;
								select*from sales.Orders where order_status = 'SHIPPED'
		select*from sales.Orders_detail