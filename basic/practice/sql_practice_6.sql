문제1번) 매출을 가장 많이 올린 dvd 고객 이름은? (subquery 활용)

select
	c.first_name ,
	c.last_name,
	d.amount_sum
from
	(
	select
		p.customer_id ,
		sum(amount) amount_sum
	from
		payment p
	group by
		p.customer_id
	order by
		amount_sum desc
	limit 1 ) d
inner join customer c on
	d.customer_id = c.customer_id

------------------------------

select
	c.first_name ,
	c.last_name
from
	customer c
where
	c.customer_id in (
	select
		p.customer_id
	from
		payment p
	group by
		p.customer_id
	order by -- 집계 함수 order by 에도 분석 함수 사용 가능.
		sum(p.amount) desc
	limit 1 )

문제2번) 대여가 한번도이라도 된 영화 카테 고리 이름을 알려주세요. (쿼리는, Exists조건을 이용하여 풀어봅시다)

select
	c.name
from
	category c
inner join film_category fc on
	c.category_id = fc.category_id
where
	exists (
	select
		1
	from
		rental r
	inner join inventory i on
		r.inventory_id = i.inventory_id
	group by
		i.film_id )
group by c.name

------------------------------------

select
	c.name
from
	category c
where
	exists (
	select
		1
	from
		rental r
	inner join inventory i on
		i.inventory_id = r.inventory_id
	inner join film_category fc on
		i.film_id = fc.film_id
	where
		c.category_id = fc.category_id ) -- where exists 문은 비교시 사용하는 기준 컬럼을 따로 명시해주지 않으므로,
										 -- where 절을 이용해 컬럼을 매칭시켜줘야한다.

문제3번) 대여가 한번도이라도 된 영화 카테 고리 이름을 알려주세요. (쿼리는, Any 조건을 이용하여 풀어봅시다)

select
	c.name
from
	category c
where
	c.category_id = any (
	select
		fc.category_id
	from
		rental r
	inner join inventory i on
		r.inventory_id = i.inventory_id
	inner join film_category fc on
		i.film_id = fc.film_id )

문제4번) 대여가 가장 많이 진행된 카테고리는 무엇인가요? (Any, All 조건 중 하나를 사용하여 풀어봅시다)	

select
	c.name
from
	category c
where
	c.category_id = any (
	select
		fc.category_id
	from
		rental r
	inner join inventory i on
		r.inventory_id = i.inventory_id
	inner join film_category fc on
		i.film_id = fc.film_id
	group by
		fc.category_id
	order by
		count(fc.category_id) desc
	limit 1 )

문제5번) dvd 대여를 제일 많이한 고객 이름은? (subquery 활용)	 

select
	c.customer_id ,
	c.first_name ,
	c.last_name
from
	customer c
where
	c.customer_id in ( -- = any 연산자는 in 연산자와 동일하다.
	select
		r.customer_id
	from
		rental r
	group by
		r.customer_id
	order by
		count(r.customer_id) desc
	limit 1 )

문제6번) 영화 카테고리값이 존재하지 않는 영화가 있나요?	   

select
	*
from
	film f
where
	not exists (
	select
		1
	from
		film_category fc
	where
		f.film_id = fc.film_id )
		
------------------------------------

select
	*
from
	film f
where
	f.film_id not in ( -- not in과 not exists의 차이는 where 절에 특정 컬럼을 명시하는지와 이에 따른 서브쿼리안에 기준 컬럼을 잡아줄 where 절을 작성하는지 안하는지이다.
	select
		fc.film_id
	from
		film_category fc )

-------------------------------------
-- in 과 exists 는 서로 함수는 다르지만, 동일한 결과물을 출력하는 것이라고 생각해도 된다. 따라서 편한대로 둘 중 하나를 사용하면 된다.
-- 하지만, not in 과 not exists 는 null 에 의한 차이가 존재한다.
-- not in 에는 null 이 포함되지 않고, Not exists 에서는 null 이 포함된다.
-- is null, is not null

select
	*
from
	address a
where
	a.address2 in ( -- in 절은 = 과 동일한 연산을 수행하기 때문에 null을 = 로 연산하는 것이나 마찬가지여서 null 값이 출력되지 않는다.
	select
		null)

select
	*
from
	address a
where
	address2 not in ( -- 해당 데이터베이스는 address2가 ''와 null로 구성되기 때문에 not in을 사용하면 != 연산을 수행하는 것이라 null 값이 출력되지 않는다.
	select
		'')

select
	*
from
	address a
where
	not exists (
	select
		1
	from
		(
		select
			'' as a) as db -- !!공백을 a 라는 컬럼으로 생성.!!
	where
		db.a = a.address2 )