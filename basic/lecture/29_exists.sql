-- 집합 연산자와 서브쿼리 - 08. Exists 연산자
-- Exists 연산자는 서브쿼리 내에 집합이 존재하는지 존재 여부만을 판단한다. 존재 여부만을 판단하므로 연산 시 부하가 줄어든다.
-- 이때 Exists 연산자는 매우 많이 사용되므로 정말 중요하다.

select
	first_name,
	last_name
from
	customer c
where
	exists (
	select
		1
	from
		payment p
	where
		p.customer_id = c.customer_id
		and p.amount > 11 )
order by
	first_name,
	last_name

-- 이때 해당 집합이 존재하기만 하면 더이상 연산을 수행하지 않고 멈추므로 성능상 유리하다. (연산을 수행하지 않는다는 말의 의미는 해당 값이 11을 넘는지를 체크하기 위해 연산을 수행하지 않고,
-- row의 존재 여부만을 체크하는 것으로 이해하면 될 듯 하다.)
---------------------------------------

select
	first_name,
	last_name
from
	customer c
where
	not exists (
	select
		1
	from
		payment p
	where
		p.customer_id = c.customer_id
		and p.amount > 11 )
order by
	first_name,
	last_name

-- not exists 연산자는 해당 집합이 존재하지 않기만 하면 더이상 연산을 수행하지 않고 멈추므로 성능상 유리하다.
-- 이때 위의 exists 연산자를 통해 검색된 결과를 A라 하고, 아래의 not exists 연산자를 통해 검색된 결과를 B라 할때,
-- A + B는 전체 customer가 된다.
	
-- 좀 더 깊게 들어가면, exists 연산자는 row가 있는지 없는지 즉, 존재하는지, 존재하지 않는지만을 확인하기 때문에 select 문에 1만 와도 되고, 그 어떤 값이 와도 상관이 없으며
-- 속도가 in 연산자보다 빠르다. 이때 in 연산자 같은 경우, 아래와 같이 작성할 수 있다.

select
	department_id,
	employee_id
from
	employees e
where
	department_id in (30, 60, 90)

-- 여기서 in 연산자는 해당 컬럼의 값이 30, 60, 90에 속하는지 연산을 수행해줘야 한다. 하지만 아래의 exists 연산자는 단순히 row의 존재여부만 확인하므로 속도가 빠르다.
----------------------------------------

select
	emp.department_id,
	emp.employee_id
from
	employees emp
where
	exists (
	select
		dep.department_id
	from
		departments dep
	where
		dep.department_id in (30, 60, 90)
		and emp.department_id = dep.department_id )

-- 이때 not in의 경우에는 null 값을 읽지 못하기에 nvl 함수를 따로 써줘야하지만, exists는 row의 존재여부만 확인하므로 상관 없다는 장점도 있다.
