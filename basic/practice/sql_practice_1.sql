-- 1. dvd 렌탈 업체의 dvd 대여가 있었던 날짜 확인 

select
	distinct date(rental_date)
	-- date 이용시 날짜 타입으로 변환 가능 

	from rental
order by
	1 asc ;

----------------------------------

-- 2. 영화길이가 120분 이상이면서, 대여기간이 4일 이상이 가능한, 영화제목은?

select
	title
from
	film
where
	length >= 120
	and rental_duration >= 4
	
-- 3. 직원의 id가 2번인 직원의 id, 이름, 성을 알려주세요.
select
	staff_id,
	first_name,
	last_name
from
	staff s
where
	staff_id = 2

-- 4. 지불 내역 중, 지불 내역 번호가 17510에 해당하는, 고객의 지출 내역 (amount)는 얼마인가?
select
	amount
from
	payment
where
	payment_id = 17510

-- 5. 영화 카테고리 중에서, Sci-Fi 카테고리의 카테고리 번호는 몇 번인가?
select
	category_id
from
	category
where
	name = 'Sci-Fi'

/*
 * 이걸로도 주석 가능 
 */

 
-- 6. film 테이블을 활용하여 rating 등급에 대해서, 몇 개의 등급이 있는지 확인.
select
	distinct rating
from
	film

-- 7. 대여 기간이 (회수 - 대여) 10일 이상이었던 rental 테이블에 대한 모든 정보를 알려주세요.
-- 단, 대여 기간은 대여일자부터 대여기간으로 포함하여 계산.

select
	*,
	date(return_date),
	date(rental_date),
	date(return_date) - date(rental_date) + 1 as chk
	-- as 이용해서 이름을 지어줄 수 있다.
from
	rental
where
	date(return_date) - date(rental_date) + 1 >= 10
	
-- 8.고객의 id가 50, 100, 150 .. 등 50번의 배수에 해당하는 고객들에 대해서, 회원 가입
-- 감사 이벤트를 진행하려고 한다. 고객의 아이디가 50번 배수인 아이디와, 고객의 이름 (성, 이름)과 이메일에 대해서 확인해주세요.

select
	customer_id,
	-- last_name,
	-- first_name,
	last_name || ' ' || first_name as full_name, -- || 은 concat 연산자로 두 데이터를 합칠때 사용 
	-- last_name || ', ' || first_name as full_name
	email
from
	customer
where
	-- customer_id % 50 = 0
	mod(customer_id, 50) = 0 -- mod 함수는 % 연산을 수행

-- 9.영화 제목의 길이가 8글자인, 영화 제목 리스트를 나열해주세요.
select
	title
from
	film
where
	length(title) = 9
	-- length 함수는 공백을 포함한 문자열 길이를 반환하는 함수

-- 10. city 테이블의 city 갯수는 몇개인가?
select
	count(distinct city)
	-- count는 row의 총 개수를 출력하는 함수 

	from city ;

select
	max(city_id)
	-- but 중복 존재 

	from city

-- 11. 영화배우의 이름 (이름 + ' ' + 성) 에 대해서, 대문자로 이름을 보여주세요.
-- 단 고객의 이름이 동일한 사람이 있다면, 중복을 제거하고 알려주세요.
select
	distinct UPPER(first_name || ' ' || last_name) as full_name
	-- UPPER 은 문자를 대문자로 바꿔주는 함수 
--select distinct lower(first_name || ' ' || last_name) as full_name
	-- lower 은 문자를 소문자로 바꿔주는 함

	from actor a

-- 12. 고객 중에서, active 상태가 0인 즉 현재 사용하지 않고 있는 고객의 수를 알려주세요.
select
	count(*)
from
	customer
where
	active = 0

-- 13. customer 테이블을 활용하여, store_id = 1 에 매핑된 고객의 수는 몇명인지 확인.
select
	count(*)
from
	customer
where
	store_id = 1
	
-- 14. rental 테이블을 활용하여, 고객이 return 했던 날짜가 2005년 6월 20일에 해당했던 rental 의 갯수가 몇개였는지 확인.
select
	count(*)
from
	rental
where
	date(return_date) = date('2005-06-20')

-- 15. film 테이블을 활용하여, 2006년에 출시가 되고 rating이 'G' 등급에 해당하며, 대여기간이 3일에 해당하는 것에 대한
-- film 테이블의 모든 컬럼을 알려주세요.
select
	*
from
	film
where
	rating = 'G'
	and release_year = 2006
	and rental_duration = 3

-- 16. language 테이블에 있는 id, name 컬럼을 확인해보세요.
select
	language_id,
	name
from
	language

-- 17. film 테이블을 활용하여, rental_duration이 7일 이상 대여가 가능한 film 에 대해서 film_id, title, description 컬럼을 확인해보세요.
select
	film_id,
	title,
	description
from
	film f
where
	rental_duration >= 7

-- 18. film 테이블을 활용하여, rental duration 대여가 가능한 3일 또는 5일에 해당하는 film_id, title, description 을 확인해주세요.
select
	film_id,
	title,
	description
from
	film f
where
	rental_duration = 3
	or rental_duration = 5
	
-- 19. Actor 테이블을 이용하여, 이름이 Nick 이거나 성이 Hunt 인 배우의 id 와 이름, 성을 확인해주세요.
select
	actor_id,
	first_name,
	last_name
from
	actor a
where
	first_name = 'Nick'
	or last_name = 'Hunt'

-- 20. Actor 테이블을 이용하여, Actor 테이블의 first_name 컬럼과 last_name 컬럼을, firstname, lastname 으로 컬럼명을 바꿔서 보여주세요.
select
	first_name as firstname,
	last_name as lastname
from
	actor a