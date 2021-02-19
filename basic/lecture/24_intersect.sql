-- 집합 연산자와 서브커리 - 03. Intersect 연산
-- Intersect 연산자는 두 개 이상의 Select 문들의 결과 집합을 하나의 결과 집합으로 결합한다.
-- 즉 집합 A와 집합 B의 교집합을 출력.

create table employees 
(
employee_id serial primary key,
employee_name varchar (255) not null
);

create table keys
(
employee_id int primary key,
effective_date date not null,
foreign key (employee_id)
references employees (employee_id)
);

create table hipos 
(
employee_id int primary key,
effective_date date not null,
foreign key (employee_id),
references employees (employee_id)
)

insert into employees (employee_name)
values
('Joyce Edwards'),
('Diane Collins'),
('Alice Stewart'),
('Julie Sanchez'),
('Heather Morris'),
('Teresa Rogers'),
('Doris Reed'),
('Gloria Cook'),
('Evelyn Morgan'),
('Jean Bell');

insert into keys
values
(1, '2000-02-01'),
(2, '2001-06-01'),
(5, '2002-01-01'),
(7, '2005-06-01');

insert into hipos
values
(9, '2000-01-01'),
(2, '2002-06-01'),
(5, '2006-06-01'),
(10, '2005-06-01');

-----------------------------

select
	employee_id
from
	keys k
intersect
select
	employee_id
from
	hipos h

-- intersect 연산은 실무에서 많이 사용되지는 않음. 왜냐하면 intersect 연산과 inner join 연산과 그 결과가 같기 때문.
------------------------------
-- 아래 inner join 연산과 위 intersect 연산과 동일하다. 이때 intersect 연산보다 inner join 연산이 성능 상 더 좋다.
select
	k.employee_id
from
	keys k,
	hipos h
where
	k.employee_id = h.employee_id 

------------------------------
-- 위 inner join 연산과 아래 inner join 연산은 동일하다.
select
	k.employee_id
from
	keys k
inner join hipos h on
	k.employee_id = h.employee_id
	
-------------------------------
	
select
	employee_id
from
	keys k
intersect
select
	employee_id
from
	hipos h
order by
	employee_id desc -- order by 문은 맨 아래 select에 작성해야 한다.