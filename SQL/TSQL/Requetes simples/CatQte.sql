-- les produits (qté) dans les 2 catégories les meilleures (CA) en 2012


select p.[Name] , SUM(OrderQty) n
from Sales.SalesOrderDetail d
inner join Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
inner join Production.Product p on d.ProductID = p.ProductID
inner join Production.ProductSubcategory sc on sc.ProductSubcategoryID = p.ProductSubcategoryID
inner join Production.ProductCategory c on c.ProductCategoryID = sc.ProductCategoryID
Where 
	c.ProductCategoryID in 
						(
						select top 2 c.ProductCategoryID 
						from Sales.SalesOrderDetail d
						inner join Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
						inner join Production.Product p on d.ProductID = p.ProductID
						inner join Production.ProductSubcategory sc on sc.ProductSubcategoryID = p.ProductSubcategoryID
						inner join Production.ProductCategory c on c.ProductCategoryID = sc.ProductCategoryID
						group by c.ProductCategoryID,YEAR(h.OrderDate)
						having YEAR(h.OrderDate)=2012
						order by SUM(OrderQty * UnitPrice) desc
						)
group by p.ProductID, p.[Name], YEAR(h.OrderDate)
having YEAR(h.OrderDate)=2012 
order by p.[Name]