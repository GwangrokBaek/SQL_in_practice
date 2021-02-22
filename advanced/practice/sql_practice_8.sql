문제1번) dvd 대여를 제일 많이한 고객 이름은? (analytic funtion 활용)

select
	row_number () over(order by count(*) desc) as rank,
	count(*) as cnt,
	max(c.first_name) as first_name,
	max(c.last_name) as last_name
from
	rental r
inner join customer c on
	r.customer_id = c.customer_id
group by
	r.customer_id
limit 1

문제2번) 매출을 가장 많이 올린 dvd 고객 이름은? (analytic funtion 활용)	

select
	row_number () over(
	order by sum(p.amount) desc) as rank,
	sum(p.amount) as amount,
	max(c.first_name) as first_name,
	max(c.last_name) as last_name
from
	payment p
inner join customer c on
	p.customer_id = c.customer_id
group by
	p.customer_id
limit 1

문제3번) dvd 대여가 가장 적은 도시는? (anlytic funtion)	

select
	row_number () over(
	order by count(r.rental_id)) as rank,
	count(r.rental_id),
	c2.city
from
	rental r
inner join customer c on
	r.customer_id = c.customer_id
inner join address a on
	c.address_id = a.address_id
inner join city c2 on
	a.city_id = c2.city_id
group by
	c2.city
limit 1

문제4번) 매출이 가장 안나오는 도시는? (anlytic funtion)	

select
	row_number () over(
	order by sum(p.amount)) as rank,
	sum(p.amount) as amount,
	c2.city
from
	payment p
inner join customer c on
	p.customer_id = c.customer_id
inner join address a on
	a.address_id = c.address_id
inner join city c2 on
	a.city_id = c2.city_id
group by
	c2.city
limit 1

문제5번) 월별 매출액을 구하고 이전 월보다 매출액이 줄어든 월을 구하세요. (일자는 payment_date 기준)	

select d.month, d.amount,
case when d.amount < lag(d.amount, 1) over(order by d.month) then 'True'
else 'False' end as flag
from(
select
	to_char(p.payment_date, 'YYYY-MM') as month,
	sum(p.amount) as amount
from
	payment p
group by
	to_char(p.payment_date, 'YYYY-MM')
) d

-----------------------------------------

select
	*
from
	(
	select
		extract (year from date(p.payment_date)) as yr, -- extract 함수는 특정 키워드에 대해서만 추출해줄수가 있다.
		extract (month from date(p.payment_date)) as mon,
		sum(p.amount) as sum_amount,
		coalesce (lag(sum(p.amount), 1) over(order by extract (month from date(p.payment_date))), 0) as pre_mon_amount,
		-- coalesce 는 null 데이터를 특정 값으로 바꿔줄 수 있다.
		sum(amount) - coalesce (lag(sum(p.amount), 1) over(order by extract (month from date(p.payment_date))), 0) as gap
	from
		payment p
	group by
		extract (year from date(p.payment_date)),
		extract (month from date(p.payment_date))
	) d
where
	d.gap < 0 


문제6번) 도시별 dvd 대여 매출 순위를 구하세요. 

select
	c2.city,
	row_number () over(
	order by count(r.rental_id) desc) as rank,
	count(r.rental_id) as cnt
from
	rental r
inner join customer c on
	r.customer_id = c.customer_id
inner join address a on
	c.address_id = a.address_id
inner join city c2 on
	a.city_id = c2.city_id
group by
	c2.city

문제7번) 대여점별 매출 순위를 구하세요.	

select
	s.store_id ,
	row_number () over(
	order by sum(p.amount) desc) as rank,
	sum(p.amount) as amount
from
	payment p
inner join staff s on
	p.staff_id = s.staff_id
group by
	s.store_id

문제8번) 나라별로 가장 대여를 많이한 고객 TOP 5를 구하세요. 	

select
	*
from
	(
	select
		d.*,
		c4.first_name ,
		c4.last_name
	from
		(
		select
			c3.country,
			row_number () over(partition by c3.country order by count(r.rental_id)) as rank,
			c.customer_id
		from
			rental r
		inner join customer c on
			r.customer_id = c.customer_id
		inner join address a on
			c.address_id = a.address_id
		inner join city c2 on
			a.city_id = c2.city_id
		inner join country c3 on
			c2.country_id = c3.country_id
		group by
			c3.country,
			c.customer_id
		order by
			c3.country ) d
	inner join customer c4 on
		c4.customer_id = d.customer_id ) d
where
	d.rank <= 5


문제9번) 영화 카테고리 (Category) 별로 대여가 가장 많이 된 영화 TOP 5를 구하세요	

select
	*
from
	(
	select
		c."name" ,
		row_number () over( partition by c.name order by count(r.rental_id) desc, f.title) as rank,
		f.title,
		count(r.rental_id) as rental_count
	from
		category c
	inner join film_category fc on
		c.category_id = fc.category_id
	inner join film f on
		f.film_id = fc.film_id
	inner join inventory i on
		i.film_id = f.film_id
	inner join rental r on
		i.inventory_id = r.inventory_id
	group by
		c."name",
		f.title
	order by
		c."name" ,
		rank ) d
where
	d.rank <= 5

문제10번) 매출이 가장 많은 영화 카테고리와 매출이 가장 작은 영화 카테고리를 구하세요. (first_value, last_value)	

select
	d.name,
	d.sum_amount
from
	(
	select
		c.name,
		sum(p.amount) as sum_amount,
		first_value (sum(p.amount)) over(order by sum(p.amount)) as first_val,
		last_value (sum(p.amount)) over(order by sum(p.amount) range between unbounded preceding and unbounded following) as last_val
	from
		category c
	inner join film_category fc on
		c.category_id = fc.category_id
	inner join inventory i on
		fc.film_id = i.film_id
	inner join rental r on
		i.inventory_id = r.inventory_id
	inner join payment p on
		r.rental_id = p.rental_id
	group by
		c."name" ) d
where
	d.sum_amount = first_val
	or d.sum_amount = last_val

--------------------------------------------------------------

select
	d.name,
	d.sum_amount
from
	(
	select
		c.name,
		sum(p.amount) as sum_amount,
		first_value (c.name) over(order by sum(p.amount)) as first_val,
		last_value (c.name) over(order by sum(p.amount) range between unbounded preceding and unbounded following) as last_val
	from
		payment p
	inner join rental r on
		p.rental_id = r.rental_id
	inner join inventory i on
		r.inventory_id = i.inventory_id
	inner join film_category fc on
		i.film_id = fc.film_id
	inner join category c on
		fc.category_id = c.category_id
	group by
		c.name ) d
where
	d.name in (d.first_val, d.last_val)