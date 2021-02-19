-- 1. 문제를 분할 정복 해야한다. 단계별로 접근.
-- 2. 먼저, 해당 테이블의 구성부터 확인.
-- 3. group by 절을 사용해야 할때 select 문에서 다른 컬럼도 조회해야하는 경우, from 절에 서브쿼리로 group by절을 사용하는 쿼리를 작성해주고,
-- 그 다음에 바깥 쿼리에서 inner join 또는 left outer join등을 사용해서 데이터 조회 
-- 4. group by 절의 기준 컬럼만을 select 절에서 사용가능하고, 만약 다른 컬럼을 사용하고 싶은 경우에는 count, sum 등의 집계 함수 사용시 다른 컬럼 적용 가능.
-- 5. having 절에도 group by 절의 기준 컬럼만을 사용가능하고, 만약 다른 컬럼을 사용하고 싶은 경우에는 count, sum 등의 집계 함수 사용시 다른 컬럼 적용 가능.

-- 문제1번) store 별로 staff는 몇명이 있는지 확인해주세요.	

select
	store_id,
	count(*) cnt
from
	staff s
group by
	store_id

-- 문제2번) 영화등급(rating) 별로 몇개 영화film을 가지고 있는지 확인해주세요.	

select
	f.rating,
	count(distinct film_id) cnt -- count안에 ditinct를 통해 중복 제거 가능. 여기서는 film_id가 유니크한 값이므로 distinct는 필요 없음.
from
	film f
group by
	f.rating

-- from - where - group by - order by 순으로 작성되어야 한다.

-- 문제3번) 출현한 영화배우(actor)가  10명 초과한 영화명은 무엇인가요?	

select
	f.title,
	count(f.title)
from
	film f ,
	film_actor fa
where
	f.film_id = fa.film_id
group by
	f.title
having
	count(f.title) > 10
order by f.title

----------------------------

select
	f.title,
	fc.cnt
from
	(
	select
		fa.film_id,
		count(*) cnt
	from
		film_actor fa
	group by
		fa.film_id
	having
		count(*) > 10 ) fc
inner join film f on
	f.film_id = fc.film_id

-- 문제4번) 영화 배우(actor)들이 출연한 영화는 각각 몇 편인가요?  
-- - 영화 배우의 이름 , 성 과 함께 출연 영화 수를 알려주세요.	

select
	fa.actor_id ,
	a.first_name ,
	a.last_name ,
	count(fa.film_id) cnt
from
	actor a
inner join film_actor fa on
	a.actor_id = fa.actor_id
group by
	fa.actor_id ,
	a.first_name ,
	a.last_name
order by fa.actor_id 

------------------------------

select
	d.*,
	a.first_name ,
	a.last_name
from
	(
	select
		fa.actor_id ,
		count(distinct fa.film_id) as cnt
	from
		film_actor fa
	group by
		fa.actor_id ) as d
left outer join actor as a on -- film_actor 테이블과 actor 테이블이 따로 관리되고 있으므로 actor에는 있는 데이터가 film_actor에는 없을 수도 있다.
							  -- 따라서 왼쪽 테이블의 데이터를 모두 살리기 위해 left outer join 사용.
	d.actor_id = a.actor_id

-- 문제5번) 국가(country)별 고객(customer) 는 몇명인가요?	

select
	c3.country ,
	count(c.customer_id) cnt
from
	customer c
inner join address a on
	a.address_id = c.address_id
inner join city c2 on
	c2.city_id = a.city_id
inner join country c3 on
	c3.country_id = c2.country_id
group by
	c3.country
order by
	count(c.customer_id) desc

-- 문제6번) 영화 재고 (inventory) 수량이 3개 이상인 영화(film) 는? 
-- - store는 상관 없이 확인해주세요.	

select
	f.title
	d.cnt
from
	(
	select
		i.film_id ,
		count(*) as cnt
	from
		inventory i
	group by
		i.film_id
	having
		count(*) >= 3 ) as d
inner join film f on
	f.film_id = d.film_id

-- 문제7번) dvd 대여를 제일 많이한 고객 이름은?	 

select
	c.first_name ,
	c.last_name ,
	count(r.customer_id) as cnt
from
	rental r
inner join customer c on
	r.customer_id = c.customer_id
group by
	r.customer_id ,
	c.first_name ,
	c.last_name
order by
	cnt desc
limit 1

-- 여러 데이터 출력 위해서는 group by 여러 개를 조회해야 하므로 아래처럼 from 절 안에서 group by 수행하고, 바깥에서 group by 없이 데이터 여러 개 출력 가능.
------------------------------------

select
	c2.first_name ,
	c2.last_name ,
	d.cnt
from
	(
	select
		r.customer_id ,
		count(r.customer_id) as cnt
	from
		rental r
	group by
		r.customer_id
	order by
		cnt desc
	limit 1 ) as d
inner join customer c2 on
	d.customer_id = c2.customer_id

-- 문제8번) rental 테이블을  기준으로,   2005년 5월26일에 대여를 기록한 고객 중, 하루에 2번 이상 대여를 한 고객의 ID 값을 확인해주세요.	

select
	r.customer_id ,
	count(r.customer_id)
from
	rental r
where
	date(r.rental_date) = '2005-05-26'
group by
	r.customer_id
having
	count(r.customer_id) >= 2

-- 문제9번) film_actor 테이블을 기준으로, 출현한 영화의 수가 많은  5명의 actor_id 와 , 출현한 영화 수 를 알려주세요.	

select
	fa.actor_id ,
	count(fa.film_id) as cnt
from
	film_actor fa
group by
	fa.actor_id
order by
	cnt desc
limit 5

-- 문제10번) payment 테이블을 기준으로,  결제일자가 2007년2월15일에 해당 하는 주문 중에서  ,  하루에 2건 이상 주문한 고객의  총 결제 금액이 10달러 이상인 고객에 대해서 알려주세요.  
-- (고객의 id,  주문건수 , 총 결제 금액까지 알려주세요)	

select
	p.customer_id,
	count(p.rental_id) as cnt,
	sum(p.amount) as sum_amount -- !!group by 절을 사용했을때 해당 기준을 안쓰더라도 count, sum 등 집계 함수를 사용하면 오류 발생 안함!!
from
	payment p
where
	date(p.payment_date) = '2007-02-15'
group by
	p.customer_id
having
	count(p.rental_id) >= 2
	and sum(p.amount) >= 10 -- !!having에서 group by에서 사용한 기준을 안쓰더라도 count, sum 등 집계 함수를 사용하면 오류 발생 안함!!

-- 문제11번) 사용되는 언어별 영화 수는?

select
	l.name ,
	count(l.name)
from
	language l
inner join film f on
	l.language_id = f.language_id
group by
	l.name

-- 문제12번) 40편 이상 출연한 영화 배우(actor) 는 누구인가요?	

select
	a.first_name ,
	a.last_name ,
	d.cnt
from
	( -- 40편 이상 찍은 영화배우의 id 먼저 집계
	select
		fa.actor_id ,
		count(*) cnt
	from
		film_actor fa
	group by
		fa.actor_id
	having
		count(*) >= 40 ) d
inner join actor a on -- 영화배우의 이름 출력하기 위해 40편 이상 찍은 영화배우의 id와 actor 테이블의 id inner join 수행.
	a.actor_id = d.actor_id
	
-- 문제13번) 고객 등급별 고객 수를 구하세요. (대여 금액 혹은 매출액  에 따라 고객 등급을 나누고 조건은 아래와 같습니다.)
/*
A 등급은 151 이상 
B 등급은 101 이상 150 이하 
C 등급은   51 이상 100 이하
D 등급은   50 이하

* 대여 금액의 소수점은 반올림 하세요. 

HINT
반올림 하는 함수는 ROUND 입니다.	
*/

select -- 3단계 각 등급의 count 계산.
	rating,
	count(customer_id) as cnt
from
	( -- 2단계 case 구문 사용해서 등급 나눠주기.
	select
		customer_id,
		case
			when sum_amount >= 151 then 'A'
			when sum_amount between 101 and 150 then 'B'
			when sum_amount between 51 and 100 then 'C'
			when sum_amount <= 50 then 'D'
			else 'Empty'
		end rating
	from
		( -- 1단계 고객별로 금액 정리.
		select
			p.customer_id ,
			round(sum(p.amount), 0) as sum_amount
		from
			rental r
		inner join payment p on
			r.rental_id = p.rental_id
		group by
			p.customer_id ) d
		) e
group by
	rating
order by rating

--------------------------------------
select
	case
		when rental_amount <= 50 then 'D'
		when rental_amount between 51 and 100 then 'C'
		when rental_amount between 101 and 150 then 'B'
		when rental_amount >= 151 then 'A'
	end customer_class,
	count(*) cnt
from
	(
	select
		r.customer_id ,
		round(sum(p.amount), 0) rental_amount
	from
		rental r
	inner join payment p on
		p.rental_id = r.rental_id
	group by
		r.customer_id ) r
group by
	case
		when rental_amount <= 50 then 'D'
		when rental_amount between 51 and 100 then 'C'
		when rental_amount between 101 and 150 then 'B'
		when rental_amount >= 151 then 'A'
	end
order by
	customer_class