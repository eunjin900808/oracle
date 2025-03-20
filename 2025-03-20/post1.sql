-- (1) 구리시의 주소 개수를 출력
select count(*) from post1 where p3='구리시';
select count(*) from post1 where p3 like '구리시';
-- (2) 구리시에서 "동"이 없는 레코드를 출력
select * from post1 where p3 like '%구리시%' and p4 is null;
-- (3) 구리시에서 우체국의 주소를 출력
select * from post1 where p3 like '%구리시%' and p8 like '%우체국%';
-- (4) 서울시만 따로 추출하여 post_seoul 테이블을 만든다.
create table post_seoul as select * from post1 where p2 like '%서울%';
-- (5) 서울시만 따로 추출하여 v_post_seoul 뷰를 만든다.
create view v_post_seoul as select * from post1 where p2 like '%서울%';
