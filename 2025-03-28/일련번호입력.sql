-- # 컬럼추가 -> no 숫자
    alter table dept add no number;
-- # 부서테이블에 일련번호 입력하기

declare
    v_number number:= 10;
    v_no number := 1;
begin
    loop
    update dept set no=v_no where deptno = v_number;
    
    v_number := v_number + 10;
    v_no := v_no +1;
    
    exit when v_number > 90;
    end loop;
end;
/

