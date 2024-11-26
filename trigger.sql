create database a1_Trigger;
use a1_Trigger;

create table Compte(
id_cpt int primary key,
nom varchar(25),
solde decimal(10,2)
);

create table Virement(
idVir int primary key,
id_cpt1 int,
id_cpt2 int,
montant decimal(10,2),
foreign key (id_cpt1) references Compte(id_cpt),
foreign key (id_cpt2) references Compte(id_cpt)
);



DELIMITER //
create trigger trigger_traitement
after insert
on Virement
for each row
begin
update Compte
set solde = solde - new.montant
where id_cpt = new.id_cpt1;

update Compte
set solde = solde + new.montant
where id_cpt = new.id_cpt2;
end //
DELIMITER ;

INSERT INTO Compte (id_cpt, nom, solde) VALUES (1, 'Compte A', 1000.00);
INSERT INTO Compte (id_cpt, nom, solde) VALUES (2, 'Compte B', 500.00);
INSERT INTO Compte (id_cpt, nom, solde) VALUES (3, 'Compte A', 1000.00);
INSERT INTO Compte (id_cpt, nom, solde) VALUES (4, 'Compte B', 500.00);



INSERT INTO Virement (idVir, id_cpt1, id_cpt2, montant) VALUES (2, 3, 4, 200.00);


-- Vérifions les soldes initiaux
SELECT * FROM Compte;

-- Suppression Trigger 
create table compte_log(
id_cpt int primary key,
nom varchar(45),
solde decimal(10,2),
dateSupp date
);

DELIMITER //
create trigger trg_2
after delete
on Compte
for each row
begin

insert into compte_log(id_cpt, nom, solde, datSupp) values (old.id_cpt, old.nom, old.solde, curdate());

end //
DELIMITER ;






create table Commande(
id_cmd int primary key,
DateCmd date,
Montant decimal(10,2)

);

create table Produit(
refProd int primary key,
Designation varchar(45),
prix decimal(10,2),
QtStock int
);

create table Details_Commande(
id_cmd int,
refProd int,
Qtc int,
foreign key (id_cmd) references Commande (id_cmd),
foreign key (refProd) references Produit (refProd)
);
