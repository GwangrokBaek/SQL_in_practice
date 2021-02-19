-- 집합 연산자와 서브커리 - 01. Union 연산
-- 두 개 이상의 Select 문들의 결과 집합을 단일 결과 집합으로 결합하며 결합시 중복된 데이터는 제거 된다.
-- 이때 두 개의 select 문 간의 컬럼의 개수는 동일해야 하고, 서로 호환되는 데이터 유형이어야 한다.

-- 두 개의 select 문에서 중복되는 데이터 값이 있다면 중복은 제거 된다.
-- order by로 정렬할때에는 맨 마지막 select문에 order by 절을 사용.
-- !!집합으로 생각!! -> 두 집합의 합집합을 출력하되 중복되는 데이터는 하나만 출력.

create table sales2007_1 
(
name varchar(50),
amount numeric(15, 2)
);

insert into sales2007_1 
values
('Mike', 150000.25),
('Jon', 132000.75),
('Mary', 100000)

create table sales2007_2
(
name varchar(50),
amount numeric(15, 2)
);

insert into sales2007_2
values
('Mike', 120000.25),
('Jon', 142000.75),
('Mary', 100000)

------------------------------------

select
	*
from
	sales2007_1 s
union
select
	*
from
	sales2007_2 s2
	
------------------------------------

select
	name
from
	sales2007_1 s
union
select
	name
from
	sales2007_2 s2
	
------------------------------------

select
	amount
from
	sales2007_1 s
union
select
	amount
from
	sales2007_2 s2

------------------------------------

select
	*
from
	sales2007_1 s
union
select
	*
from
	sales2007_2 s2
order by
	amount desc -- order by 는 맨 마지막 select 문에 작성해야 한다.