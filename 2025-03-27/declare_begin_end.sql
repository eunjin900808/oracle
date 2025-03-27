-- 연봉을 12로 나누어 결과를 출력
declare
    v_sal number := 3000;
    m_sal number;
    v_eng number := 98;
    v_ret number;
begin
    m_sal := v_sal/12;
    -- v_ret := v_eng + 10;
    v_ret := mod(v_eng,10); -- mod : 나눈 나머지값 (% 안됨)
    dbms_output.put_line('내 급여는 ' ||m_sal|| '입니다.');
    dbms_output.put_line('결과:' ||v_ret);
end;
/