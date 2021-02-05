-- 1. film 테이블을 활용하여, film 테이블의 100개의 row만 확인해보세요. 

select
	*
from
	film f
limit 100

-- 2. actor의 성(last_name) 이 Jo 로 시작하는 사람의 id 값이 가장 낮은 한 사람에 대하여,
-- 그 사람의 id 값과 이름, 성을 알려주세요.

select
	actor_id,
	first_name,
	last_name
from
	actor
where
	last_name like 'Jo%'
order by
	actor_id asc
limit 1

-- 3. film 테이블을 이용하여, film 테이블의 아이디값이 1 ~ 10 사이에 있는 모든 칼럼을 확인해주세요. 

select
	*
from
	film f2
where
	film_id between 1 and 10

---------------------------------
	
select
	*
from
	rental r
where
	rental_date between '2005-05-25 00:00:00' and '2005-05-25 12:00:00'

-- 숫자 뿐만 아니라 time stamp에도 사용 가능하다. 

---------------------------------

-- 4. country 테이블을 이용하여, country 이름이 A 로 시작하는 country 를 확인해주세요.

select
	*
from
	country c
where
	country like 'A%'
	
-- 5. country 테이블을 이용하여, country 이름이 s 로 끝나는 country를 확인해주세요.

select
	*
from
	country c
where
	country like '%s'

-- 6. address 테이블을 이용하여, 우편번호(postal_code) 값이 77로 시작하는 주소에 대하여, address_id, address, district, postal_code 컬럼을 확인해주세요.

select
	address_id,
	address,
	district,
	postal_code
from
	address a
where
	postal_code like '77%'

-- 7. address 테이블을 이용하여, 우편번호(postal_code) 값이 두번째글자가 1인 우편번호의 address_id, address, district, postal_code 컬럼을 확인해주세요.

select
	address_id,
	address,
	district,
	postal_code
from
	address a
where
	postal_code like '_1%'
	
---------------------------

-- substring 함수를 활용해 데이터의 일부분만 가져올 수 있다.
select
	address_id,
	address,
	district,
	postal_code,
	substring(postal_code, 1, 1) test1, -- postal_code에서 1번째 위치부터 값 1개를 가져와 test1 항목으로 출력한다.
	substring(postal_code, 2, 1) test2  -- postal_code에서 2번째 위치부터 값 1개를 가져와 test2 항목으로 출력한다. 
from
	address a
	
---------------------------

select
	address_id,
	address,
	district,
	postal_code,
	substring(postal_code, 2, 1) test1
from
	address a
where
	substring(postal_code, 2, 1) = '1' -- postal_code 가 숫자가 아닌 문자열 데이터이므로 문자 1과 비교를 해주어야 한다. 

---------------------------
	
-- 8. payment 테이블을 이용하여, 고객번호가 341에 해당하는 사람이 결제를 2007년 2월 15~16일 사이에 한 모든 결제내역을 확인해주세요.

select
	*
from
	payment p
where
	customer_id = 341
	and cast(payment_date as date) between '2007-02-15' and '2007-02-16'

	
-- 9. payment 테이블을 이용하여, 고객번호가 355에 해당하는 사람의 결제 금액이 1~3원 사이에 해당하는 모든 결제 내역을 확인해주세요.

select
	*
from
	payment p
where
	customer_id = 355
	and amount between 1 and 3
	
-- 10. customer 테이블을 이용하여, 고객의 이름이 Maria, Lisa, Mike 에 해당하는 사람의 id, 이름, 성을 확인해주세요.

select
	customer_id,
	first_name,
	last_name
from
	customer
where
	first_name = 'Maria'
	or first_name = 'Lisa'
	or first_name = 'Mike'

-- 11. film 테이블을 이용하여, film의 길이가 100~120에 해당하거나 또는 rental 대여기간이 3~5일에 해당하는 film의 모든 정보를 확인해주세요.
	
select
	*
from
	film f
where
	length between 100 and 120
	or rental_duration between 3 and 5
	
-- 12. address 테이블을 이용하여, postal_code 값이 공백('') 이거나 35200, 17886 에 해당하는 address 의 모든 정보를 확인해주세요.

select
	*
from
	address a
where
	postal_code = ''
	or postal_code = '35200'
	or postal_code = '17886'
	
-- 13. address 테이블을 이용하여, address의 상세주소(=address2) 값이 존재하지 않는 모든 데이터를 확인해 주세요.

select
	*
from
	address a2
where
	address2 is null

-- 14. staff 테이블을 이용하여, staff의 picture 사진의 값이 있는 직원의 id, 이름, 성을 확인해주세요. 단 이름과 성을 하나의 컬럼
-- 이름, 성의 형태로 새로운 컬럼 name 으로 만들어주세요.
	
select
	staff_id,
	(first_name || ' ' || last_name) as name
from
	staff s
where
	picture is not null
	
-- 15. rental 테이블을 이용하여, 대여는 했으나 아직 반납 기록이 없는 대여건의 모든 정보를 확인해주세요.

select
	*
from
	rental r
where
	return_date is null

-- 16. address 테이블을 이용하여, address2의 값이 빈 값(NULL) 이거나 postal_code의 값이 35200, 17886에 해당하는 address 의 모든 정보를 확인해주세요.

select
	*
from
	address a
where
	address2 is null
	or postal_code = '35200'
	or postal_code = '17886'
	
-- 17. 고객의 성에 John 이라는 단어가 들어가는, 고객의 이름과 성을 모두 찾아주세요.

select
	first_name,
	last_name
from
	customer c
where
	last_name like '%John%'
	
-- 18. 주소 테이블에서 address2 값이 null 값인 row 전체를 확인해주세요.

select
	*
from
	address a
where
	address2 is null