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

-- Alternative
SELECT * 
FROM EMP 
WHERE DEPTNO  IN (10,30)  -- IN : permet de lister toutes les valeurs attendues
ORDER BY ENAME;




-- 6.	Liste des employ�s du d�partement 30 class�s dans l'ordre des salaires croissants

SELECT *
FROM EMP
WHERE DEPTNO IN (30) 
ORDER BY SAL ASC;
-- Ordre des salaires dans l'ordre croissant ASC = ordre croissant DESC = ordre d�croissant

-- 7.	Liste de tous les employ�s class�s par emploi et salaires d�croissants

SELECT *
FROM EMP
ORDER BY JOB DESC,SAL DESC;

-- 8.	Liste des diff�rents emplois
SELECT DISTINCT JOB
FROM EMP

-- DISTINCT sert � lister une seule occurrence dans une colonne. 

-- Autre soloution accept�e :
SELECT JOB
FROM EMP
GROUP BY JOB;


-- 9.	Donner le nom du d�partement o� travaille ALLEN

SELECT DEPT.DNAME 
FROM DEPT
INNER JOIN EMP ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.ENAME = 'ALLEN';
-- Je fais une jointure avec mon 'INNER JOIN' pour acc�der au nom du d�partement.

SELECT DEPT.DNAME 
FROM DEPT
WHERE DEPTNO = (SELECT EMP.DEPTNO 
					FROM EMP
					WHERE ENAME = 'ALLEN')

-- Deuxi�me version avec une sous-requ�te � la place d'une jointure.



-- 10.	Liste des employ�s avec nom du d�partement, nom, job, salaire class�s par noms de d�partements et par salaires d�croissants.
SELECT ENAME, DNAME, JOB, SAL 
FROM EMP 
INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO 
ORDER BY DNAME DESC, SAL DESC


-- 11.	Liste des employ�s vendeurs (SALESMAN) avec affichage de nom, salaire, commissions, salaire + commissions

Select ENAME, SAL, COMM, (SAL + COMM) AS CALCUL 
From EMP
WHERE JOB = 'SALESMAN';

-- On peut faire n'importe quels calculs sur n'importe quelle colonne qui utilise des valeurs de type num�rique.


-- 12.	Liste des employ�s du d�partement 20: nom, job, date d'embauche sous forme VEN 28 FEV 1997'

Select ENAME, JOB, FORMAT(HIREDATE, 'ddd dd MMM yyyy') 
FROM EMP
WHERE DEPTNO = 20;


-- 13.	Donner le salaire le plus �lev� par d�partement
SELECT MAX (SAL) AS SALMAX, DEPTNO 
FROM EMP 
GROUP BY DEPTNO;  
-- max pour d�terminer le salaire max as=alias group by pour grouper 

-- 14.	Donner d�partement par d�partement masse salariale, nombre d'employ�s, salaire moyen par type d'emploi.
     select deptno, SUM(sal) AS SumSal, AVG(sal) AS AverageSal, count (ename) AS EmployeeCount,job
	 from emp
	 group by deptno,job
	 order by deptno;



-- 15.	M�me question mais on se limite aux sous-ensembles d'au moins 2 employ�s
	SELECT DNAME, JOB, SUM(SAL), COUNT(*) AS NBRPERSON, AVG(SAL) AS AVERAGESAL 
	FROM EMP
	INNER JOIN DEPT ON DEPT.DEPTNO = EMP.DEPTNO
	GROUP BY DNAME, JOB 
	HAVING COUNT(*) > 1;

	-- HAVING permet d'ajouter des conditions sur des valeurs agr�g�e (avec un GROUP BY)

-- 16.	Liste des employ�s (Nom, d�partement, salaire) de m�me emploi que JONES
SELECT EMP.ENAME, EMP.DEPTNO, EMP.SAL 
FROM EMP 
WHERE EMP.JOB = (SELECT EMP.JOB FROM EMP  WHERE ENAME ='JONES');

-- j'ai affich� la liste des employ�s (Nom, d�partement, salaire) de m�me emploi que JONES

-- 17.	Liste des employ�s (nom, salaire) dont le salaire est sup�rieur � la moyenne globale des salaires
SELECT ENAME, SAL 
FROM EMP
WHERE SAL > (SELECT AVG(SAL)FROM EMP)

-- 18.	Cr�ation d'une table PROJET avec comme colonnes num�ro de projet (3 chiffres), nom de projet(5 caract�res), budget. Entrez les valeurs suivantes:
-- 101, ALPHA,	96000
-- 102, BETA,	82000
-- 103, GAMMA,	15000

--VOIR AUTRES FICHIERS
 
-- 19.	Ajouter l'attribut num�ro de projet � la table EMP et affecter tous les vendeurs du d�partement 30 au projet 101, et les autres au projet 102

-- VOIR AUTRES FICHIERS

-- 20.	 Cr�er une vue comportant tous les employ�s avec nom, job, nom de d�partement et nom de projet

USE TP1_Franck;

CREATE VIEW employees_info AS
	SELECT e.ENAME, e.JOB, d.DNAME, p.PROJNAME FROM EMP AS e
	INNER JOIN DEPT AS d ON d.DEPTNO = e.DEPTNO
	INNER JOIN PROJET AS p ON p.PROJNO = e.PROJNO;

-- 21.	A l'aide de la vue cr��e pr�c�demment, lister tous les employ�s avec nom, job, nom de d�partement et nom de projet tri�s sur nom de d�partement et nom de projet

SELECT * FROM employees_info
	ORDER BY DNAME, PROJNAME;


-- 22.	Donner le nom du projet associ� � chaque manager
SELECT PROJNAME FROM employees_info WHERE JOB = 'MANAGER';

