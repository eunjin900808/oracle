-- { 펜션 문제 }

-- (7) 예약정보를 최근일 순으로 출력
-- 예약번호/방번호/입실일/퇴실일/사용자ID/결재여부
select resno                                        resno
      ,rno                                          rno
      ,to_char(sdt,'yyyy-mm-dd')                    sdt
      ,to_char(edt,'yyyy-mm-dd')                    edt
      ,usrid                                        usrid
      ,decode(pay,'Y','결재완료','N','미결재')        pay
    from resinfo order by sdt desc;
-- -------------------------------------------------------------------------- --
-- rownum - 번호붙이기 (order by desc때문에 거꾸로출력 되기떄문에 select로 감싼다음 rownum)
select b.* from(
    select rownum rn,a.* from(
        select resno                                        resno
              ,rno                                          rno
              ,to_char(sdt,'yyyy-mm-dd')                    sdt
              ,to_char(edt,'yyyy-mm-dd')                    edt
              ,usrid                                        usrid
              ,decode(pay,'Y','결재완료','N','미결재')        pay
            from resinfo
            order by sdt desc) a ) b
-- where rn >= 1 and rn <= 10;
-- where rn >= 11 and rn <= 20;
where rn between 1 and 10;

-- ========================================================================== --
-- (8) 2025년 01월의 이용정보출력
-- 예약번호/방번호/입실일/퇴실일
select resno                                        resno
      ,rno                                          rno
      ,to_char(sdt,'yyyy-mm-dd')                    sdt
      ,to_char(edt,'yyyy-mm-dd')                    edt
    from resinfo
    where to_char(sdt,'yyyy-mm') = '2025-01'; 

-- ========================================================================== --    
-- (9) 아이디 'a1' 회원의 이용정보를 출력 (최근 이용 순으로 출력)
-- 예약번호/방번호/입실일/퇴실일
select resno                                        resno
      ,rno                                          rno
      ,to_char(sdt,'yyyy-mm-dd')                    sdt
      ,to_char(edt,'yyyy-mm-dd')                    edt
    from resinfo
    where usrid = 'a1'
    order by sdt desc;

-- 사용자ID/연락처/예약번호/입실일/퇴실일/룸번호/금액
select res.usrid                                      usrid
      ,p.phone                                        phone
      ,res.resno                                      resno
      ,to_char(res.sdt,'yyyy-mm-dd')                  sdt
      ,to_char(res.edt,'yyyy-mm-dd')                  edt
      ,res.rno                                        rno  -- 룸번호
      ,room.rprc                                      rprc -- 룸(단가)
    from resinfo res, p_member p, roominfo room
    where
            res.usrid = p.usrid
        and
            res.rno = room.rno
        and
         res.usrid = 'a1'
    order by res.sdt desc;
-- ========================================================================== --    
-- (10) 사용자별 이용회수를 출력,1/2 ,10/11
-- 사용자ID/연락처/숙박회수
select usrid                                              usrid
      ,phone                                              phone
      ,(select count(*) from resinfo where usrid = usrid) cnt
    from p_member p;                    -- ↑ 컬럼 = ↑ 데이터
-- ========================================================================== --      
-- (11) 이용별 금액을 출력
-- 예약번호/방번호/입실일/퇴실일/숙박수
select usrid                                      usrid
      ,resno                                      resno
      ,to_char(sdt,'yyyy-mm-dd')                  sdt
      ,to_char(edt,'yyyy-mm-dd')                  edt
      ,(to_date(edt,'yyyy-mm-dd') - to_date(sdt,'yyyy-mm-dd'))
        ||'/'|| (to_date(edt,'yyyy-mm-dd') - to_date(sdt,'yyyy-mm-dd')+1) result
    from resinfo;
-- -------------------------------------------------------------------------- --    
    -- ex)
        select ('2025-03-25') - ('2025-03-22') from dual;   -- 문자 빼기 문자 안됨
        select (to_date('2025-03-25','yyyy-mm-dd') - to_date('2025-03-23','yyyy-mm-dd')) ||'/'||
               (to_date('2025-03-25','yyyy-mm-dd') - to_date('2025-03-23','yyyy-mm-dd')+1)
            from dual;

    -- ex)
        select resno
              ,sdt
              ,edt
              ,(edt-sdt)|| '/' || (edt-sdt+1) result
            from resinfo;
-- -------------------------------------------------------------------------- --
-- 예약번호/방번호/입실일/퇴실일/숙박수/금액(단가*숙박일)
select res.resno                                                resno
      ,res.rno                                                  rno
      ,to_char(res.sdt,'yyyy-mm-dd')                            sdt
      ,to_char(res.edt,'yyyy-mm-dd')                            edt
      ,(res.edt-res.sdt)|| '/' || (res.edt-res.sdt+1)           result
      ,to_char((room.rprc * (res.edt-res.sdt)),'FM999,999,999') money
    from
        resinfo res, roominfo room
    where
        res.rno = room.rno;

-- ========================================================================== --
-- (12) 작년도 매출액을 출력
-- 2024년 매출액 : 000,000원
select sum(rprc) from roominfo;

select res.resno                                        resno
      ,res.rno                                          rno
      ,to_char(room.rprc,'FM999,999,999')               rprc
      ,to_char(res.sdt,'yyyy-mm-dd')                    sdt
      ,to_char(res.edt,'yyyy-mm-dd')                    edt
      ,to_char((room.rprc * (edt-sdt)),'FM999,999,999') money
    from
        resinfo res, roominfo room
    where
        res.rno = room.rno
     and
        res.pay = 'Y'
     and
        to_char(res.sdt,'yyyy') = '2024';
-- -------------------------------------------------------------------------- --
select ('2024년 매출액 : ' || to_char(sum (room.rprc * (edt-sdt)),'FM999,999,999')) salesum
    from
        resinfo res, roominfo room
    where
        res.rno = room.rno
     and
        res.pay = 'Y'
     and
        to_char(res.sdt,'yyyy') = '2024';

-- ========================================================================== --
-- (13) 룸별 이용 회수를 출력
-- 룸번호/이용회수
select rno
      ,(select count(*) from resinfo where rno = room.rno) totalcnt
    from roominfo room;