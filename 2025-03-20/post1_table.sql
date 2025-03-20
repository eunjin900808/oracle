create table post1(
p1 varchar2(6),
p2 varchar2(50),
p3 varchar2(50),
p4 varchar2(50),
p5 varchar2(50),
p6 varchar2(50),
p7 varchar2(50),
p8 varchar2(100)
);

comment on table post1 is '구우편번호 주소 테이블';
comment on column post1.p1 is '우편번호';
comment on column post1.p2 is '시도';
comment on column post1.p3 is '시군구';
comment on column post1.p4 is '읍면동';
comment on column post1.p5 is '리';
comment on column post1.p6 is '도서';
comment on column post1.p7 is '번지';
comment on column post1.p8 is '기타(건물명)';
