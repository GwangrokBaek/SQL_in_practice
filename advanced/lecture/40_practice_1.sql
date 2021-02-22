-- 조인과 집계 데이터 - 18. 실습 문제 - 1

-- rental 테이블을 이용하여 연, 연월, 연월일, 전체 각각의 기준으로 rental_id 기준 렌탈이 일어난 횟수를 출력하라. (전체 데이터 기준으로 모든행을 출력)

select
	d.y,
	d.m,
	d.d,
	count(d.rental_id) as cnt
from
	(
	select
		to_char(r.rental_date, 'YYYY') as y,
		to_char(r.rental_date, 'MM') as m,
		to_char(r.rental_date, 'DD') as d,
		r.rental_id
	from
		rental r ) d
group by
	grouping sets (
	(d.y, d.m, d.d),
	(d.y, d.m),
	(d.y),
	()
	)
order by
	d.y,
	d.m,
	d.d

---------------------------------------------

select
	to_char(r.rental_date, 'YYYY') as y,
	to_char(r.rental_date, 'MM') as m,
	to_char(r.rental_date, 'DD') as d,
	count(r.rental_id)
from
	rental r 
group by
rollup
(
	to_char(r.rental_date, 'YYYY'),
	to_char(r.rental_date, 'MM'),
	to_char(r.rental_date, 'DD')
) -- roll up 절은 YYYY, MM, DD 기준 소계 + YYYY, MM 기준 소계 + YYYY 기준 소계 + 전체 소계 출력. 이때 맨 앞의 컬럼에 대해서 단독으로 소계를 출력한다. (YYYY 기준 소계)
order by
	y,
	m,
	d