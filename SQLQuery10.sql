select*from sales.categories
---- cursor ----
declare @cate_id int;
declare @cate_name nvarchar(40);
declare @total_product int;
declare cursor_category CURSOR FORWARD_ONLY READ_ONLY FOR
		select top(10) cate_id,cate_name from sales.categories;
begin
	--- open cursor;
	open cursor_category;

	-- process and fetch new row until no more row availble
	while @@FETCH_STATUS = 0
	begin
		fetch next
		from cursor_category
		into @cate_id,@cate_name;

		-- count product
		select @total_product=count(1) from sales.products where prod_cate_id=@cate_id;

		--select @cate_id as cate_id, @cate_name as cate_name,@total_product as total_product;
		print 'cate_id :'+cast(@cate_id as nvarchar)+',cate_name:'+@cate_name+',total_product:'+cast(@total_product as nvarchar);
	end;
	-- close cusor
	close cursor_category;
	-- hapus cursor di memory database
	deallocate cursor_category;
end;