select * from user_tab_comments;
select * from user_col_comments where table_name=upper('popseoul');

select * from popseoul;

-- (1) 전체 남자, 여자의 인구 수
select to_char(sum(s2),'FM999,999,999') 남
      ,to_char(sum(s3),'FM999,999,999')여 from popseoul;
-- (2) 전체 인구 수
select to_char(sum(s2)+sum(s3),'FM999,999,999') total from popseoul;

-- (3) 남/여별로 인구수가 가장 많은 순으로 출력
--{구이름,인구수(남)} -- 남자별 역순차적 적용
--{구이름,인구수(여)} -- 여자별 역순차적 적용
select * from all_tables;
select * from popseoul;

select s1,s2 from popseoul order by s3 desc;
select s1,s3 from popseoul order by s3 desc;
select s1,(s2+s3) total from popseoul order by(s2+s3) desc;

-- (4)외국인이 가장 많은 사는 순으로 출력 -남,여 합계-
select s1,(s6+s6) 외국인수 from popseoul order by (s6+s7) desc;

-- (5) 노령층이 가장 많이 사는 순으로 출력
select s1,s8 노령층 from popseoul order by s8 desc;

-- (6) 외국인이 가장 많이 순으로 TOP3 출력
select rownum,s1,(s6+s6) 외국인수 from popseoul
    where rownum < 4
    order by (s6+s7) desc;  -- 엉뚱한 값
-- ------------------------------------------------------- --
select rownum, a.* from (
    select
        s1,(s6+s6) total
    from
        popseoul
    order by
        (s6+s7) desc) a
where
    rownum < 4;
    
-- (7) 전체 인구수가 평균에 못미치는 데이터를 출력
-- {구이름,인구수}
select avg(s2+s3) from popseoul; -- 401037.08

select s1 구이름
        ,(s2+s3) 인구수
        ,(select avg(s2+s3) from popseoul) 평균인구수
from
        popseoul
where
        (s2+s3) >= (select avg(s2+s3) from popseoul)
order by
    인구수 desc;


-- ------------------------------------------------------- --
-- rownum : 행번호를 출력해주는 {내장} 컬럼;
select rownum,s1,s2 from popseoul where rownum < 4;

select rownum,ename,job from emp;
select rownum,ename,job from emp where rownum < 5; -- 1 ~ 4
select rownum,ename,job from emp where rownum >= 5; -- 5이상 (x)

-- 3 ~ 5
select * from (select rownum rn,ename,job from emp)
where rn >= 3 and rn <=5;

-- mysql -> select ename,job from emp limit 2,3;

-- 1. 구이름별 출력
select b.* from(
    select rownum rn, a.* from (
        select * from popseoul
            order by s1 asc) a ) b
where
    rn >= 6 and rn <=10;
    
-- 6 ~ 10
--    where rownum >=6
--    and rownum <= 10;
-- ------------------------------------------------------- --
-- 2. 인구수별 역순 정렬
select b.* from(
    select rownum rn, a.* from(
        select * from popseoul
        order by (s2+s3) desc )a)b;
-- ------------------------------------------------------- --
-- 3.
-- {테이블 카피}
create table dept2 as select * from dept;
create table dept3 as select * from dept where deptno in (10,20);

create table pop1 as
select b.* from(
    select rownum rn, a.* from(
        select * from popseoul
        order by (s2+s3) desc )a)b;
-- 4.
select * from pop1
    where rn >= 6 and rn <= 10;
-- ------------------------------------------------------- --
-- 5.
-- {뷰}
-- view : 가상테이블(용량없음)
create view pop11 as
select b.* from(
    select rownum rn, a.* from(
        select * from popseoul
        order by (s2+s3) desc )a)b;
        
select * from pop11
    where rn >= 6 and rn <= 10;