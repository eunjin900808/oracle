-- 1.
create table dept2 as select * from dept; -- 원본 카피
-- 2.
update dept set loc ='강원' where deptno='2';  -- 원본을 수정해도 카피본에 영향을 미치지않는다 (변경안됨)

-- ----------------------------------------- --
-- 3. 뷰생성
create view v_dept1 as select * from dept;
-- 4. 뷰생성
create view v_dept2 as
            select * from dept
            where deptno in (10,20,30);
-- 5.
update dept set loc = 'DALLAS77' where deptno=20;
-- 6. 뷰테이블에 변경을 가하여 본 테이블에 영향이 있는지 확인한다.
update v_dept1 set loc = 'NEWYORK' where deptno=10; -- 뷰테이블도 다 변경됨
-- ----------------------------------------- --
-- 본테이블에 변경이 있을 시 관련 뷰테이블에 영향을 미침.
-- ----------------------------------------- --
-- 뷰테이블에 변경이 있을 시 본테이블에 영향은 상황에 따라 적용이 달라짐.
-- ----------------------------------------- --
