-- 2. 자주 쓰이는 함수 적용
-- (1)
select max(sal), min(sal) from emp;
select count(*), max(sal), min(sal) from emp; -- 단일 그룹 함수는 같이 쓸 수 있다.
select distinct(job) from emp where job != 'PRESIDENT';

-- select distinct(job), count(*), max(sal), min(sal) from emp; -- 단일그룹함수가 아니면 섞일수없음
/* select (select distinct(job) from emp where job ='PRESIDENT')
    , count(*)
    , max(sal)
    , min(sal)
from emp;
*/
-- (2)(3)
select sum(sal) sumSal
      ,round(avg(sal),2) avgSal
      ,max(sal) maxSal
      ,min(sal) minSal
from emp;

-- (4)
-- ceil() : 올림(소수점아래), floor() : 내림(소수점아래)
select sum(sal) sumSal
      ,round(avg(sal),2) avgSal
      ,ceil(avg(sal)) ceilSal
      ,floor(avg(sal)) floorSal      
      ,max(sal) maxSal
      ,min(sal) minSal
from emp;

-- (5) 커미션의 평균, 합계
select sum(comm)
      ,avg(comm)
from emp;

-- (1)
select max(sal) from emp where deptno='10'; 
-- (2)
select * from emp where sal >= 1000 and sal <=2000;
-- (3)
select * from emp where deptno = '10' or deptno = '20' or deptno = '30';

select * from emp where deptno in ('10','20','30');
-- (4)
select * from emp where mgr='7566';
select * from emp where mgr in ('7566');
-- (5)
select count(*) from emp where job = 'ANALYST';
select count(*) from emp where upper(job)=upper ('ANALYST');
-- (6)(7)
select ename
      ,to_char(hiredate,'yyyy/mm/dd') hiredate
    from emp
    where to_number(to_char(hiredate, 'yyyy')) >= 2000;
