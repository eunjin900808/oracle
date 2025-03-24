-- [구매테이블]
-- {생성}
-- 1. 시퀀스 생성
create sequence book_seq
start with 1
increment by 1
maxvalue 99999;
-- 2. 구매테이블 생성
-- primary key : 중복방지(고유값보장), 빠른검색(인덱스테이블등록)
create table book(
seqid number not null primary key,
code varchar2(50) not null,
subject varchar2(100) not null,
price number default 0,
saledt timestamp
);
-- {입력}
-- 1 -> {'a101','java책','5000','2025-03-01 01:30:10'}
-- 2 -> {'a102','html책','','2025-03-03 22:30:10'}
-- 3 -> {'a103','리눅스책','1500','2025-03-03 15:30:10'}
insert into book(SEQID
                ,CODE
                ,SUBJECT
                ,PRICE
                ,SALEDT)
            values(book_seq.nextval
                  ,'a101'
                  ,'java책'
                  ,'5000'
                  ,sysdate);
insert into book(SEQID
                ,CODE
                ,SUBJECT
                ,PRICE
                ,SALEDT)
            values(book_seq.nextval
                  ,'a102'
                  ,'html책'
                  ,''
                  ,'2025-03-03 22:30:10');
insert into book(SEQID
                ,CODE
                ,SUBJECT
                ,PRICE
                ,SALEDT)
            values(book_seq.nextval
                  ,'a103'
                  ,'리눅스책'
                  ,'1500'
                  ,'2025-03-03 15:30:10');
                  
commit;

-- {출력}
-- 1. 전체 출력(최근데이터순 출력) - 기본출력
select SEQID    SEQID
      ,CODE     CODE
      ,SUBJECT  SUBJECT
      ,PRICE    PRICE
      ,to_char(SALEDT,'yyyy-mm-dd')   SALEDT
from book;
-- 2. 아이디, 상품명, 결제여부
select CODE     아이디
      ,SUBJECT  상품명
      ,nvl2(price,'결제완료','미결재')결제여부
      -- NVL2(데이터값, 널값이아닌경우, 널값인경우)
from book;
--  a101 java책 결제완료
--  a102 html책 미결재
--  a103 리눅스책 결제완료

-- =================================================================
create table member1 (
seqid number primary key,               -- primary key : 중복방지, not null(내장 되어있음)
userid varchar2(50) not null unique,    -- unique : 중박방지, not null(내장되어있지 않음)
pas varchar2(100) not null,
name varchar2(50),
gender char(1) check(gender in('M','F')),
birth date default '1900-01-01',
regdt timestamp
);

comment on table member1 is '회원정보테이블1';
comment on column member1.seqid is '고유번호';
comment on column member1.userid is '사용자ID';

create table member2(
seqid number,                   -- primary key
userid varchar2(50) not null,   -- unique
pass varchar2(100) not null,
name varchar(50),
gender char(1),                 -- check
birth date default '1900-01-01',
regdt timestamp,
-- (제약조건 키워드) (제약조건 별칭) (제약조건 이름)
  constraint member2_seqid_pk primary key(seqid),
  constraint member2_userid_un unique(userid),
  constraint member2_gender_ck check(gender in('M','F'))
);

insert into member2 values
('1','test1','1234','테스트1','M','2000-05-05',sysdate);

-- 고유번호 중복 시 오류 메세지 --
insert into member2 values
('1','test2','1234','테스트2','F','2000-07-05',sysdate);
-- ORA-00001: 무결성 제약 조건(C##JAVA.MEMBER2_SEQID_PK)에 위배됩니다
insert into member2 values
('','test2','1234','테스트2','F','2000-07-05',sysdate);
-- SQL 오류: ORA-01400: NULL을 ("C##JAVA"."MEMBER2"."SEQID") 안에 삽입할 수 없습니다
-- 사용자ID 중복 시 오류 메세지 --
insert into member2 values
('2','test1','1234','테스트2','F','2000-07-05',sysdate);
-- ORA-00001: 무결성 제약 조건(C##JAVA.MEMBER2_USERID_UN)에 위배됩니다
-- 사용자ID 공백 시 오류 메세지 --
insert into member2 values
('2','','1234','테스트1','F','2000-07-05',sysdate);
-- SQL 오류: ORA-01400: NULL을 ("C##JAVA"."MEMBER2"."USERID") 안에 삽입할 수 없습니다
insert into member2 values
('2','test2','1234','테스트1','F','2000-07-05',sysdate);
insert into member2 values
('3','test3','1111','테스트3','F','',sysdate);

insert into member2(SEQID,USERID,PASS,NAME,GENDER,BIRTH,REGDT)
values('4','test4','1111','테스트4','M','',sysdate);


create table member3(
seqid number,
userid varchar2(50) not null,
pass varchar2(100) not null,
name varchar(50) not null,
gender char(1) not null,
birth date default '1900-01-01' not null,
regdt timestamp,

  constraint member3_seqid_pk primary key(seqid),
  constraint member3_userid_un unique(userid),
  constraint member3_gender_ck check(gender in('M','F'))
);

-- {외래키} - foreign key :: 컬럼 대 컬럼 연결
-- 1. 외래키 설정은 자식 테이블에서 설정한다.(부모테이블의 설정은 없음)
-- 2. 부모 테이블에서 관계설정의 컬럼은 반드시 고유값이어야 한다.
-- 3. 자식테이블에서 데이터 입력 시 외래키 설정 컬럼 값은 반드시 부모테이블에 존재해야함
-- 4. 부모테이블에서 데이터 삭제 시 자식테이블의 정보가 잇는 경우 삭제 불가 처리됨.

--============================================================================--

create table jumsu(
seqid number not null,
eng number,
kor number,
userid varchar2(50) not null,
constraint jumsu_fk foreign key(userid)
                    references member2(userid)
);
-- -------------------------------------------------------------------------- --
create table jumsu2(
seqid number not null,
eng number,
kor number,
p_userid varchar2(50) not null,
constraint jumsu2_fk foreign key(p_userid)
                    references member2(userid)
);
-- -------------------------------------------------------------------------- --
create table jumsu3(
seqid number not null,
eng number,
kor number,
p_seqid number not null,
constraint jumsu3_fk foreign key(p_seqid)
                    references member2(seqid)
);
-- -------------------------------------------------------------------------- --
create table jumsu4(
seqid number not null,
eng number,
kor number,
p_seqid number not null,
constraint jumsu3_fk foreign key(p_seqid)
                    references member2(seqid)
);
-- === 오류발생 같은 이름의 별칭을 사용하지 못함 == --
-- -------------------------------------------------------------------------- --
create table jumsu5(
seqid number not null,
eng number,
kor number,
p_name varchar2(50) not null,
constraint jumsu5_fk foreign key(p_name)
                    references member2(name)
);
-- === 오류발생 일치하는 고유 또는 기본 키가 없습니다. 즉, 고유값 설정의 컬럼이 아닌경우 오류발생 == --
-- -------------------------------------------------------------------------- --
-- {데이터 입력}
insert into jumsu values('1','90','80','test1');

insert into jumsu values('1','90','80','test111');
-- 무결성 제약조건(C##JAVA.JUMSU_FK)이 위배되었습니다- 부모 키가 없습니다

insert into jumsu values('2','80','70','test2');    -- 입력 성공
insert into jumsu values('3','50','30','test2');    -- 입력 성공
insert into jumsu values('4','67','45','test2');

-- {데이터 삭제}
-- (실습1) 부모테이블의 데이터를 삭제 시도(자식데이터가 있는 경우)
          delete from member2 where userid = 'test1';   -- 실패
          --무결성 제약조건(C##JAVA.JUMSU_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- (실습2) 부모테이블의 데이터를 삭제 시도(자식데이터가 없는 경우)
          delete from member2 where userid = 'test3';   -- 성공(자식 레코드가 없음)
-- (실습3) 부모테이블의 데이터를 삭제 시도(자식데이터가 없는 경우)
       -- (1) 자식 테이블의 레코드를 먼저 삭제/ 부모테이블의 레코드 삭제 시도
       
-- -------------------------------------------------------------------------- --
-- {댓글 게시판}
create table board2(
seqid number,
title varchar2(100) not null,
content varchar2(4000),
regdt date default '1900-01-01' not null,
hits number default 0 not null,
constraint board2_seqid_pk primary key(seqid)
);

create table board2sub(
seqid   number primary key,
content varchar2(1000),
regdt   date default '1900-01-01' not null,
p_seqid number not null,
constraint board2sub_fk
           foreign key(p_seqid)
           references board2(seqid)
           on delete cascade        -- 부모/자식레벨 데이터 동시 삭제
);

insert into board2 values('1','aa1','ccc1',sysdate,'0');
insert into board2 values('2','aa2','ccc2',sysdate,'0');

insert into board2sub values('1','bbb1',sysdate,'1');
insert into board2sub values('2','bbb2',sysdate,'1');

delete from board2 where seqid='1';