use AdventureWorks2016
go
select BusinessEntityID, FirstName, LastName 
from Person.Person 
For xml path('personne'), root('personnes')

select * from HumanResources.JobCandidate
GO
use MakfiBD
go
ALTER PROC Test(@data xml)
AS
select 
	A.B.value('../@id[1]', 'int') id,
	A.B.value('../nom[1]', 'nvarchar(MAX)') nom,
	A.B.value('codePostal[1]', 'nvarchar(MAX)') ville
from 
	@data.nodes('personnes/personne/adresse') A(B)

GO
Exec Test 
	'<personnes>
		<personne id="1">
			<nom>Dupont</nom>
			<adresse>
				<ville>Dunkerque</ville>
				<codePostal>59000</codePostal>
			</adresse>
		</personne>
		<personne id="2">
			<nom>Emile</nom>
			<adresse>
				<ville>Epinal</ville>
				<codePostal>88000</codePostal>
			</adresse>
		</personne>
	</personnes>'