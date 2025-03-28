-- { union }
-- 여러 출력물을 하나의 결과물로 {연결}하여 출력 시켜주는 일을 함.
-- 절대조건 : 출력컬럼 개수와 타입이 같아야 함.
-- union : 중복데이터 1개만 출력
-- union all : 중복 데이터 모두 출력

select empno, ename, comm, deptno from emp where deptno = 10
union
select empno, ename, sal, deptno from emp where deptno = 20;    -- comm, sal 둘다 number 타입

select deptno, dname from dept
union
select empno, ename from emp where deptno=10;

select empno,job,deptno from emp where sal > 1000
union
select empno,job,deptno from emp where deptno=20; -- 중복데이터 1개만 출력

select empno,job,deptno from emp where sal > 1000
union all   -- 모든데이터 출력
select empno,job,deptno from emp where deptno=20;