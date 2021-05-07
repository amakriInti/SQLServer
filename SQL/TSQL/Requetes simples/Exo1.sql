use AdventureWorks2016
go
BEGIN TRAN
INSERT Production.Product 
	(
	[Name],
	ProductNumber,
	SafetyStockLevel,
	ReorderPoint,
	StandardCost,
	ListPrice,
	DaysToManufacture,
	SellStartDate
	)
Values
	(
	'Produit 1',
	'ABC',
	4,
	3,
	78.60,
	90.10,
	5,
	CONVERT(datetime, '11/05/2013', 103)
	)

INSERT Production.ProductCategory ([Name]) values('Cat1')

INSERT Production.ProductSubcategory 
(
[ProductCategoryID],
[Name]
)
values
(
@@IDENTITY,
'SCat 1'
)

select * from Production.Product
select * from Production.ProductSubcategory
select * from Production.ProductCategory
ROLLBACK TRAN

