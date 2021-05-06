-- Meilleur employé
select top 1
	p.LastName
from Sales.SalesOrderDetail d 
inner join Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
inner join Person.BusinessEntity b on b.BusinessEntityID = h.SalesPersonID
inner join Person.Person p on p.BusinessEntityID = b.BusinessEntityID
group by b.BusinessEntityID, p.LastName
order by SUM(d.OrderQty * d.UnitPrice) desc
