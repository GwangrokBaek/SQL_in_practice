-- 데이터 조회와 필터링 - 09. LIKE 연산자 

select
	first_name,
	last_name
from
	customer c
where
	first_name like 'Jen%'; -- % 는 문자 혹은 문자열이 올 수 있다. 

----------------------------

select
	'foo' like 'foo', -- foo 와 foo는 같으므로 True
	'foo' like 'f%', -- f% 는 f 로 시작하는 문자열이 오면 True
	'foo' like '_o_', -- _o_ 는 3자리 문자열이고, 가운데 문자가 o 이면 True
	'bar' like 'b_' -- b_ 는 b로 시작하며 2자리 문자열이 오면 true 인데 bar 는 3 자리 이므로 false

----------------------------

select
	first_name,
	last_name
from
	customer c
where
	first_name like '%er%';

----------------------------

select
	first_name,
	last_name
from
	customer c
where
	first_name like '_her%';
	
----------------------------

select
	first_name,
	last_name
from
	customer c
where
	first_name not like 'Jen%';