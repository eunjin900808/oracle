select * from user_tab_comments;    -- 시스템테이블
select * from user_col_comments;    -- 시스템테이블
-- 
-- rownum : 행번호 내장 컬럼
-- view table : 가상테이블 (물리적 공간x) -- 기술 -- 원본 <-> View
-- table copy : 물리테이블 (물리적 공간o) -- 객체
-- sequence : auto_increment - 자동숫자증가(고유값생성) / 테이블 당 한개

-- > 모든테이블 - 고유값이 있음; ex) 회원등록:userid; sequence(절대적이지 않음)
--                                게시판 : sequence(절대적 필요)

-- --------------------------------------------------------------- --
create sequence nboard_seq
increment by 1      -- 중감요건
start with 1        -- 시작 값
maxvalue 999999;    -- 마지막 값 (최대 값)
-- --------------------------------------------------------------- --
create table nboard(
seqid number not null primary key,
title varchar2(100) not null,
pass varchar2(100) not null,
name varchar2(20),
hits number default 0,
content varchar2(4000),
rdate timestamp,    -- 등록일
udate timestamp     -- 변경일(최종일)
);

-- (1) 등록 sql 작성
insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc1','1111','홍길동11','0','aaa11',sysdate,'');
            
insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc2','1111','홍길동22','0','bbb11',sysdate,'');

insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc3','1111','홍길동33','0','ccc11',sysdate,'');

insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc4','1111','홍길동44','0','ddd11',sysdate,'');

insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc5','1111','홍길동55','0','eee11',sysdate,'');

insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc6','1111','홍길동66','0','fff11',sysdate,'');
            
insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc7','1111','홍길동77','0','ggg11',sysdate,'');

insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc8','1111','홍길동88','0','hhh11',sysdate,'');
            
insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc9','1111','홍길동99','0','iii11',sysdate,'');
            
insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc10','1111','홍길동10','0','jjj11',sysdate,'');
            
insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc11','1111','홍길동111','0','kkk11',sysdate,'');
            
insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc12','1111','홍길동12','0','lll11',sysdate,'');
            
commit;

select nboard_seq.currval from dual;
select nboard_seq.nextval from dual;

insert into nboard(SEQID,TITLE,PASS,NAME,HITS,CONTENT,RDATE,UDATE)
            values(nboard_seq.nextval,'abc15','1111','홍길동00','0','lll11',sysdate,'');


-- (2) 목록출력 SQL 작성 ( 최근 게시물 순으로 출력 )
--  - 번호,제목,글쓴이,조회수,등록일(년-월-일) 출력 -
select SEQID,TITLE,NAME,HITS,to_char(RDATE,'yyyy-mm-dd') 등록일 from nboard order by seqid desc;
-- (3) 상세출력 SQL ( 특정 seqid 값을 조건으로 한 출력 )
--  - 제목,글쓴이,내용,조회수,등록일,변경일 출력
select TITLE,NAME,CONTENT,HITS,to_char(RDATE,'yyyy-mm-dd')등록일,to_char(UDATE,'yyyy-mm-dd')변경일 from nboard where seqid ='21';
-- (4) 조회수 증가 SQL 작성( 특정 seqid값을 설정)
update nboard set hits = hits+1 where seqid='21';
-- (5) 수정처리 SQL 작성( seqid값과 pass 를 조건으로 한 수정 처리)
--  - 제목,글쓴이,내용,변경일 -
update nboard set title='asas', name ='may',content='ccc777',udate=sysdate where seqid='21' and pass='1111';
-- (6) 삭제처리 SQL 작성 (seqid값과 pass를 조건으로 한 삭제 처리)
delete from nboard where seqid='21' and pass='121212';
-- (7) 목록출력 > 검색 SQL 작성 (특정 단어를 제목에서 찾는 설정으로 작성한다.)
select SEQID,TITLE,NAME,HITS,to_char(RDATE,'yyyy-mm-dd') 등록일 from nboard where TITLE like '%5%' order by seqid desc;
-- (8) 목록출력 > 페이징 SQL 작성 (한 화면에 10개씩 보여주는 설정으로 2페이지를 설정한다.)
    -- rownum 활용 범위 설정 --
select b.* from(
    select rownum rn, a.* from (
        select TITLE,NAME,HITS,to_char(RDATE,'yyyy-mm-dd') 등록일 from nboard
            order by seqid desc) a ) b
where
--    rn >= 1 and rn <=10;
    rn >= 10 and rn <=20;
    
-- 뷰 처리
create view v_nboardList as
    select b.* from(
        select rownum rn, a.* from (
            select TITLE,NAME,HITS,to_char(RDATE,'yyyy-mm-dd') 등록일 from nboard
                order by seqid desc) a ) b;
                
-- 뷰를 이용한 페이징 처리
select * from v_nboardList where rn >=1 and rn <=10;
