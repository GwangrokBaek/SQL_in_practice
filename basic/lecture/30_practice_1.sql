-- 집합 연산자와 서브쿼리 - 09. 실습문제-1

-- 아래 SQL 문은 film 테이블을 2번이나 스캔하고 있다. film 테이블을 한번만 scan하여 동일한 결과 집합을 구하는 SQL을 작성하라.

select
	film_id,
	title,
	rental_rate
from
	film
where
	rental_rate > (
	select
		avg(rental_rate)
	from
		film )

-----------------------------------

select
	film_id,
	title,
	rental_rate
from
	(
	select
		film_id,
		title,
		rental_rate,
		avg(rental_rate) over() as avg_rental_rate -- over() 함수를 사용하여 group by나 서브쿼리를 사용하지 않고도, 
												   -- 분석 함수(sum, max, count 등등..)와 집계 함수(group by, order by 등등..)를 사용할 수 있다.
	from
		film ) a
where
	a.rental_rate > a.avg_rental_rate
------------------------------------

-- over 함수의 인자로는 over(partition by 컬럼 / order by 컬럼 / 세부 분할 기준) 이 올 수 있다.
-- 이때 인자는 필요한 경우에만 작성해주면 된다.

-- partition by 컬럼은 어느 컬럼을 기준으로 분리할지를 의미하며, group by와 동일한 기능을 수행한다.
-- order by 컬럼은 정렬 시 기준을 설정해준다.
-- 세부 분할 기준은 조건에 맞는 row를 가지고 정렬하는 rows between start_point and end_point 와,
-- 조건에 맞는 값을 가지고 정렬하는 range between start_point and end_point 가 있다.

-- start_point에는 다음이 올 수 있다.
-- unbounded preceding - 첫 줄부터
-- current row - 현재 줄까지
-- 값 preceding - ~ 값 부터

-- end_point에는 다음이 올 수 있다.
-- unbounded following - 마지막 줄까지
-- current row - 현재 줄까지
-- 값 following - ~ 값 까지

select
	deptno,
	ename,
	job,
	sal,
	avg(sal) over (partition by deptno
					   order by sal
					   rows between 1 preceeding
					   			and 2 following) as over_col
from
	scott.emp
where
	deptno = '30'