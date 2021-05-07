-- Connection 1 
-- Reprise 16h23

insert Ville (Nom) values('Marseille'), ('Montbeliard'), ('Mouzon')

select * from Ville

BEGIN TRAN
delete Ville where Id > 9
select COUNT(*) from Ville where Nom like 'M%'

COMMIT TRAN

