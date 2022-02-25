USE TP1_Franck

-- Choses importantes de cette partie : LIKE ; Jointure ou Sous-requ�tes (questions 7, 11) ; Sous-requ�tes ; ORDER BY ; GROUP BY ; AVG ; SUM

-- 1.	Afficher la liste des managers des d�partements 20 et 30
SELECT ENAME, JOB, DEPTNO FROM EMP
WHERE JOB = 'MANAGER' AND DEPTNO IN (20, 30);

SELECT ENAME, JOB, DEPTNO FROM EMP
WHERE JOB = 'MANAGER' AND (DEPTNO = 20 OR DEPTNO = 30);

-- 2.	Afficher la liste des employ�s qui ne sont pas manager et qui ont �t� embauch�s en 81

SELECT ENAME, HIREDATE FROM EMP
WHERE JOB <> 'MANAGER' AND YEAR(HIREDATE) = '1981'

SELECT ENAME, HIREDATE FROM EMP
WHERE JOB <> 'MANAGER' AND FORMAT(HIREDATE, 'yyyy') = 1981;

-- 3.	Afficher la liste des employ�s ayant une commission

SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

-- IS NOT NULL : permet de sp�cifier que l'on ne prend que des valeurs non null dans la colonne COMM

-- 4.	Afficher la liste des noms, num�ros de d�partement, jobs et date d'embauche tri�s par Numero de D�partement et JOB  les derniers embauches d'abord.
SELECT ENAME, DEPTNO, JOB, HIREDATE 
FROM EMP
ORDER BY DEPTNO ASC, JOB ASC, HIREDATE DESC;


-- 5.	Afficher la liste des employ�s travaillant � DALLAS
SELECT ENAME 
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
	
SELECT ENAME 
FROM EMP
INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE LOC = 'DALLAS';

-- 6.	Afficher les noms et dates d'embauche des employ�s embauch�s avant leur manager, avec le nom et date d'embauche du manager.
SELECT MANAGER.ENAME AS ManagerName, MANAGER.HIREDATE AS ManagerHiredate, EMP.ENAME AS EmployeeName, EMP.HIREDATE AS EmployeeHiredate
FROM EMP
INNER JOIN EMP AS MANAGER ON EMP.MGR = MANAGER.EMPNO
WHERE EMP.HIREDATE < MANAGER.HIREDATE;

-- On fait une jointure de la table des employ�s vers elle m�me en faisant correspondre le num�ro des managers des employ�s avec le num�ro d'employ� des managers
-- Dans ce cas il faut penser � utiliser un alias pour bien diff�rencier employ� et manager

-- 7.	Lister les num�ros des employ�s n'ayant pas de subordonn�.

-- soluce 1 : avec jointure
SELECT managers.EMPNO, managers.ENAME FROM EMP AS managers
	LEFT JOIN EMP AS subordonates
	ON managers.EMPNO = subordonates.MGR
	WHERE subordonates.MGR IS null;

-- soluce 2 : avec sous requete
SELECT EMPNO, ENAME FROM EMP
	WHERE EMPNO NOT IN (SELECT MGR FROM EMP WHERE MGR IS NOT NULL); 

-- 8.	Afficher les noms et dates d'embauche des employ�s embauch�s avant BLAKE.

SELECT EMPNO, ENAME, HIREDATE FROM EMP
	WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'BLAKE')

-- 9.	Afficher les employ�s embauch�s le m�me jour que FORD.


SELECT EMPNO, ENAME, HIREDATE FROM EMP
	WHERE HIREDATE = (SELECT HIREDATE FROM EMP WHERE ENAME = 'FORD')


-- 10.	Lister les employ�s ayant le m�me manager que CLARK.

SELECT EMPNO, ENAME, MGR FROM EMP
	WHERE MGR = (SELECT MGR FROM EMP WHERE ENAME = 'CLARK')

-- 11.	Lister les employ�s ayant m�me job et m�me manager que TURNER.
SELECT EMP.ENAME, EMP.HIREDATE, EMP.JOB, EMP.MGR
FROM EMP LEFT JOIN EMP AS EMPBIS ON EMP.MGR = EMPBIS.MGR
WHERE EMPBIS.ENAME = 'TURNER' AND EMP.JOB = EMPBIS.JOB;

SELECT EMP.ENAME, EMP.HIREDATE, EMP.JOB, EMP.MGR
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'TURNER') 
	AND MGR = (SELECT MGR FROM EMP WHERE ENAME = 'TURNER');

-- 12.	Lister les employ�s du d�partement RESEARCH embauch�s le m�me jour que quelqu'un du d�partement SALES.




-- 13.	Lister le nom des employ�s et �galement le nom du jour de la semaine correspondant � leur date d'embauche.



-- 14.	Donner, pour chaque employ�, le nombre de mois qui s'est �coul� entre leur date d'embauche et la date actuelle.

SELECT ENAME, DATEDIFF(month,HIREDATE,GETDATE()) AS MOIS_DEPUIS_EMBAUCHE
FROM EMP;

-- J'utilise la fonction int�gr�e 'DATEDIFF()' qui prend en param�tre un interval, une date de d�part et une date de fin. J'utilise 'GETDATE()' pour connaitre la date d'aujourd'hui.

-- 15.	Afficher la liste des employ�s ayant un M et un A dans leur nom.

SELECT ENAME
FROM EMP
WHERE CHARINDEX('A', EMP.ENAME) > 0 AND CHARINDEX('M', EMP.ENAME) > 0 ;

SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%M%' AND ENAME LIKE '%A%';
-- A% Tous les mots commen�ant par A
-- %A Tous les mots finissant par A
-- %A% Tous les mots ayant au moins 1 A

-- 16.	Afficher la liste des employ�s ayant deux 'A' dans leur nom.
SELECT * 
FROM EMP
WHERE (LEN(ENAME) - LEN(REPLACE(ENAME,'A',''))) = 2


-- 17.	Afficher les employ�s embauch�s avant tous les employ�s du d�partement 10.
SELECT ENAME
FROM EMP
WHERE HIREDATE < ALL(SELECT HIREDATE FROM EMP WHERE DEPTNO = 10);
-- < ALL(SELECT...) permet de sp�cifier que la valeur est inf�rieur � toutes les valeurs retourn�es par la sous-requ�te


-- 18.	S�lectionner le m�tier o� le salaire moyen est le plus faible.
SELECT JOB, AVG(SAL) FROM EMP
GROUP BY JOB
HAVING AVG(SAL) <= ALL(SELECT AVG(SAL) FROM EMP GROUP BY JOB);



-- 19.	S�lectionner le d�partement ayant le plus d'employ�s.
SELECT DEPTNO, COUNT(EMPNO)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(EMPNO) >= ALL (SELECT COUNT(EMPNO) FROM EMP GROUP BY DEPTNO);
-- COUNT(EMPNO) : pour compter le nombre d'emply� par departement
-- HAVING COUNT(EMPNO) >= ALL (SELECT ...) : On veut le groupe qui a le plus d'employes 

-- 20.	Donner la r�partition en pourcentage du nombre d'employ�s par d�partement selon le mod�le ci-dessous

SELECT DEPTNO, CAST(CAST(COUNT(EMPNO) AS REAL)*100 / (SELECT COUNT(EMPNO) FROM EMP) AS DECIMAL(5,2)) AS Pourcentage
FROM EMP
GROUP BY DEPTNO;

-- CAST(valeur AS type_d�sir�) ; 
-- DECIMAL (5,2)  => nombre d�cimal compos� de 5 caract�res avec 2 nombres apr�s la virgule
-- RAPPEL : on peut faire n'importe quel calcul dans nos requ�tes. Ici on fait un pourcentage.