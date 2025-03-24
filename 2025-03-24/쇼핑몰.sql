-- {쇼핑몰}
-- --------------- --
-- 1. goods_tbl
-- 2. sale_tbl
-- --------------- --

-- 1.goods_tbl
-- (1) 상품코드     - gds_cd    - number        -- primary key
-- (2) 상품이름     - gds_nm    - varchar2(50)  -- not null
-- (3) 상품단가     - gds_prc   - number        -- not null,default 0
-- (4) 공급업체     - gds_com   - varchar2(50)   -- not null
-- (5) 등록일시     - gds_dts   - timestamp
-- (6) 담당자ID     - gds_mgr   - varchar2(50)  -- not null   - ('a1','a2','a3')
-- -------------------------------------------------------------------------- --
-- 2. sale_tbl
-- (1) 판매코드 - sale_cd   - number
-- (2) 상품코드 - gds_cd    - number
-- (3) 판매수량 - sale_qty  - number
-- (4) 판매일시 - sale_dts  - timestamp
-- (5) 지불여부 - sale_pay  - char(1)   - check(Y/N)

create table goods_tbl(
gds_cd number primary key,
gds_nm varchar2(50) not null,
gds_prc number default 0 not null,
gds_com varchar2(50) not null,
gds_dts timestamp,
gds_mgr varchar2(50) check(gds_mgr in('a1','a2','a3')) not null
);
-- --------------------------------------------------------------- --
create table sale_tbl(
sale_cd number primary key,
gds_cd number,
sale_qty number default 0,
sale_dts timestamp,
sale_pay char(1) check(sale_pay in('Y','N')),
constraint sale_tbl_fk foreign key(gds_cd) references goods_tbl(gds_cd)
);


-- 1.상품코드 1001부터 시작 :: 시퀀스 사용 안함
-- 2. 판매코드 10001부터 시작 :: 시퀀스 사용 안함
-- ----------------------------------------------------------------- --
insert into goods_tbl values
                            ((select nvl(max(gds_cd),1000)+1 from goods_tbl)
                           ,'맥심목화커피'
                           ,'5000'
                           ,'제일제당'
                           ,sysdate
                           ,'a1');

insert into goods_tbl values((select nvl(max(gds_cd),1000)+1 from goods_tbl),'신라면','1100','농심',sysdate,'a2');
insert into goods_tbl values((select nvl(max(gds_cd),1000)+1 from goods_tbl),'진라면','1150','오뚜기',sysdate,'a2');
insert into goods_tbl values((select nvl(max(gds_cd),1000)+1 from goods_tbl),'진로소주','1500','진로',sysdate,'a3');
insert into goods_tbl values('1005','너구리','1100','농심',sysdate,'a2');
commit;

insert into sale_tbl values('10001','1002','5',sysdate,'Y');
insert into sale_tbl values('10002','1002','2',sysdate,'Y');
insert into sale_tbl values('10003','1004','2',sysdate,'Y');
insert into sale_tbl values('10004','1004','3',sysdate,'N');
insert into sale_tbl values('10005','1001','10',sysdate,'Y');

delete from goods_tbl where gds_cd = '1002';
-- 무결성 제약조건(C##JAVA.SALE_TBL_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
delete from goods_tbl where gds_cd = '1005';    -- 삭제
delete from goods_tbl where gds_cd = '1003';    -- 삭제

ROLLBACK;




