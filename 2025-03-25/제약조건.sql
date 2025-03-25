select * from all_tab_comments where table_name = 'MEMBER2';    -- 테이블확인
select * from all_col_comments where table_name = 'MEMBER2';    -- 컬럼확인
select * from user_constraints where table_name = 'MEMBER2';    -- 제약사항확인
select * from all_indexes where table_name = 'MEMBER2';         -- 인덱스정보확인 (primary key, unique)

create table board101(
seqid number primary key,
title varchar2(100) not null,
pass varchar2(100) not null,
name varchar2(50) not null,
content varchar2(4000),
regdt timestamp
);

insert into board101 values(1,'aa','1234','홍','',sysdate);
insert into board101 values(3,'bbb','1212','김','33',sysdate);
insert into board101 values(2,'dfdf','1212','김22','33',sysdate);
insert into board101 values(3,'dfdf','1212','김22','33',sysdate);    -- 오류

create table board102(
seqid number,
title varchar2(100) not null,
pass varchar2(100) not null,
name varchar2(50) not null,
content varchar2(4000),
regdt timestamp,
constraint board102_pk1 primary key(seqid)
);

create table board103(
seqid number primary key,
title varchar2(100) not null,
pass varchar2(100) not null,
name varchar2(50) primary key,  -- 테이블에는 하나의 기본 키만 가질 수 있습니다.
content varchar2(4000),
regdt timestamp
);

create table board104(
seqid number,
title varchar2(100) not null,
pass varchar2(100) not null,
name varchar2(50) not null,
content varchar2(4000),
regdt timestamp,
constraint board104_pk1 primary key(seqid,name)
);

insert into board104 values(1,'aa','1234','홍','',sysdate);          -- ok
insert into board104 values(2,'bbb','1212','홍7','33',sysdate);       -- ok
insert into board104 values(2,'dfd','3214','김','33',sysdate);       -- ok (둘다 똑같지 않으면 들어감)
insert into board104 values(1,'ccc','1212','홍','33',sysdate);       -- error
insert into board104 values(3,'ccc','1212','홍','33',sysdate);       -- ok
insert into board104 values(3,'ddf','2344','홍','ss',sysdate);       -- error
insert into board104 values(3,'ddf','2344','만두','ss',sysdate);     -- ok




