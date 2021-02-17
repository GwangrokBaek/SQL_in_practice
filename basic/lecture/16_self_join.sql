-- 조인과 집계 데이터 - 04. SELF 조인 

-- 같은 테이블 끼리 특정 컬럼을 기준으로 매칭 되는 컬럼을 출력하는 조인이다.
-- 즉 같은 테이블의 데이터를 각각의 집합으로 분류한 후 조인하는 것.

create table employee
(
employee_id int primary key,
first_name varchar(255) not null,
last_name varchar(255) not null,
manager_id int,
foreign key (manager_id) references employee (employee_id) -- manager_id 는 employee_id를 참조한다는 뜻.
on delete cascade
)

insert
	into
	employee( employee_id,
	first_name,
	last_name,
	manager_id)
values
(1, 'Windy', 'Hays', NULL),
(2, 'Ava', 'Christensen', 1),
(3, 'Hassan', 'Conner', 1),
(4, 'Anna', 'Reeves', 2),
(5, 'Sau', 'Norman', 2),
(6, 'Kelsie', 'Hays', 3),
(7, 'Tory', 'Goff', 3),
(8, 'Salley', 'Lester', 3)

select
	*
from
	employee e
	
--------------------------------
	
select
	e.first_name || ' ' || e.last_name employee,
	m.first_name || ' ' || m.last_name manager
from
	employee e
inner join employee m on
	m.employee_id = e.manager_id -- 각 employee들의 manager 이름을 출력.
order by
	manager

-- self join은 inner join을 사용해서 수행 가능. 이때 self join은 같은 테이블 내에서 특정 컬럼을 기준으로 하여 매칭되는 값을 출력하는 것.
-- 이때 ceo인 Windy Hays는 manager가 없으므로 출력 안됨.
--------------------------------
	
select
	e.first_name || ' ' || e.last_name employee,
	m.first_name || ' ' || m.last_name manager
from
	employee e -- 왼쪽 집합 
left outer join employee m on -- 오른쪽 집합 
	m.employee_id = e.manager_id
order by
	manager
	
-- 앞서 self join의 경우, Windy Hays는 출력되지 않았으므로 self left outer join을 활용해서 manager 값이 NULL인
-- Windy Hays도 출력 가능.
---------------------------------

select
	f1.title,
	f2.title,
	f1.length
from
	film f1
inner join film f2 on
	f1.film_id <> f2.film_id
	and f1.length = f2.length
	
-- self join에 부정형 조건도 사용 가능.
-- 이때 위와 같은 역할을 하는 쿼리를 join이 아닌 테이블 하나만 사용하게끔 아래처럼 바꿀 수 있는데 결과적으로 아래 쿼리는 동작 안함.

select
	*
from
	film f1
where
	f1.length = f1.length
	and f1.film_id <> f1.film_id

-- 왜냐면 동일한 테이블, 동일한 집합을 사용하기때문에 하나의 테이블에서 서로 다른 조건을 적용할 수 가 없음. 하지만 self join의 경우
-- 동일한 테이블이지만 이를 셀프조인을 사용해서 각각의 다른 집합으로 구성하기 때문에 서로 다른 조건을 적용해서
-- 원하는 정보를 추출하는 것이 가능.