select s.[Name] Magasin, ad.City Ville, st.[Name] departement, r.[Name] pays
from Sales.Store s
inner join Person.BusinessEntity b on b.BusinessEntityID = s.BusinessEntityID
inner join Person.BusinessEntityAddress a on a.BusinessEntityID = b.BusinessEntityID
inner join Person.Address ad on ad.AddressID = a.AddressID
inner join Person.StateProvince st on st.StateProvinceID = ad.StateProvinceID 
inner join Person.CountryRegion r on r.CountryRegionCode = st.CountryRegionCode
