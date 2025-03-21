select empno          -- 사원번호
      ,ename          -- 사원이름
      ,sal            --기본급여
      ,(sal+comm)        -- 실급여1
      ,(sal+nvl(comm,0)) -- 실급여2
from emp;

-- 값이없음 = null => 0

select nvl(100,0) + 100 from dual;  -- 200
select nvl(null,0) + 100 from dual;  -- 100
select nvl(null,200) + 100 from dual;  -- 300

select nvl('html','설정안됨') || '입니다.' from dual;
select nvl(null,'설정안됨') || '입니다.' from dual;

select ename 사원이름
      ,nvl(mgr,'7839') 매니저번호
from emp;
-- ------------------------------------------------ --

-- 실급여 계산 -> 실적이 있는 직원들은 100만원 추가..
-- nvl(데이터 값, 대비하는 값(널값인경우세팅)) : 널값 대비 함수
-- nvl2(데이터값, 널값이아닌경우세팅, 널값인경우세팅)

select ename                -- 사원명
      ,sal                  -- 기본급
      ,(sal+comm)실급여1
      ,(sal+nvl(comm,0))실급여2
      ,(sal+nvl(comm+100,0))실급여3
      ,(sal+nvl2(comm,comm+100,0))실급여4
from emp;

select deptno
      ,dname
      ,decode(deptno,10,'회계',20,'조사',30,'영업',40,'기획')dname2
from dept;

-- 커미션이 있는 직원들은 Y, 없는 직원들은 N
select ename                -- 사원명
      ,sal                  -- 기본급
      ,(sal+nvl(comm,0))실급여     -- nvl() 함수처리
      ,nvl2(comm,'Y','N')수당여부   -- nvl2() 함수처리
from emp;

-- 매니저가 있으면 '있음' 없으면 '없음'
select ename 사원명, nvl2(mgr,'있음','없음')매니저 from emp;

-- ------------------------------------------------------- --
-- 4.조건함수 - decode()
-- 실습예제 1.
select deptno
      ,dname
      ,decode(deptno,10,'회계'
                    ,20,'조사'
                    ,30,'영업'
                    ,40,'기획'
                    ,'미등록')
from
        dept;
        
-- 실습예제2. 10번 부서의 직원들만 급여 인상(1.1)
select
        empno 사원명
        ,deptno 부서번호
        ,sal 기본급
        ,decode(deptno,10,sal*1.1,sal)급여
from emp;
        
-- 풀어보기1. 10번부서 -> 10%, 20번부서 -> 20%, 다른부서 -> 안함
select
        empno 사원명
        ,deptno 부서번호
        ,sal 기본급
        ,decode(deptno,10,sal*1.1
                      ,20,sal*1.2
                      ,sal )급여
from emp;

-- 풀어보기2.

-- 풀어보기3.
-- 급여: 상/하 -> 기준 2000
--(1)
select ename,sal,'상' grade from emp where sal >= 2000
union   -- 출력 SQL을 연결해주는 함수
select ename,sal,'하' grade from emp where sal < 2000;
-- (2)
select ename
      ,sal
      ,decode(sign(sal-1999),1,'상', '하')grade
from emp;

select sign(100) from dual; -- 1
select sign(7) from dual; -- 1
select sign(-100) from dual; -- -1
select sign(-3) from dual; -- -1
select sign(0) from dual; -- - 0

-- 풀어보기5.
-- 1월  2월  3월  4월  5월  6월
-- -------------------------- --
-- 2    5    7    1    1   3
select
 (select count(*) from emp where to_char(hiredate,'mm') = '01') a1
,(select count(*) from emp where to_char(hiredate,'mm') = '02') "2월"
,(select count(*) from emp where to_char(hiredate,'mm') = '03') "3월"
from dual;

-- --------------------------------------------------- --
select 
    count(to_char(hiredate,'mm'))
from
    emp;
-- --------------------------------------------------- --
select
    -- decode(데이터값,비교값,결과치)
     count(decode(to_char(hiredate,'mm'),'01','1')) a1
    ,count(decode(to_char(hiredate,'mm'),'02','1')) a2
    ,count(decode(to_char(hiredate,'mm'),'03','1')) a3
from emp;
-- --------------------------------------------------- --
select
     count(*) 전체개수
    ,count(mgr) 매니저개수
    ,count(comm) 커미션개수
from emp;

-- --------------------------------------------------- --
-- [구매테이블]
-- {생성}
-- 1. 시퀀스 생성
create sequence book_seq
increment by 1
start with 1
maxvalue 999999;
-- 2. 구매테이블 생성
create table book(
seqid number not null primary key,
id varchar2(100) not null,
bookName varchar2(20),
price number default 0,
date timestamp
);
-- {입력}
-- 1 -> {'a101','java책','5000','2025-03-01 01:30:10'}
-- 2 -> {'a102','html책','','2025-03-03 22:30:10'}
-- 3 -> {'a103','리눅스책','1500','2025-03-03 15:30:10'}
insert into book(seqid,id,bookName,price,date)
            values('a101','java책','5000','2025-03-01 01:30:10');
insert into book(seqid,id,bookName,price,date)
            values('a102','html책','','2025-03-03 22:30:10');
insert into book(seqid,id,bookName,price,date)
            values('a103','리눅스책','1500','2025-03-03 15:30:10');
-- {출력}
-- 1. 전체 출력(최근데이터순 출력) - 기본출력
select * from book order by book desc;
-- 2. 아이디, 상품명, 결제여부
select id,booName,nvl2(price,'결제완료','결제안됨')결제여부 from book;
--  a101 java책 결제완료
--  a102 html책 미결재
--  a103 리눅스책 결제완료