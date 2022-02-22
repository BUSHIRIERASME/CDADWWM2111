USE TP1_Franck;

-- 1.	Donner nom, job, num�ro et salaire de tous les employ�s, puis seulement des employ�s du d�partement 10

-- selectionne les attribut suivant � afficher : EMPNO, ENAME, JOB, SAL depuis la table EMP
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP;

-- selectionne les m�mes attributs uniquement pour les employ� du d�partement 10 (DEPTNO = 10)
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP WHERE DEPTNO = 10;


-- 2.	Donner nom, job et salaire des employ�s de type MANAGER dont le salaire est sup�rieur � 2800
SELECT ENAME, JOB, SAL 
FROM EMP 
WHERE JOB = 'MANAGER' AND SAL > 2800;

-- "WHERE JOB = 'MANAGER'" : condition pour selectionner les managers
-- "AND" : pour ajouter une deuxi�me condition
-- "SAL > 2800" : pour la condition du salaire minimal 


-- 3.	Donner la liste des MANAGER n'appartenant pas au d�partement 30
SELECT ENAME, JOB, DEPTNO 
FROM EMP 
WHERE JOB = 'MANAGER' AND DEPTNO <> 30.

-- 4.	Liste des employ�s de salaire compris entre 1200 et 1400
SELECT * 
FROM  EMP 
WHERE SAL > 1200 AND SAL < 1400;

-- 5.	Liste des employ�s des d�partements 10 et 30 class�s dans l'ordre alphab�tique
SELECT * 
FROM EMP 
WHERE DEPTNO  = 10 OR DEPTNO  =  30 
ORDER BY ENAME;

--ORDER BY : permet de d�finir une colonne dont on veut l'ordre alphab�tique.


-- 6.	Liste des employ�s du d�partement 30 class�s dans l'ordre des salaires croissants



-- 7.	Liste de tous les employ�s class�s par emploi et salaires d�croissants



-- 8.	Liste des diff�rents emplois



-- 9.	Donner le nom du d�partement o� travaille ALLEN

	

-- 10.	Liste des employ�s avec nom du d�partement, nom, job, salaire class�s par noms de d�partements et par salaires d�croissants.

  
-- 11.	Liste des employ�s vendeurs (SALESMAN) avec affichage de nom, salaire, commissions, salaire + commissions



-- 12.	Liste des employ�s du d�partement 20: nom, job, date d'embauche sous forme VEN 28 FEV 1997'



-- 13.	Donner le salaire le plus �lev� par d�partement



-- 14.	Donner d�partement par d�partement masse salariale, nombre d'employ�s, salaire moyen par type d'emploi.



-- 15.	M�me question mais on se limite aux sous-ensembles d'au moins 2 employ�s
	

-- 16.	Liste des employ�s (Nom, d�partement, salaire) de m�me emploi que JONES




-- 17.	Liste des employ�s (nom, salaire) dont le salaire est sup�rieur � la moyenne globale des salaires





-- 18.	Cr�ation d'une table PROJET avec comme colonnes num�ro de projet (3 chiffres), nom de projet(5 caract�res), budget. Entrez les valeurs suivantes:
-- 101, ALPHA,	96000
-- 102, BETA,	82000
-- 103, GAMMA,	15000


 
-- 19.	Ajouter l'attribut num�ro de projet � la table EMP et affecter tous les vendeurs du d�partement 30 au projet 101, et les autres au projet 102


-- 20.	 Cr�er une vue comportant tous les employ�s avec nom, job, nom de d�partement et nom de projet

-- 21.	A l'aide de la vue cr��e pr�c�demment, lister tous les employ�s avec nom, job, nom de d�partement et nom de projet tri�s sur nom de d�partement et nom de projet



-- 22.	Donner le nom du projet associ� � chaque manager

