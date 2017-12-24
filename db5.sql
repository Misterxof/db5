-----1-----
DROP VIEW oldempnos;

CREATE VIEW oldempno AS 
SELECT * 
FROM emp
WHERE MONTHS_BETWEEN(SYSDATE, birthdate) / 12 >= 60;

SELECT * FROM oldempno;

INSERT INTO oldempno VALUES(7777, 'SIMON', to_date('07-Dec-1940'), 7789);

SELECT * FROM emp
WHERE empname = 'SIMON';

-----2-----
DROP VIEW fair;

CREATE VIEW fair AS
SELECT empno, empname, enddate, deptname, jobname 
FROM emp
JOIN career USING(empno)
JOIN dept USING(deptno)
JOIN job USING(jobno)
WHERE enddate IS NOT NULL;

SELECT * FROM fair;

INSERT INTO fair VALUES(8888, 'SIMSON', to_date('01-Oct-2000'), 'SALES', 'CLERK');

-----3-----
DROP VIEW erned;

CREATE VIEW erned AS
SELECT empname "Sotrudnic", jobname "Dolzhnost", SUM(salvalue) "Itogo_3_kv"
FROM emp
JOIN career USING(empno)
JOIN job USING(jobno)
JOIN salary USING(empno)
WHERE year = 2010 AND month >= 9 AND month <= 12
GROUP BY empname, jobname;

SELECT * FROM erned;

-----4-----
DROP VIEW month_salary;

CREATE VIEW month_salary AS
SELECT empname, (month || ', ' || salvalue) "Month_Salary"
FROM fair
JOIN salary USING(empno)
WHERE 2 < (SELECT count(empname)
FROM fair f
JOIN salary USING(empno)
WHERE f.empname = empname);

SELECT * FROM month_salary;

;
