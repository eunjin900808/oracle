CREATE TABLE  DEPT
(
  DEPTNO  NUMBER(2),     -- 부서번호
  DNAME   VARCHAR2(14),  -- 부서이름
  LOC     VARCHAR2(13)    -- 부서위치
);

insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');
  

CREATE TABLE  EMP
(
  EMPNO     NUMBER(4),      -- 사원번호
  ENAME     VARCHAR2(10),   -- 사원이름 
  JOB       VARCHAR2(9),     -- 업무 
  MGR       NUMBER(4),      -- 매니저
  HIREDATE  DATE,           -- 입사일
  SAL       NUMBER(7,2),     -- 급여
  COMM      NUMBER(7,2),    -- 추가급여
  DEPTNO    NUMBER(2)      -- 부서번호
);

insert into emp values( 7839, 'KING', 'PRESIDENT', null, to_date('1991-11-17','yyyy-mm-dd'), 5000, null, 10);
insert into emp values( 7698, 'BLAKE', 'MANAGER', 7839, to_date('1992-1-05','yyyy-mm-dd'), 2550, null, 30);
insert into emp values( 7782, 'CLARK', 'MANAGER', 7839, to_date('1999-9-06','yyyy-mm-dd'), 1800, null, 10);
insert into emp values( 7566, 'JONES', 'MANAGER', 7839, to_date('2001-02-04','yyyy-mm-dd'), 1500, null, 20);
insert into emp values( 7788, 'SCOTT', 'ANALYST', 7566, to_date('2015-06-17','yyyy-mm-dd'), 700, null, 20);
insert into emp values( 7902, 'FORD', 'ANALYST', 7566, to_date('2010-03-12','yyyy-mm-dd'), 750, null, 20);
insert into emp values( 7369, 'SMITH', 'CLERK', 7902, to_date('2007-12-1','yyyy-mm-dd'), 800, null, 20);
insert into emp values( 7499, 'ALLEN', 'SALESMAN', 7698, to_date('20-2-2020','dd-mm-yyyy'), 400, 300, 30);
insert into emp values( 7521, 'WARD', 'SALESMAN', 7698, to_date('22-2-2019','dd-mm-yyyy'), 400, 500, 30);
insert into emp values( 7654, 'MARTIN', 'SALESMAN', 7698, to_date('28-9-2018','dd-mm-yyyy'), 420, 200, 30);
insert into emp values( 7844, 'TURNER', 'SALESMAN', 7698, to_date('8-9-2018','mm-dd-yyyy'), 420, 0, 30);
insert into emp values( 7876, 'ADAMS', 'CLERK', 7788, to_date('13-7-2010', 'dd-mm-yyyy'), 750, null, 20);
insert into emp values( 7900, 'JAMES', 'CLERK', 7698, to_date('3-12-2009','mm-dd-yyyy'), 750, null, 30);
insert into emp values( 7934, 'MILLER', 'CLERK', 7782, to_date('2023-1-23','yyyy-mm-dd'), 320, null, 10);
  
CREATE TABLE salgrade (
grade number,    -- 등급
losal number,     -- 최저급여
hisal number );   -- 최고급여

insert into salgrade values (1, 100,400);
insert into salgrade values (2, 401,800);
insert into salgrade values (3, 801,1200);
insert into salgrade values (4, 1201,1500);
insert into salgrade values (5, 1501,9999);
