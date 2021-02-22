-- 조인과 집계 데이터 - 19. 실습 문제 - 2

-- rental과 customer 테이블을 이용하여 현재까지 가장 많이 rental을 한 고객의 고객 ID, 렌탈 순위, 누적 렌탈 횟수, 이름을 출력하라.

select
	c.customer_id ,
	row_number () over(order by d.cnt desc) ,
	d.cnt,
	c.first_name ,
	c.last_name
from
	(
	select
		r.customer_id ,
		count(rental_id) as cnt
	from
		rental r
	group by
		customer_id ) d
inner join customer c on
	d.customer_id = c.customer_id
order by
	d.cnt desc
limit 1

-----------------------------------------------------

select
	r.customer_id ,
	row_number () over(order by count(r.rental_id) desc) rental_rank,
	count (*) rental_count,
	max(c.first_name) as first_name,
	max(c.last_name) as last_name
from
	rental r
inner join customer c on
	r.customer_id = c.customer_id
group by
	r.customer_id
order by
	rental_rank
limit 1