create table popSeoul(
s1 varchar2(50), -- 서울시(구)
s2 number, -- 전체(남)
s3 number, -- 전체(여)
s4 number, -- 한국(남)
s5 number, -- 한국(여)
s6 number, -- 외국(남)
s7 number, -- 외국(여)
s8 number -- 고령자
);

comment on table popSeoul is '서울시 인구 테이블';
comment on column popSeoul.s1 is '서울시(구이름)';
comment on column popSeoul.s2 is '전체(남)';
comment on column popSeoul.s3 is '전체(여))';
comment on column popSeoul.s4 is '한국인(남)';
comment on column popSeoul.s5 is '한국인(여)';
comment on column popSeoul.s6 is '외국인(남)';
comment on column popSeoul.s7 is '외국인(여)';
comment on column popSeoul.s8 is '고령자';
