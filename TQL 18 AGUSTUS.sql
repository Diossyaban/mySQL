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





						---cursor
						declare @cate_id int;
						declare @cate_name nvarchar (40);
						declare cursor_category CURSOR FORWARD_ONLY READ_ONLY FOR
						SELECT TOP(13) cate_id, cate_name FROM SALES.categories;
						BEGIN

						--OPEN CURSOR

						OPEN CURSOR_CATEGORY;

						

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