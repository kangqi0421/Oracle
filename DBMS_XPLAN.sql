--DISPLAY - to format and display the contents of a plan table.
--DISPLAY_AWR - to format and display the contents of the execution plan of a stored SQL statement in the AWR.
--DISPLAY_CURSOR - to format and display the contents of the execution plan of any loaded cursor.
--DISPLAY_SQL_PLAN_BASELINE - to display one or more execution plans for the SQL statement identified by SQL handle
--DISPLAY_SQLSET - to format and display the contents of the execution plan of statements stored in a SQL tuning set.

-----
-- в сесии
EXPLAIN PLAN FOR
SELECT * FROM emp e, dept d
   WHERE e.deptno = d.deptno
   AND e.ename='benoit';


SET LINESIZE 130
SET PAGESIZE 0
SELECT * FROM table(DBMS_XPLAN.DISPLAY);

-----

-- в сесии
SELECT ename  FROM  emp e, dept d 
   WHERE   e.deptno = d.deptno  
   AND   e.empno=7369;
   
   
SET PAGESIZE 0
SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR);

-- либо в другой сессии предварительно отыскав sql_id

SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('3qb5qfkqbthvx',0));

------

-- План из AWR

SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('atfwcg8anrykp'));

-----------

-- План из BASELINE

SET LINESIZE 150
SET PAGESIZE 2000
SELECT t.*
  FROM TABLE(DBMS_XPLAN.DISPLAY_SQL_PLAN_BASELINE(
                 'SYS_SQL_b1d49f6074ab95af')) t;
                 
----

-- План из SQLSET

SELECT * FROM table (
   DBMS_XPLAN.DISPLAY_SQLSET(
       'OLTP_optimization_0405','gwp663cqh5qbf', 3693697075));
                        
