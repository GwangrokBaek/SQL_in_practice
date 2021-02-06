-- 데이터 조회와 필터링 3. select distinct 문
select
	distinct first_name, customer_id
from customer
order by 1 desc,
		2 asc
;
--------------------------------------------
drop table T3;
-- table 삭제 
create table T3(ID SERIAL not null primary key, BCOLOR VARCHAR, FCOLOR VARCHAR);
-- table 생성과 같은 create 명령어는 commit을 해줄필요 없다 이는 DDL 이므로 create 명령을 치는순간에 바로 적용되기 때문

insert 
	into T3(BCOLOR, FCOLOR) -- T1 테이블에 데이터 삽입 
values
	('red', 'red')
	, ('red', 'red')
	, ('red', NULL) -- NULL은 아무것도 아닌  
	, (NULL, 'red')
	, ('red', 'green')
	, ('red', 'blue')
	, ('green', 'red')
	, ('green', 'blue')
	, ('green', 'green')
	, ('blue', 'red')
	, ('blue', 'green')
	, ('blue', 'blue')
;

commit;

select *
from T3;

--------------------------------------
select 
	distinct bcolor
from t3
order by bcolor
;
-- NULL 은 아무것도 없는 값이지만 이것도 아무것도 없음을 나타내주는 하나의 값이므로
-- distinct에 의해 같이 출력된다. 이때 NULL은 가장 큰 값 
--------------------------------------
select
	distinct bcolor, fcolor -- 두 개의 컬럼을 사용할 시, 두 개 컬럼이 중복되는
							-- 경우를 제거 
from t3
order by bcolor, fcolor
;
----------------------------------------
select
	distinct on (bcolor) bcolor,
			fcolor
	from t3
order by bcolor, fcolor -- default는 asc
;
-- distinct on은 위에서 bcolor를 기준으로 중복을 제거하되 fcolor도 보고싶을 경우 사용
-- 이 경우 fcolor의 선택은 order by의 기준에 따라 선택된다. 이때 blue가 red, green
-- 보다 작으므로 blue가 선택되고 NULL의 경우, red값 밖에 없으므로 red가 조회된다.
-- 쉽게 말해 bcolor를 기준으로 중복 제거된 값이 기준 집합이 되고, 이 집합에서 order by에
-- 따라 fcolor를 선택해준다는 뜻.
----------------------------------------
select 
	distinct on (bcolor) bcolor,
				fcolor
	from t3
order by bcolor, fcolor desc -- bcolor는 asc, fcolor는 desc
;
-- 이제 fcolor를 내림차순으로 정렬하므로 blue가 아닌 red가 선택된다. red, blue, green
-- 중에서 red가 가장 큰 값이므로. 이때 red는 fcolor로 NULL 값도 있기에
-- NULL이 선택된다.
-- 현업에서 distinct on은 거의 사용안함 
