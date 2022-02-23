USE TP1_Franck;
GO
-- S'il n'y a aucune donn�es dans les tablse DEPT et EMP alors je les remplis avec mes INSERT INTO
IF NOT EXISTS (SELECT * FROM DEPT, EMP)
BEGIN
	-- On commence par les INSERT dans la table d�partement car elle n'a pas de cl� �trang�re
	INSERT INTO DEPT (DEPTNO, DNAME, LOC)
	VALUES (10, 'ACCOUNTING', 'NEW YORK'), (20, 'RESEARCH', 'DALLAS'), (30, 'SALES', 'CHICAGO'), (40, 'OPERATIONS', 'BOSTON');

	-- Pour les INSERT des employ�s, on prend soin de faire en sorte que les cl�s �trang�res de manager existent d�j�. C'est pour cela qu'on commence par ins�rer KING qui est manager de BLAKE et CLARK, qui sont manager de ...
	INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES
	(7839,	'KING',		'PRESIDENT',	NULL,	'1981-11-17',	5000,	NULL,	10),
	(7698,	'BLAKE',	'MANAGER',		7839,	'1981-05-01',	2850,	NULL,	30),
	(7782,	'CLARK',	'MANAGER',		7839,	'1981-06-09',	2450,	NULL,	10),
	(7566,	'JONES',	'MANAGER',		7839,	'1981-04-02',	2975,	NULL,	20),
	(7844,	'TURNER',	'SALESMAN',		7698,	'1981-09-08',	1500,	0,		30),
	(7900,	'JAMES',	'CLERK',		7698,	'1981-12-03',	950,	NULL,	30),
	(7521,	'WARD',		'SALESMAN',		7698,	'1981-02-22',	1250,	500,	30),
	(7654,	'MARTIN',	'SALESMAN',		7698,	'1981-09-28',	1250,	1400,	30),
	(7934,	'MILLER',	'CLERK',		7782,	'1982-01-23',	1300,	NULL,	10),
	(7788,	'SCOTT',	'ANALYST',		7566,	'1982-12-09',	3000,	NULL,	20),
	(7902,	'FORD',		'ANALYST',		7566,	'1981-12-03',	3000,	NULL,	20),
	(7876,	'ADAMS',	'CLERK',		7788,	'1983-01-12',	1100,	NULL,	20),
	(7369,	'SMITH',	'CLERK',		7902,	'1980-12-17',	800,	NULL,	20),
	(7499,	'ALLEN',	'SALESMAN',		7698,	'1981-02-20',	1600,	300,	30);
END
