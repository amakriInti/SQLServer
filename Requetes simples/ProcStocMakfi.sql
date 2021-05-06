use MakfiBD
go




CREATE PROC Hotel_Insert(@nom nvarchar(MAX), @reception uniqueidentifier, @gouv uniqueidentifier,  @commentaire nvarchar(MAX),  @idWeb nvarchar(MAX))
AS
Insert into Hotel (Nom, Reception, Gouvernante, Commentaire, IdWeb) 
values(@nom, @reception, @gouv, @commentaire, @idWeb)

GO

CREATE PROC Utilisateur_Insert(@nom nvarchar(MAX), @id int, @codepin nvarchar(MAX), @statut tinyint)
AS
insert into Utilisateur (Nom, Identifiant, CodePin, Statut) values(@nom, @id, @codepin, @statut)
GO

-- 1. Gouvernante 
Exec Utilisateur_Insert 'Sylvie', 1, '1111', 1
-- 2. Reception 
Exec Utilisateur_Insert 'André', 2, '1111', 2

-- 3. Hotel
DECLARE @andre uniqueidentifier
DECLARE @sylvie uniqueidentifier
select @andre=Id from Utilisateur where Identifiant=2
select @sylvie=Id from Utilisateur where Identifiant=1
Exec Hotel_Insert 'Hotel du nord', @andre, @sylvie, null, null

-- 4. Chambre 
DECLARE @etat uniqueidentifier
DECLARE @hotel uniqueidentifier
select @etat=Id from Etat where  Entite=4 and Libelle='None'
select @hotel=Id from Hotel where Nom='Hotel du nord'
Exec Chambre_Insert 'Chambre 101', @etat, 'Chambre au premier étage', @hotel

Exec Chambre_Read

-- **************************************************************************************
ALTER PROC GroupeChambre_Insert(@nom nvarchar(MAX), @commentaire nvarchar(MAX), @hotel uniqueidentifier)
AS
insert GroupeChambre (Nom, Commentaire, Hotel) values(@nom, @commentaire,@hotel)
GO
ALTER PROC GroupeChambre_Read 
AS
select Id, Nom, Commentaire, Hotel from GroupeChambre
GO

DECLARE @hotel uniqueidentifier
select @hotel=Id from Hotel where Nom='Hotel du nord'
Exec GroupeChambre_Insert 'Premier étage', null, @hotel

-- **************************************************************************************
CREATE PROC Chambre_Update(@id uniqueidentifier, @nom nvarchar(MAX), @etat uniqueidentifier, @commentaire nvarchar(MAX), @hotel uniqueidentifier)
AS
update Chambre set 
	Nom = @nom,
	Etat = @etat,
	Commentaire=@commentaire,
	Hotel=@hotel
where Id=@id
GO

DECLARE @id uniqueidentifier
DECLARE @etat uniqueidentifier
DECLARE @hotel uniqueidentifier
DECLARE @nom nvarchar(MAX)
DECLARE @commentaire nvarchar(MAX)
select @id= Id, @nom=Nom, @etat=Etat, @commentaire=Commentaire, @hotel=Hotel from Chambre where Nom='Chambre 101'

Exec Chambre_Update @id, 'Chambre 101 Bis', @etat, 'Chambre bis', @hotel

-- **************************************************************************************
ALTER PROC Chambre_Delete(@id uniqueidentifier)
AS
delete Chambre where Id=@id
GO

ALTER PROC Hotel_Delete(@id uniqueidentifier)
AS
delete Hotel where Id=@id
GO

ALTER PROC Chambre_Read(@id uniqueidentifier=NULL, @hotel uniqueidentifier=NULL)
AS
	Select Id, Nom, Etat, Commentaire, Hotel from Chambre 
	Where (@id IS NULL or Id=@id) and (@hotel IS NULL or Hotel=@hotel)
GO

Exec Chambre_Read 
Exec Chambre_Read 'E954F32E-0610-4AB7-9C08-DF34EA418A6C'
Exec Chambre_Read NULL, 'A7C8AD2D-A20C-478B-AF31-4AA7E5AB6917'
Exec Chambre_Read 'E954F32E-0610-4AB7-9C08-DF34EA418A6C', 'A7C8AD2D-A20C-478B-AF31-4AA7E5AB6917'

ALTER PROC Chambre_Insert( 
		@nom nvarchar(MAX), @etat uniqueidentifier, @commentaire nvarchar(MAX), 
		@hotel uniqueidentifier, @etage uniqueidentifier)
AS
DECLARE @id uniqueidentifier

Insert into Chambre (Nom, Etat, Commentaire, Hotel) values(@nom, @etat, @commentaire, @hotel)
select @id=Id from Chambre where ModifiedDate = (select MAX(ModifiedDate) from Chambre)
IF @etage IS NOT NULL
  BEGIN
  insert ChambreGroupeChambre (Chambre, GroupeChambre) values(@id, @etage)
  END
GO

DECLARE @etat uniqueidentifier
DECLARE @hotel uniqueidentifier
select @etat=Id from Etat where  Entite=4 and Libelle='None'
select @hotel=Id from Hotel where Nom='Hotel du nord'
Exec Chambre_Insert 'Chambre 102', @etat, ' 2e Chambre au premier étage', @hotel, 'CB3D0806-B6D4-4FD2-A850-51FCBCC95F5C'

select * from Chambre
select * from GroupeChambre
select * from ChambreGroupeChambre


select gc.Nom, c.Nom
from ChambreGroupeChambre cgc
inner join Chambre c on c.Id = cgc.Chambre
inner join GroupeChambre gc on gc.Id=cgc.GroupeChambre

