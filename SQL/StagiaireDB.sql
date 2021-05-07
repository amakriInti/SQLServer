use master
go
CREATE DATABASE [Inti]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Inti', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Inti.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Inti_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Inti_log.ldf' , SIZE = 2048KB , FILEGROWTH = 65536KB )
Go
use Inti
GO
CREATE TABLE [dbo].[Ville]
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](max) NOT NULL,
	[CodePostal] [char](5) NULL,
	[Departement] [char](2) NULL,
	CONSTRAINT [PK_Ville] PRIMARY KEY CLUSTERED (	[Id] ASC )
) 
GO
CREATE TABLE [dbo].[Stagiaire]
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](max) NOT NULL,
	[Prenom] [nvarchar](max) NOT NULL,
	[DateNaisssance] [datetime] NULL,
	[Ville] [bigint] NOT NULL,
	CONSTRAINT [PK_Stagiaire] PRIMARY KEY CLUSTERED ([Id] ASC)
) 
GO
ALTER TABLE [dbo].[Stagiaire]  WITH CHECK ADD  CONSTRAINT [FK_Stagiaire_Ville] FOREIGN KEY([Ville])
REFERENCES [dbo].[Ville] ([Id])
GO
ALTER TABLE [dbo].[Stagiaire] CHECK CONSTRAINT [FK_Stagiaire_Ville]
GO

insert ville (nom, Departement) values ('Strasbourg', 67)
insert ville (nom, Departement) values ('Valenciennes', 59)
insert ville (nom, Departement) values ('Reims', 51)
insert ville (nom, Departement) values ('Nice', 06)
insert ville (nom, Departement) values ('Lyon', 69)
insert ville (nom, Departement) values ('Bordeaux', 33)
insert ville (nom, Departement) values ('Mulhouse', 68)

insert stagiaire (Nom, Prenom, Ville) values('Kammerer', 'Loïc', 1)
insert stagiaire (Nom, Prenom, Ville) values('Escoda', 'Florentin', 2)
insert stagiaire (Nom, Prenom, Ville) values('Lefevre', 'Quentin', 3)
insert stagiaire (Nom, Prenom, Ville) values('Menendez', 'Morgane', 4)
insert stagiaire (Nom, Prenom, Ville) values('Striegel', 'Diego', 1)
insert stagiaire (Nom, Prenom, Ville) values('Argento', 'Alexandre', 1)
insert stagiaire (Nom, Prenom, Ville) values('Bazir', 'Anthony', 7)
insert stagiaire (Nom, Prenom, Ville) values('Lebeau', 'Matthieu', 8)
insert stagiaire (Nom, Prenom, Ville) values('Rigoni', 'Vincent', 9)

select * from Ville
select * from Stagiaire

SELECT Stagiaire.Nom, Stagiaire.Prenom
FROM  Ville INNER JOIN
         Stagiaire ON Ville.Id = Stagiaire.Ville
WHERE (Ville.Nom = N'Strasbourg')
