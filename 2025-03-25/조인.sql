-- 1. 등가조인
--  => 기본조인 : 공통 데이터를 통한 연결

-- (1) 사원번호, 사원이름, 부서이름
select   empno
        ,ename
        ,dname
    from
        emp, dept
    where
        emp.deptno=dept.deptno;
        
-- (2) 사원번호, 사원이름, 부서이름, 부서번호
select   empno
        ,ename
        ,dname
        ,emp.deptno
    from
        emp, dept
    where
        emp.deptno=dept.deptno;

-- (3) 사원번호, 사원이름, 부서이름, 부서번호
select   e.empno    empno
        ,e.ename    ename
        ,d.dname    dname
        ,e.deptno   deptno
    from
        emp e, dept d
    where
        e.deptno = d.deptno;
        
-- (4) 번외 ~~ (2중 SELECT)
select   empno
        ,ename
        ,(select dname from dept where deptno=emp.deptno) dname
    from
        emp;
-- ------------------------------------------------------------------------- --
        
-- 2. 비 등가 조인
--  => 범위
-- (1) 기본설정 / 사원번호, 사원이름, 급여, 등급
select   empno
        ,ename
        ,sal
        ,grade
    from
        emp e, salgrade s
    where
        e.sal >= s.losal
    and
        e.sal <= s.hisal;
    -- 100 <= 200 <= 400
    -- 7839 KING 5000 5

-- (1) between 설정 / 사원번호, 사원이름, 급여, 등급
select   e.empno
        ,e.ename
        ,e.sal
        ,s.grade
    from
        emp e, salgrade s
    where
        e.sal between s.losal and s.hisal;
-- ------------------------------------------------------------------------- --
--{ between ~ and } ex) 1500이상 ~ 2000이하

select * from emp
    where sal between 1500 and 2000;
    
select * from emp
    where sal >= 1500
      and sal <= 2000;
      
-- { in } 10번 부서나 20번 부서에서 근무하는 직원
select * from emp
    where deptno in('10','20');
    
select * from emp
    where
        deptno ='10'
    or
        deptno ='20';
-- ------------------------------------------------------------------------- --
select   e.empno    empno
        ,e.ename    ename
        ,d.dname    dname
        ,e.deptno   deptno
    from
        emp e, dept d
    where
        e.deptno = d.deptno;

-- 3. 아웃터 조인{ outer join } (등가조인이외의 데이터까지 출력이 되는 세팅)

select   e.empno    empno
        ,e.ename    ename
        ,d.dname    dname
        ,e.deptno   deptno
    from
        emp e, dept d
    where
        -- 조인조건에 부합되지 않은 데이터까지 출력하라는 기호 "(+)"
        --e.deptno= d.deptno(+);
        e.deptno(+)= d.deptno;
-- ------------------------------------------------------------------------- --
select empno
      ,ename
      ,mgr
      ,(select ename from emp e1 where empno=e2.mgr) mgrname
    from
        emp e2;

-- 4. 셀프 조인 { self join }
-- (1) 사원번호, 사원이름, 매니저번호, 매니저이름
select e1.empno empno
      ,e1.ename ename
      ,e1. mgr  mgr
      ,e2.ename mgrname
    from
        emp e1, emp e2
    where
        e1.mgr = e2.empno;