-- { function }

-- 예제 1. 매개변수의 합계를 구한다.
create function fn_sum(v_num1 in number, v_num2 in number)
    return number
is
    v_sum number;
begin
    v_sum := v_num1 + v_num2;
    return v_sum;
end;
/

-- > 함수에 들어가서 확인
select fn_sum(90,80) result from dual;
select sum(sal) from emp;

    
-- ========================================================================== --
-- 예제 2. 부서번호를 입력받아 해당 부서의 급여 합계를 구하는 함수
--create table
--create view
--create sequence

select fn_sum_sal(10) from dual;
create function fn_sum_sal(v_deptno in number)
    return number
is
    v_sum number;
begin
    select sum(sal) into v_sum from emp
        where deptno=v_deptno;
    return v_sum;
end;
/

select fn_sum_sal(20) from dual;
select '20번 부서의 급여합계 : ' || fn_sum_sal(20) as 급여합계 from dual;

-- -------------------------------------------------------------------------- --
    -- 풀어보기(1) 사원번호를 입력받아 급여+커미션을 리턴하는 함수작성
    --            null값은 0으로 처리하여 계산
    create function fn_emp_sal (v_empno emp.empno%type)
        return number
    is
        v_sal number := 0;
    begin
        select nvl(sal,0)+nvl(comm,0) into v_sal from emp
        where empno=v_empno;
    return v_sal;
    end;
    /
    select fn_emp_sal(7788) from dual;
    
    -- 풀어보기(2) 직원번호를 입력받아 부서명을 검색하는 함수작성
    -- or replace : (교체하다)삭제하고 다시만들어라
create or replace function fn_dept_name(v_empno in emp.empno%type )
        return varchar2
    is
        v_dname varchar2(50);
    begin 
        select dname into v_dname
         from emp e, dept d
        where e.deptno = d.deptno
          and e.empno=v_empno;

        return v_dname;
    end;
    /
    
    select fn_dept_name(7788) from dual;
    
--    -- ----------------------------------------- --
--    select
--        (select dname from dept where deptno=emp.deptno)
--    from
--        emp
--    where
--        empno =7788;
--    -- ---------------------------------------- --
--    select dname
--        from emp e, dept d
--    where e.deptno = d.deptno
--        and e.emp=7788;
--    
    -- 풀어보기(3) 사원번호를 입력받아 입사년차를 얻는다.
    -- 풀어보기(4) 해당 직원의 매니저 이름 출력

-- ================================================ --    
 --insert into dept (no.deptno,dname,loc)
 --values(fn_dept_no('dept'),fn_dept_deptno('dept'),'개발부','서울');

    -- 풀어보기 (5)
create or replace function fn_dept_deptno(p_tablename in varchar2)
        return number
    is
        v_no number;
    begin
        select nvl(max(deptno),0)+10 into v_no from dept;
        return v_no;
    end;
    /
    
    select fn_dept_no('dept') from dept;
-- ========================================================================== --
-- 예제 3.