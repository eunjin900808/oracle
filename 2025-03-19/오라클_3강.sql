insert into dept values('50','IT부서','서울');
insert into dept values('100','IT부서','서울2');
insert into dept values('1','디자인','부산');
insert into dept values('99','12345678901234','부산');

insert into emp values('1001','홍길동','ANALYST','7782','2025-03-03','250','','50');
insert into emp values('1002','호동이','ANALYST','7782','2025/03/03','250','','50');
insert into emp values('1003','삼성맨','ANALYST','7782','2025:03:03','250','','50');
insert into emp values('1004','삼성맨1','ANALYST','7782','2025#03#03','250','','50');
insert into emp values('1004','삼성맨7','ANALYST','7782','2025$03$03','250','','50');
insert into emp values('1004','엘지맨','ANALYST','7782','20250303','250','','50');
insert into emp values('1005','엘지1','ANALYST','7782',to_date('2025-03-03','yyyy-mm-dd'),'250','','50');
insert into emp values('1006','엘지6','ANALYST','7782','03-07-2025','250','','50');
insert into emp values('1006','엘지6','ANALYST','7782',to_date('03-07-2025','mm-dd-yyyy'),'250','','50');
insert into emp values('1006','엘지6','ANALYST','7782',to_date('03-07-2025','yyyy-mm-dd'),'250','','50');
insert into emp values('1007','엘지8','ANALYST','7782',to_date('03-07-2025','mm-dd-yyyy'),'250.58','','50');
insert into emp values('1008','엘지9','ANALYST','7782',to_date('03-07-2025','mm-dd-yyyy'),'25000.58','','50');
insert into emp values('1009','엘10','ANALYST','7782',to_date('03-07-2025','mm-dd-yyyy'),'250000.58','','50');

select * from dept;
select * from emp;

COMMENT;
ROLLBACK;
-- (1)
desc dept;
desc emp;
desc salgrade;
-- (2)
select * from dept;
select * from emp;
select * from salgrade;
-- (3)
select * from emp where DEPTNO = '10';
-- (4)
select * from emp where SAL >= '1500';
-- (5)
select grade||'등급' from salgrade where losal <= 1400 and hisal >= 1400;
-- (6)
select * from emp where job != 'PRESIDENT' and mgr is null;
-- (7)
-- select substr(ename,1,2)||'**' as ename from emp;
select
    -- substr(ename,1,2)||'**' as ename
    -- abcdef => ab****
    -- rpad('ab',6,'*') -> ab****
        rpad (substr(ename,1,2),length(ename),'*')
    from emp;

