-- 문제1번) 고객의 기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone 번호를 함께 보여주세요. 	
select
	c.customer_id ,
	c.first_name ,
	c.last_name ,
	c.email ,
	a.address ,
	a.district ,
	a.postal_code ,
	a.phone
from
	customer c
inner join address a on -- inner join은 데이터의 교집합을 출력. 따라서 address_id가 NULL이라면 출력이 안됨.
	c.address_id = a.address_id
order by
	c.customer_id

-- 문제2번) 고객의  기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone , city 를 함께 알려주세요. 	

select
	c.customer_id ,
	c.first_name ,
	c.last_name ,
	c.email ,
	a.address ,
	a.district ,
	a.postal_code ,
	a.phone ,
	c2.city
from
	customer c
inner join address a on
	c.address_id = a.address_id
inner join city c2 on
	c2.city_id = a.city_id
order by
	c.customer_id

-- 문제3번) Lima City에 사는 고객의 이름과, 성, 이메일, phonenumber에 대해서 알려주세요.	

select
	c.first_name ,
	c.last_name ,
	c.email ,
	a.phone
from
	customer c
inner join address a on
	c.address_id = a.address_id
inner join city c2 on
	c2.city_id = a.address_id
where
	-- c2.city = 'Lima'
	c2.city in ('Lima') -- Lima 딱 하나만이 아닌, 다른 city에 대해서도 쉽게 출력하기 위해 in 절 사용.
	-- c2.city in ('Lima', 'Nador', 'New York') -- and 쓸 필요 없이 쉽게 출력가능.

-- 문제4번) rental 정보에 추가로, 고객의 이름과, 직원의 이름을 함께 보여주세요.
-- - 고객의 이름, 직원 이름은 이름과 성을  fullname 컬럼으로만들어서 직원이름/고객이름 2개의 컬럼으로 확인해주세요.	

select
	c.first_name || ' ' || c.last_name as customer_name,
	s.first_name || ' ' || s.last_name as staff_name,
	r.* -- rental 테이블의 모든 정보를 출력.
from
	rental r
inner join customer c on
	c.customer_id = r.customer_id
inner join staff s on
	s.staff_id = r.staff_id
order by
	c.customer_id
	
-- 문제5번) seth.hannon@sakilacustomer.org 이메일 주소를 가진 고객의  주소 address, address2, postal_code, phone, city 주소를 알려주세요.	

select
	a.address ,
	a.address2 ,
	a.postal_code ,
	a.phone ,
	c2.city
from
	customer c
inner join address a on
	c.address_id = a.address_id
inner join city c2 on
	c2.city_id = a.city_id
where
	c.email = 'seth.hannon@sakilacustomer.org'
	
-- 문제6번) Jon Stephens 직원을 통해 dvd대여를 한 payment 기록 정보를  확인하려고 합니다. 
--      - payment_id,  고객 이름 과 성,  rental_id, amount, staff 이름과 성을 알려주세요. 	

select
	p.payment_id ,
	c.first_name ,
	c.last_name ,
	p.rental_id ,
	p.amount ,
	s.first_name ,
	s.last_name
from
	payment p
inner join staff s on
	p.staff_id = s.staff_id
inner join customer c on
	c.customer_id = p.customer_id
where
	s.first_name = 'Jon'
	and s.last_name = 'Stephens'
	
-- 문제7번) 배우가 출연하지 않는 영화의 film_id, title, release_year, rental_rate, length 를 알려주세요. 	

select
	f.film_id ,
	f.title ,
	f.release_year ,
	f.rental_rate ,
	f.length
from
	film f
left outer join film_actor fa on -- 배우가 출연하지 않는 영화를 검색하는 것이므로 해당 데이터가 NULL로 되어있을 것이다.
								 -- 이때 inner join을 사용하면 스킵하게 되므로, left outer join을 사용해줘야 함.
	fa.film_id = f.film_id
left outer join actor a on
	fa.actor_id = a.actor_id
where
	a.actor_id is null
	
-- 문제8번) store 상점 id별 주소 (address, address2, distict) 와 해당 상점이 위치한 city 주소를 알려주세요. 	

select
	s.store_id,
	a.address,
	a.address2,
	a.district,
	c.city
from
	store s
left outer join address a on
	s.address_id = a.address_id
left outer join city c on
	c.city_id = a.city_id
order by
	s.store_id
	
-- 문제9번) 고객의 id 별로 고객의 이름 (first_name, last_name), 이메일, 고객의 주소 (address, district), phone번호, city, country 를 알려주세요. 	

select
	c.first_name || ' ' || c.last_name as customer_name,
	c.email ,
	a.address || ' ' || a.district as customer_address,
	a.phone ,
	c2.city ,
	c3.country
from
	customer c
inner join address a on
	c.address_id = a.address_id
inner join city c2 on
	c2.city_id = a.city_id
inner join country c3 on
	c2.country_id = c3.country_id
order by
	c.customer_id
	
-- 문제10번) country 가 china 가 아닌 지역에 사는, 고객의 이름(first_name, last_name)과 , email, phonenumber, country, city 를 알려주세요	

select
	c.first_name || ' ' || c.last_name as customer_name,
	c.email ,
	a.phone ,
	c3.country ,
	c2.city
from
	customer c
inner join address a on
	c.address_id = a.address_id
inner join city c2 on
	c2.city_id = a.city_id
inner join country c3 on
	c3.country_id = c2.country_id
where
	-- c3.country <> 'china'
	c3.country not in ('china') -- not in 으로도 가능.
	-- inner join이기 때문에 address_id, city_id, country_id 가 명확하게 지정된 고객의 데이터만 조회함. 즉, NULL은 조회 안함.

-- 문제11번) Horror 카테고리 장르에 해당하는 영화의 이름과 description 에 대해서 알려주세요 	

select
	f.title ,
	f.description
from
	film f
inner join film_category fc on
	fc.film_id = f.film_id
inner join category c on
	c.category_id = fc.category_id
where
	c.name = 'Horror'

-- 문제12번) Music 장르이면서, 영화길이가 60~180분 사이에 해당하는 영화의 title, description, length 를 알려주세요.
--   -  영화 길이가 짧은 순으로 정렬해서 알려주세요. 	
 
select
	f.title ,
	f.description ,
	f.length
from
	film f
inner join film_category fc on
	f.film_id = fc.film_id
inner join category c on
	c.category_id = fc.category_id
where
	c.name = 'Music'
	and f.length between 60 and 180
	
-- 문제13번) actor 테이블을 이용하여,  배우의 ID, 이름, 성 컬럼에 추가로    'Angels Life' 영화에 나온 영화 배우 여부를 Y , N 으로 컬럼을 추가 표기해주세요.  해당 컬럼은 angelslife_flag로 만들어주세요.	         

select
	a.actor_id ,
	a.first_name ,
	a.last_name ,
	case
		angels_actor.title when 'Angels Life' then 'Y' -- 밑에서 Angels Life 찍은 배우들에 대한 정보만 있는 테이블과 전체 actor 테이블 join 해주고 있으므로
													   -- Angels Life 안찍은 배우들에 대해서는 title 정보가 NULL로 나올 것이기에 case 절 사용해서 이를 구별.
		else 'N'
	end as angelslife_flag
from
	actor a
left outer join ( -- 아직 영화를 안찍은 actor도 있을 것이기에 left outer join 사용.
	select
		*
	from
		film_actor fa
	inner join film f on -- 중복되는 배우들 없애주기 위해 film_actor 테이블과 film 테이블 join 해주고, Angels Life 찍은 배우들만 따로 결합.
		f.film_id = fa.film_id
	where
		f.title = 'Angels Life' ) as angels_actor on
	a.actor_id = angels_actor.actor_id

-- 문제14번) 대여일자가 2005-06-01~ 14일에 해당하는 주문 중에서 , 직원의 이름(이름 성) = 'Mike Hillyer' 이거나  고객의 이름이 (이름 성) ='Gloria Cook'  에 해당 하는 rental 의 모든 정보를 알려주세요.
--  - 추가로  직원이름과, 고객이름에 대해서도  fullname 으로 구성해서 알려주세요.	

select
	s.first_name || ' ' || s.last_name as staff_fullname,
	c.first_name || ' ' || c.last_name as customer_fullname,
	r.*
from
	rental r
inner join staff s on
	r.staff_id = s.staff_id
inner join customer c on
	r.customer_id = c.customer_id
where
	(s.first_name || ' ' || s.last_name = 'Mike Hillyer'
	or c.first_name || ' ' || c.last_name = 'Gloria Cook')
	-- and to_char(r.rental_date, 'YYYY-MM-DD') between '2005-06-01' and '2005-06-14'
	and date(r.rental_date) between '2005-06-01' and '2005-06-14' -- date 함수를 사용하면 time stamp 데이터를 날짜 데이터로 변환 가능.
	
-- 문제15번) 대여일자가 2005-06-01~ 14일에 해당하는 주문 중에서 , 직원의 이름(이름 성) = 'Mike Hillyer' 에 해당 하는 직원에게  구매하지 않은  rental 의 모든 정보를 알려주세요.
-- - 추가로  직원이름과, 고객이름에 대해서도  fullname 으로 구성해서 알려주세요.

select
	s.first_name || ' ' || s.last_name as staff_fullname,
	c.first_name || ' ' || c.last_name as customer_fullname,
	r.*
from
	rental r
inner join staff s on
	r.staff_id = s.staff_id
inner join customer c on
	r.customer_id = c.customer_id
where
	-- s.first_name || ' ' || s.last_name <> 'Mike Hillyer'
	s.first_name || ' ' || s.last_name not in ('Mike Hillyer') -- not in 으로도 검색 가능.
	-- and to_char(r.rental_date, 'YYYY-MM-DD') between '2005-06-01' and '2005-06-14'
	and date(r.rental_date) between '2005-06-01' and '2005-06-14' -- date 함수 이용해서 time stamp 데이터 날짜 데이터로 변환 가능.