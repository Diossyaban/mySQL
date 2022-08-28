
select*from AdventureWorks2019.Sales.Customer
select*from [Sales].[SalesPerson]
select * from person.person
select * from sales.Customer
select * from sales.SalesOrderHeader

----1. Buat SQL untuk menampilkan customer yang memiliki jumlah order.


select c.CUSTOMERID,p.FirstName,p.lastname,count (c.Customerid) as Total_Order
from person.person p 
join sales.Customer c on p.BusinessEntityID = c.CustomerID
join sales.SalesOrderHeader soh on  c.CustomerID= soh.CustomerID

group by c.CustomerID,p.FirstName,p.LastName

----2. Buat SQL untuk menampilkan total salesperson yang sudah melakukan PO.

select p.BusinessEntityID,p.LastName,p.LastName,e.JobTitle, Count (sp.PurchaseOrderNumber) as Total_Order
from  person.person p
join HumanResources.Employee e on p.BusinessEntityID  = e.BusinessEntityID
join sales.SalesPerson soh on  p.BusinessEntityID = soh.BusinessEntityID
join sales.SalesOrderHeader sp  on soh.BusinessEntityID = sp.SalesPersonID
group by  p.BusinessEntityID,p.LastName,p.LastName,e.JobTitle

sp_help[sales.SalesOrderHeader]

-----3. Buat SQL untuk menampilkan credit card yang dipakai oleh person.

select p.BusinessEntityID,P.FirstName,P.LastName,cc.CardType
from person.person p
join sales.PersonCreditCard pcc on p.BusinessEntityID= pcc.BusinessEntityID
join sales.CreditCard cc on  pcc.CreditCardID =  cc.CreditCardID
group by p.BusinessEntityID,P.FirstName,P.LastName,cc.CardType

---4. Dari Hasil SQL digambar bawah, coba hitung berapa kali product mendapatkan discount atau special offering. Misal ProductId 707, total promosi discount 5 kali

select p.productID,p.Name, COUNT(sop.productID) as Total_Diskon

from sales.SpecialOffer so 
join sales.SpecialOfferProduct sop
	on so.SpecialOfferID = sop.SpecialOfferID
join Production.Product p 
	on sop.ProductID =  p.ProductID
WHERE so.Category != 'No Discount'
group by p.productID,p.Name
order by p.ProductID