USE TP2_FRANCK;

--1	Quels sont les vols au d�part de Paris entre 12h et 14h ?
SELECT vd, hd FROM vols
WHERE vd = 'PARIS' AND hd BETWEEN 12 AND 14;  
--BETWEEN donne toutes les valeurs entre 12 et 14 
SELECT vd, hd FROM vols
WHERE vd = 'PARIS' AND hd >=12 AND hd <=14;

--2	Quels sont les pilotes dont le nom commence par "S" ?
SELECT nom FROM pilotes 
WHERE nom LIKE'S%'; 


--3	Pour chaque ville, donner le nombre et les capacit�s minimum et maximum des avions qui s'y trouvent.
SELECT localisation, count(capacite)AS COMPTE, min(capacite)AS MINIMUM , max(capacite)AS MAXIMUM
FROM avions
GROUP BY localisation

--4	Pour chaque ville, donner la capacit� moyenne des avions qui s'y trouvent et cela par type d'avion.
SELECT avType, localisation , AVG(capacite) AS capaciteMoyenne
FROM avions
GROUP BY localisation, avType ;

--5 Quelle est la capacit� moyenne des avions pour chaque ville ayant plus de 1 avion ?
SELECT AVG(capacite) AS capaciteMoyenne, localisation, COUNT(*) AS nombreAvions FROM avions 
GROUP BY localisation
HAVING COUNT(av) > 1;

-- 6	Quels sont les noms des pilotes qui habitent dans la ville de localisation d'un Airbus

-- Utilisation d'une sous requ�te
SELECT p.nom FROM pilotes AS p
	 WHERE p.adresse IN (SELECT a.localisation FROM avions AS a WHERE a.marque = 'AIRBUS');

-- Utilisation d'une jointure, m�me r�sultat
SELECT DISTINCT p.nom FROM pilotes AS p
	INNER JOIN avions AS a ON p.adresse = a.localisation
	WHERE a.marque = 'AIRBUS';

-- D�composition de la requ�tes pour la jointure
-- �tape 1 : afficher la jointure complete,
--           On join les pilotes et les avions par leur adresses
--           (avion.localisation et pilotes.adresse)
SELECT DISTINCT p.*, a.* FROM pilotes AS p
	INNER JOIN avions AS a ON p.adresse = a.localisation;
	
-- �tape 2 : Limiter aux avions de marque AIRBUS
SELECT DISTINCT p.*, a.* FROM pilotes AS p
	INNER JOIN avions AS a ON p.adresse = a.localisation
	WHERE a.marque = 'AIRBUS';

-- �tape 3 : On affiche uniquement les noms des pilotes
SELECT DISTINCT p.nom FROM pilotes AS p
	INNER JOIN avions AS a ON p.adresse = a.localisation
	WHERE a.marque = 'AIRBUS';

-- 7 Quels sont les noms des pilotes qui conduisent un Airbus et qui habitent dans la ville de localisation d'un Airbus ?
select distinct nom, localisation
from vols 
inner join pilotes on vols.pilote=pilotes.pil
inner join avions on vols.avion= avions.av
where marque='AIRBUS' and pilotes.adresse =avions.localisation


--8	Quels sont les noms des pilotes qui conduisent un Airbus ou qui habitent dans la ville de localisation d'un Airbus ?

select distinct nom, localisation
from vols 
inner join pilotes on vols.pilote=pilotes.pil
inner join avions on vols.avion= avions.av
where marque='AIRBUS'  or pilotes.adresse =avions.localisation

--9	Quels sont les noms des pilotes qui conduisent un Airbus sauf ceux qui habitent dans la ville de localisation d'un Airbus ?

--Version Axel
SELECT DISTINCT nom, localisation
FROM vols 
INNER JOIN pilotes on vols.pilote=pilotes.pil
INNER JOIN avions on vols.avion= avions.av
WHERE marque='AIRBUS' 
EXCEPT
SELECT DISTINCT nom, localisation
FROM vols
INNER JOIN pilotes on vols.pilote=pilotes.pil
INNER JOIN avions on vols.avion= avions.av
WHERE pilotes.adresse = avions.localisation


--Version Paul
select distinct nom
from vols 
inner join pilotes on vols.pilote=pilotes.pil
inner join avions on vols.avion= avions.av
where marque='AIRBUS' and pilotes.adresse <> avions.localisation

10	Quels sont les vols ayant un trajet identique ( VD, VA ) � ceux assur�s par Serge ?
11	Donner toutes les paires de pilotes habitant la m�me ville ( sans doublon ).
12	Quels sont les noms des pilotes qui conduisent un avion que conduit aussi le pilote n�1 ?
13	Donner toutes les paires de villes telles qu'un avion localis� dans la ville de d�part soit conduit par un pilote r�sidant dans la ville d'arriv�e.
14	S�lectionner les num�ros des pilotes qui conduisent tous les Airbus ?

