-- {group by}

-- 1. 부서별 급여의 합 출력
    --(1) 급여 합계/평균
    select sum(sal) from emp;
    select avg(sal) from emp;
    
    --(2) 부서별 합계 출력
    select
        (select sum(sal) from emp where deptno = 10) "10번부서"
       ,(select sum(sal) from emp where deptno = 20) "20번부서"
     from
        dual;
    --10번부서 20번부서
    --  7120    4500
    
    --(3) 부서별 급여합계 출력 (레코드 형식의 출력 - UNION 사용)
    select 10 deptno, sum(sal) from emp where deptno = 10
    union
    select 20 deptno, sum(sal) from emp where deptno = 20
    union
    select 30 deptno, sum(sal) from emp where deptno = 30
    union
    select 40 deptno, sum(sal) from emp where deptno = 40;
    
    --(4) 부서별 급여합계 출력 (레코드 형식의 출력 - GROUP BY 사용)
    select deptno,sum(sal) from emp; -- error
    
    -- 부서번호를 그룹으로 만들어서 부서번호와 급여합계를 출력한다.
    select deptno,sum(sal) from emp group by deptno;
    select deptno,sum(sal),avg(sal) from emp group by deptno;
-- -------------------------------------------------------------------------- --
    select deptno
          ,sum(sal)
          ,avg(sal)
        from
            emp
        group by deptno
        order by deptno asc;   -- 순차적정렬
-- -------------------------------------------------------------------------- --
-- 2. 부서번호, 최고급여, 최조급여를 부서별 출력
--      == 정상 출력 ==      --
    select deptno               부서번호
          ,sum(sal)             급여합계
          ,round(avg(sal),2)    급여평균
          ,max(sal)             최고급여
          ,min(sal)             최저급여
        from
            emp
        group by deptno
        order by deptno asc;
-- -------------------------------------------------------------------------- --
--      == 잘못된 사례 ==      --
-- order by 는 맨 마지막
        from
            emp
        order by deptno asc
        group by deptno;
-- -------------------------------------------------------------------------- --
--      == 잘못된 사례 ==      --
-- 그룹묶음의 주최 컬럼 이외는 출력불가
    select enpno                사원번호 -- error
          ,deptno               부서번호
          ,sum(sal)             급여합계
          ,round(avg(sal),2)    급여평균
          ,max(sal)             최고급여
          ,min(sal)             최저급여
        from
            emp
        group by deptno
        order by deptno asc;
-- -------------------------------------------------------------------------- --
-- 3. 부서별 그룹 후 평균이 500 이상인 부서들만 출력
--      == 정상 출력 ==      --
    select deptno               부서번호
          ,round(avg(sal),2)    급여평균
        from
            emp
        group by
            deptno
        having      -- 그룹에 대한 조건식
            avg(sal) >= 500;
-- -------------------------------------------------------------------------- --
--      == 잘못된 사례 ==      --명령어가 올바르게 종료되지 않았습니다 where조건은 테이블과 떨어질수없음
    select deptno               부서번호
          ,round(avg(sal),2)    급여평균
        from
            emp
        group by
            deptno
        where
            avg(sal) >= 500;
-- -------------------------------------------------------------------------- --
--      == 잘못된 사례 ==      --그룹 함수는 허가되지 않습니다
    select deptno               부서번호
          ,round(avg(sal),2)    급여평균
        from
            emp
        where
            avg(sal) >= 500     -- error / where조건에는 그룹함수 사용불가
        group by
            deptno;
-- -------------------------------------------------------------------------- --
-- == 일반 where 조건과 같이 쓰는 경우 == -- 그룹함수에 where 조건이 올수도있다(그룹함수 사용불가)
    select deptno               부서번호
          ,round(avg(sal),2)    급여평균
        from
            emp
        where
            sal >= 1000     -- 첫번째로 해석 : group by 전에 해석(전직원에서 1000만원이상만 추려냄)
        group by            -- 두번째로 해석 : 1000만원 이상의 직원들에서 그룹으로 묶음
            deptno;
            
-- -------------------------------------------------------------------------- --
-- 4. 업무별 그룹화

--(1) 업무별 급여합계
select job          업무명
      ,sum(sal)     급여합계
      ,max(sal)     최고급여
      ,min(sal)     최저급여
      ,count(*)     인원수
    from
        emp
    group by job;
    
-- -------------------------------------------------------------------------- --
-- 5. 부서별 부서번호와 평균급여 (조건: 평균급여가 2000 이상인 부서
select deptno,round(avg(sal)) from emp group by deptno having avg(sal) >= 2000;
-- -------------------------------------------------------------------------- --
-- 6. 꼴등부서에서 가장 적게받는 직원 출력
-- (1) 부서별로 평균 급여
select avg(sal) from emp group by deptno;
-- (2) 가장적은 부서의 가장적은 평균급여
select min(avg(sal)) from emp group by deptno;  -- 250
-- (3) 급여가 250이하인 직원 출력
select empno
      ,ename
      ,sal
    from
        emp
    where sal <= 250;
-- (4)
select empno
      ,ename
      ,sal
    from
        emp
    where sal <= (select min(avg(sal)) from emp group by deptno);
    
-- ========================================================================== --
-- 풀어보기 1. 부서별 사원수 조회
select deptno 부서번호,count(*) 인원수 from emp group by deptno;

-- 부서지정이 안되어있는 사원들은 제외 (부서번호가 null로 되어있음) - having 사용
select deptno 부서번호,count(*) 인원수 from emp
    group by deptno
    having deptno is not null;

-- 부서지정이 안되어있는 사원들은 제외 (부서번호가 null로 되어있음) - where 사용
select deptno 부서번호,count(*) 인원수 from emp
    where deptno is not null
    group by deptno;
-- -------------------------------------------------------------------------- --
-- 풀어보기 2. 부서별 사원수 급여평균 급여합계 출력
    -- decode (데이터값, 비교값, 결과값, 비교값, 결과값, 기타(else))
select decode(deptno,null,'수습',deptno) 부서번호
      ,count(*)                         사원수
      ,round(avg(sal))                  급여평균
      ,sum(sal)                         급여합계
    from emp
    group by deptno;
-- -------------------------------------------------------------------------- --
-- 풀어보기 3. 사원수가 5명이 넘는 부서와 사원수 조회
select  deptno          부서번호
       ,count(*)        사원수
    from
        emp
    group by deptno
    having count(*) >= 5;
-- -------------------------------------------------------------------------- --
-- 풀어보기 4. 부서별 최저급여를 출력하시오.
select  deptno          부서번호
       ,min(sal)        최저급여
    from
        emp
    group by deptno;
-- -------------------------------------------------------------------------- --
-- 풀어보기 5. 직원들의 연차를 출력한다. -- 그룹바위와 관계없음
    -- 사원명/업무/연차/급여