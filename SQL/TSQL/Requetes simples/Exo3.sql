use AdventureWorks2016
go
ALTER PROC ListPerson(@data xml)
AS
-- Etape 1 : récup du xml en table
select 
	T.N.value('prenom[1]', 'nvarchar(MAX)') prenom,
	T.N.value('nom[1]', 'nvarchar(MAX)') nom
into #t
from 
	@data.nodes('personnes/personne') T(N)

-- Etape 2 : select person.person avec prenom=Ken
select 
	* 
from 
	Person.Person
where 
	FirstName in (select prenom from #t)
	or
	LastName in (select nom from #t)
GO
Exec ListPerson '<personnes>
					<personne>
						<prenom>Ken</prenom>
					</personne>
					<personne>
						<prenom>Terri</prenom>
					</personne>
					<personne>
						<nom>Brown</nom>
					</personne>
				</personnes>'



select * from Person.Person
