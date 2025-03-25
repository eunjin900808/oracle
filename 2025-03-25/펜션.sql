-- { 펜션 }

-- 1. 룸정보 - roominfo
--  (1) 룸번호/rno - 숫자 - 고유값 - 1001
--  (2) 룸별칭/ras - 문자열 - 
--  (3) 룸가격/rprc - 숫자
--  (4) 룸크기rsiz - 숫자
-- 2. 예약정보 - resinfo
--  (1) 예약번호/resno - 숫자 - 고유값 - 10000
--  (2) 룸번호/rno - 숫자 - 외래키설정
--  (3) 숙박시작일/sdt - 날짜 
--  (4) 숙박종료일/edt - 날짜 
--  (5) 예약자/usrid - 문자 -> 아이디
--  (6) 결제여부/pay - 문자 -> Y/N
-- 3. 회원정보 - p_member
--  (1) 아이디/usrid - 문자 -> 고유값
--  (2) 암호/pass - 문자
--  (3) 이름/name - 문자
--  (4) 연락처/phone - 문자
--  (5) 등록일/regdt - 날짜

create table roominfo(
rno number primary key,             -- 1001
ras varchar2(50),
rprc number default 50000 not null, -- 원
rsiz number default 15              -- 평수
);

create table resinfo(
resno number primary key,   -- 10001
rno number not null,
sdt date,
edt date,
usrid varchar2(50) not null,
pay char(1) default 'N',
constraint resinfo_fk foreign key(rno)
                      references roominfo(rno),
constraint resinfo_ck check(pay in('Y','N'))
);

create table p_member(
usrid varchar2(50) primary key,
pass varchar2(100) not null,
name varchar2(50),
phone varchar2(50) not null,
regdt date
);

insert into roominfo values
(1001,'별사랑방','150000','15');
insert into roominfo values
(1002,'달이야기','200000','20');
insert into roominfo values
(1003,'바다뷰','300000','30');
insert into roominfo values
(1004,'산뷰','250000','25');
commit;


insert into p_member values('a1','1111','홍길동','010-3333-8888','2025-03-21');
insert into p_member values('a2','121212','차범근','010-5325-9499','2025-03-23');
insert into p_member values('a3','32322','손흥민','010-6556-7756','2025-03-25');


-- 1. 각 테이블들의 기본 출력
select RNO
      ,RAS
      ,RPRC
      ,RSIZ
from roominfo;

select RESNO
      ,RNO
      ,SDT
      ,EDT
      ,USRID
      ,PAY
from resinfo;

select USRID
      ,PASS
      ,NAME
      ,PHONE
      ,REGDT
from p_member;

-- 2. 예약번호/입실일(년-월-일)/퇴실일(년-월-일)/사용자ID
select resno 예약번호
      ,to_char(sdt,'yyyy-mm-dd') 입실일
      ,to_char(edt,'yyyy-mm-dd') 퇴실일
      ,usrid 사용자ID
from resinfo;
-- 3. 예약번호/방번호/방가격/입실일(년-월-일)/퇴실일(년-월-일)/사용자ID - 조인
select res.resno                            resno
      ,res.rno                              rno
      ,to_char(room.rprc,'FM999,999,999')   rprc
      ,to_char(res.sdt,'yyyy-mm-dd')        sdt
      ,to_char(res.edt,'yyyy-mm-dd')        edt
      ,res.usrid                            usrid
    from
        resinfo res, roominfo room
    where
        res.rno = room.rno;
-- 4. 예약번호/입실일(년-월-일)/퇴실일(년-월-일)/사용자ID/연락처 - 조인
select res.resno                            resno
      ,to_char(res.sdt,'yyyy-mm-dd')        sdt
      ,to_char(res.edt,'yyyy-mm-dd')        edt
      ,res.usrid                            usrid
      ,p.phone                              phone
    from
        resinfo res, p_member p
    where
        res.usrid = p.usrid;
-- 5. 예약번호/입실일(년-월-일)/퇴실일(년-월-일)/사용자ID - 작년에 등록한 정보
select resno                        resno
      ,to_char(sdt,'yyyy-mm-dd')    sdt
      ,to_char(edt,'yyyy-mm-dd')    edt
      ,usrid                        usrid
    from
        resinfo
    where
        to_char(sdt,'yyyy') = (to_char(sysdate,'yyyy')-1);

-- 6. 예약번호/입실일(년-월-일)/퇴실일(년-월-일)/결재여부(결재완료/미결재)
select resno                                    resno
      ,to_char(sdt,'yyyy-mm-dd')                sdt
      ,to_char(edt,'yyyy-mm-dd')                edt
      ,usrid                                    usrid
      ,decode(pay,'Y','결재완료','N','미결재')    pay
    from
        resinfo;

