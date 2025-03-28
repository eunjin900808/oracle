declare
 v_number number := 1;
 v_code varchar2(10); 
begin
    loop
        if v_number < 10 then
            v_code := 'c000' || v_number;
        elsif v_number < 100 then
            v_code := 'c00' || v_number;
        elsif v_number < 1000 then
            v_code := 'c0' || v_number;
        else
            v_code := 'c' || v_number;
        end if;
        
        insert into goods7(code) values(v_code);
        v_number := v_number+1;
        
        exit when v_number > 10000;
    end loop;
end;
/

select min(code), max(code) from goods7;

select * from goods7 order by code;
-- -------------------------------------------------------------------------- --
