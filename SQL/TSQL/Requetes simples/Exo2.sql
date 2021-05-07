use AdventureWorks2016
go
ALTER PROC Test_XML(@data xml)
AS
select 
	T.N.value('.', 'int') col1,
	T.N.value('@c', 'char') col2
from 
	@data.nodes('a/b') T(N)
GO
Exec Test_XML '<a><b c="A">12</b><b c="B">13</b></a>'

--	col1  col2
--	 12    A
--	 13    B


