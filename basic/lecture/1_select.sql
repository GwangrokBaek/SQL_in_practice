-- 데이터 조회와 필터링 1. select문
select *
from customer
;
-------------------------------------------
select --3
	first_name, --4
	last_name,
	email
	from --1
	customer --2
	;
-- 1번에서 4번 순으로 실행된다. 어느 테이블에서 어떤 속성의 데이터터를 조회할 것인
	--------------------------------------
select
	A.first_name,
	A.last_name,
	A.email
	from
	customer A-- alias 사용 
	;
	
-- ALIAS -> 코드의 가독성이 좋아짐. 테이블이 많아질수록 복잡해질 수 있는데 이때 alias를 이용해서 이름을 붙여주면 판별이 가능하다.
-- 또한 SQL 성능에도 좋다.
-- DBMS에는 옵티마이저가 있는데, alias를 사용하면 옵티마이저가 SQL을 빠르고 저비용으로 동작하게끔 하는데 도와준다.
--------------------------------------------
select rental_id,
rental_date,
customer_id 
from rental;