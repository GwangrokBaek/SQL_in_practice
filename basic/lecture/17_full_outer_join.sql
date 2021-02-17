-- 조인과 집계 데이터 - 05. FULL OUTER 조인 

-- inner, left outer, right outer 조인 집합을 모두 출력하는 조인 방식.
-- 즉, 두 테이블간 출력가능한 모든 데이터를 포함한 집합을 출력.

select
	ba.id id_a,
	ba.fruit fruit_a,
	bb.id id_b,
	bb.fruit fruit_b
from
	basket_a ba
full outer join basket_b bb on
	ba.fruit = bb.fruit
	
-------------------------------------

select
	ba.id id_a,
	ba.fruit fruit_a,
	bb.id id_b,
	bb.fruit fruit_b
from
	basket_a ba
full outer join basket_b bb on
	ba.fruit = bb.fruit
where
	ba.id is null
	or bb.id is null -- null을 체크해서 교집합을 제외하고 나머지만을 출력.

-- only outer join 즉, 교집합을 제외한 나머지를 출력.
--------------------------------------
	
create table
if not exists departments
(
department_id serial primary key,
department_name varchar (255) not null
)

create table
if not exists employee
(
employee_id serial primary key,
employee_name varchar (255),
department_id integer
)

insert into departments(department_name)
values
('Sales'),
('Marketing'),
('HR'),
('IT'),
('Production')

insert into employees(employee_name, department_id)
values
('Bette Nicholson', 1),
('Christian Gable', 1),
('Joe Swank', 2),
('Fred Costner', 3),
('Sandra Kilmer', 4),
('Julia Mcqueen', NULL)

-----------------------------------------

select
	e.employee_name,
	d.department_name
from
	employees e
full outer join departments d on
	e.department_id = d.department_id
	
-----------------------------------------

select
	e.employee_name ,
	d.department_name
from
	employees e
full outer join departments d on
	e.department_id = d.department_id
where
	e.employee_name is null -- 직원이 없는 부서 출력.
	
-- right only 출력. 이때 위와 같이 full outer + right only 도 가능하고,
-- 아래처럼 right outer + right only로도 가능하다.
	
select
	e.employee_name ,
	d.department_name
from
	employees e
right outer join departments d on
	e.department_id = d.department_id
where
	e.employee_name is null
	
------------------------------------------

select
	e.employee_name ,
	d.department_name
from
	employees e
full outer join departments d on
	e.department_id = d.department_id
where
	d.department_id is null -- 소속이 없는 직원 출력.
	
-- left only 출력. 이때 위와 같이 full outer + left only 도 가능하고,
-- 아래처럼 left outer + left only로도 가능하다.
	
select
	e.employee_name ,
	d.department_name
from
	employees e
left outer join departments d on
	e.department_id = d.department_id
where
	d.department_id is null
	
