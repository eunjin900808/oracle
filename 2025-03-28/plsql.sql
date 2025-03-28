-- {plsql}

-- 풀어보기 4.
-- (1) 부서테이블의 정보를 삭제
--  (조건: 올바른 부서번호인지 체크/사원테이블에서 소속 직원의 유무 체크)
set serveroutput on;
declare
 v_deptno number := '&삭제할부서번호';
 v_cnt number;
 v_cnt2 number;
begin
 select count(*) into v_cnt from dept where deptno = v_deptno;
 if v_cnt = 0 then
    dbms_output.put_line(v_deptno || '부서번호는 없는 번호입니다.');
 else
    select count(*) into v_cnt2 from emp where deptno=v_deptno;
    if v_cnt2 = 0 then
        delete from dept where deptno = v_deptno;
        dbms_output.put_line('해당 부서정보를 삭제했습니다.');
    else
        dbms_output.put_line('해당 부서에 소속 사원들이 ' || v_cnt2 || '명 있습니다.(삭제불가)');
    end if;
 end if;
end;
/

-- ========================================================================== --

-- 풀어보기 5.
-- ## 코드번호 일괄 입력처리 ##
--  ** goods1 -> code/name -> c1 ~ c10
-- (처리)
--  (1) "goods11"테이블의 존재여부
--  (2) 비존재시 생성
--  (3) 반복문을 이용한 데이터 입력

select * from all_tables where table_name='EMP';
-- -------------------------------------------------------------------------- --
-- 루프따로 테이블따로 실행~.~
declare
    v_cnt1 number;
    v_number number := 1;
begin
    select count(*) into v_cnt1 from all_tables where table_name='GOODS7';
    if v_cnt1 = 0 then
        execute immediate 'create table goods7( code varchar2(10), name varchar2(10))';
    end if;
--  -------------------------------------------------------------------------
    loop
     insert into goods7(code) values('c' || v_number);
     v_number := v_number+1;
     exit when v_number > 10;
    end loop;
    dbms_output.put_line('저장완료!!');
end;
/
