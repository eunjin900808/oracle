-- 부서테이블 : BOSTON을 검색조건으로 조회한다. (부서번호, 부서이름)

declare
    v_deptno dept.deptno%type;  -- 테이블 컬럼 타입을 따르겠다.
    v_dname dept.dname%type;
begin
    select deptno,dname into v_deptno,v_dname from dept
    where loc='BOSTON';
    dbms_output.put_line(v_deptno ||','|| v_dname);
end;
/

-- 사원번호가 7788인 사원의 사원이름, 업무를 출력한다.
declare
 v_ename emp.ename%type;        -- 출력용도
 v_job emp.job%type;            -- 출력용도
begin
 select ename, job into v_ename,v_job from emp
 where empno ='7788';
 
 dbms_output.put_line(v_ename || ',' || v_job);
end;
/

-- -------------------------------------------------------------------------- --
declare
 v_deptno number := 90;
 v_dname varchar2(100) := '총무부';
 v_loc varchar2(100) := '부산';
begin
 insert into dept values(v_deptno, v_dname, v_loc);
 dbms_output.put_line('저장완료!!');
end;
/

-- 매개변수 : 외부데이터 값을 받는 변수
-- 매개변수 : 받는 용도로만 사용, 일반변수 처럼 사용불가
declare
 v_deptno number := &p_deptno;
 v_dname varchar2(100) := '&p_dname';
 v_loc varchar2(100) := '&p_loc';
begin
 insert into dept values(v_deptno, v_dname, v_loc);
 dbms_output.put_line('저장완료!!');
end;
/

-- ========================================================================== --
-- 풀어보기 1. emp테이블에서 부서번호 10인 데이터들의 평균 급여를 구하라.
declare
 v_deptno number := &p_deptno;
 v_sum_sal number;
begin
 select sum(sal) into v_sum_sal from emp
    where deptno=v_deptno;
    dbms_output.put_line(v_deptno || '번 부서의 평균급여는 ' || v_sum_sal || '입니다.');
end;
/
-- 풀어보기 2. emp 테이블의 부서번호 10의 모든 comm필드에 400 더하기(단 , null은 0으로 처리하여 연산)
declare
 v_comm emp.comm%type := 400;
begin
 update emp
    set comm = nvl(comm,0)+v_comm
 where deptno = 10;
end;
/

-- nvl 은 null 경우에만 세팅
update emp set comm=nvl(comm,0)+400 where deptno=10;
select * from emp where deptno=10;
rollback;

-- nvl2는 null인 경우와 null이 아닌경우 2가지 세팅 가능
update emp set comm=nvl2(comm,comm,0)+400 where deptno=10;
select * from emp where deptno=10;
rollback;

-- decode 함수를 쓰는경우
update emp set comm=decode(comm,null,0,comm)+400 where deptno=10;
select * from emp where deptno=10;
rollback;

declare
 v_deptno number := &부서번호;
 v_comm number := &수당;
begin
 update emp set comm=nvl(comm,0)+v_comm where deptno=v_deptno;
 dbms_output.put_line(v_deptno || '번 부서에 수당을 ' || v_comm || '증가 시켰습니다.');
end;
/
select * from emp where deptno=10;


-- ========================================================================== --
-- { 조건문 }
-- 1.
declare
 v_deptno number := &부서번호;
 v_comm number := &수당;
 v_cnt number;
begin
 select count(*) into v_cnt from emp where deptno=v_deptno;
    if v_cnt = 0 then
     dbms_output.put_line('해당 부서에 속한 사원이 없습니다.');
    else
     update emp set comm=nvl(comm,0)+v_comm where deptno=v_deptno;
     dbms_output.put_line(v_deptno || '번 부서에 수당을 ' || v_comm || '증가 시켰습니다.');
    end if;
end;
/

-- 2.

-- ========================================================================== --
-- { 반복문 }
-- 1. LOOP문
declare
    cnt number := 0;
begin
    loop
        cnt := cnt+1;
        dbms_output.put_line(cnt);
        exit when cnt >= 10;
    end loop;
end;
/

-- 2. FOR문  - 잘쓰지않는다.
declare

begin
    for i in 5..10      -- in 뒤에는 반드시 작은숫자 -> 큰숫자 순으로 와야한다
    loop
        dbms_output.put_line(i);
    end loop;
end;
/

-- -------------------------------------------------------------------------- --
declare

begin
    for i in reverse 1..10      -- reverse : 역으로 실행
    loop
        dbms_output.put_line(i);
    end loop;
end;
/

-- -------------------------------------------------------------------------- --
declare
    a number := 1;
begin
    for i in 1..10
    loop
        dbms_output.put_line(a);
        a := a+2;
    end loop;
end;
/



-- -------------------------------------------------------------------------- --
-- 구구단
declare
    dan number := 2;
    cnt number := 1;
begin
    loop
        dbms_output.put_line(dan || 'x' || cnt || '=' || dan*cnt);
        cnt := cnt+1;
        exit when cnt = 10;
    end loop;
end;
/

-- ========================================================================== --
-- 풀어보기 1.
-- - 사원번호 -
-- (1) 없는 사원번호입니다
-- (2) 사원번호/사원명/급여(+커미션)/입사년도/부서명
declare
 v_empno number := &사원번호;
 v_cnt number;
 v_ename varchar2(100);
 v_sal number;
 v_year number;
 v_dname varchar2(100);
begin
 select count(*) into v_cnt from emp where empno=v_empno;
 if v_cnt = 0 then
    dbms_output.put_line( v_empno || '없는 사원번호 입니다.');
 else
    select ename
          ,(sal+nvl(comm,0))
          ,to_char(hiredate,'yyyy')
          ,dname
        into
            v_ename
           ,v_sal
           ,v_year
           ,v_dname
    from emp e, dept d
    where e.deptno = d.deptno
    and e.empno = v_empno;
    dbms_output.put_line( '사원번호:' || v_empno);
    dbms_output.put_line( '사원이름:' || v_ename);
    dbms_output.put_line( '사원급여:' || v_sal);
    dbms_output.put_line( '입사년도:' || v_year);
    dbms_output.put_line( '부서이름:' || v_dname);
 end if;
end;
/

-- ----------------------------- --
select empno
      ,ename
      ,(sal+nvl(comm,0))
      ,to_char(hiredate,'yyyy')
      ,dname
    from emp e, dept d
    where e.deptno = d.deptno
    and e.empno = 7788;
    
-- -------------------------------------------------------------------------- --

-- 풀어보기 2.
-- (1)
declare
 v_deptno number := '&부서번호';
 v_dname varchar2(100) := '&부서이름';
 v_loc varchar2(100) := '&부서위치';
 v_cnt number;
begin
 select count(*) into v_cnt from dept
    where deptno = v_deptno;
    if v_cnt = 0 then
     insert into dept values(v_deptno,v_dname,v_loc);
     dbms_output.put_line('저장처리 되었습니다.');
    else
     update dept set dname=v_dname, loc=v_loc
     where deptno=v_deptno;
     dbms_output.put_line('업데이트 처리 되었습니다.');
    end if;
end;
/
select * from dept;