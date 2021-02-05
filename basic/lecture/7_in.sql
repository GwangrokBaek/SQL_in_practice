-- 데이터 조회와 필터링 - 07. IN 연산자

select
	customer_id,
	rental_id,
	return_date
from
	rental r
where
	customer_id in (1, 2) -- customer_id 열에서 1 또는 (or 조건) 2의 값에 대해서 출력 
order by
	return_date desc ;
	
---------------------------------

select
	customer_id,
	rental_id,
	return_date
from
	rental r
where
	customer_id = 1 -- in 연산자는 or 과 = 를 적용한 것과 같다. 
	or customer_id = 2
order by
	return_date desc ;

-- 가독성, 알아보기 쉽다.
-- 옵티마이저의 특성상 IN 조건이 성능상 유리할때가 많다.

-------------------------------

select
	customer_id,
	rental_id,
	return_date
from
	rental r
where
	customer_id not in (1, 2) -- 1 과 2를 제외한 나머지 출력 
order by
	return_date desc; -- NULL 이 가장 큰 값이므로 NULL 부터 출력 
	
---------------------------------

select
	customer_id,
	rental_id,
	return_date
from
	rental
where
	customer_id <> 1
	and customer_id <> 2 -- not in 연산자는 and 와 <> 를 적용한 것과 같다. 
order by
	return_date desc;

----------------------------------

select
	customer_id
from
	rental r
where
	cast (return_date as date) = '2005-05-27'; -- return_date가 '2005-05-27'인 서브쿼리를 생성 
-- 서브 쿼리는 소괄호로 감싸서 생성한다. 
-- 여기서 cast 연산자는 형 변환에 사용된다. 
---------------------------------

select
	first_name, -- 밑의 서브 쿼리에서 가져온 customer_id 를 기준으로 customer 테이블에서 first_name, last_name 출력 
	last_name
from
	customer c
where
	customer_id in ( -- rental 테이블에서 return_date 가 2005-05-27인 customer_id 선택 
	select
		customer_id
	from
		rental r2
	where
		cast ( return_date as date ) = '2005-05-27' ) ;

-- rental 테이블에서 customer 테이블의 first_name, last_name을 관리하지 않는 이유는 데이터의 중복이 없게끔 하기 위해서이다. 
-- 이미 customer 테이블에서 first_name 과 last_name 을 관리하고 있으므로 중복하여 다른 table 에서도 이를 관리하게끔 할 필요가 없다. 