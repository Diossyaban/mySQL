--migrate table nortwind



--cara #1

set identity_insert sales.categories on;
insert into sales.categories(cate_id,cate_name,cate_description)
select CategoryID, CategoryName,Description from Northwind.dbo.Categories
set identity_insert sales.categories off;

--cara#2

insert into sales.categories(cate_name,cate_description)
select Categoryname,Description From Northwind.dbo.Categories

--menghapapus dan select

select*from sales.categories
delete from sales.categories

--RESET Identity seed
DBCC CHECKIDENT ('sales.categories',RESEED,0);
GO

select*from Northwind.dbo.Categories