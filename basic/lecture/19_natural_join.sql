-- 조인과 집계 데이터 - 07. NATURAL 조인 

-- Natural 조인의 경우 실무에서 많이 쓰이지는 않는다. but Natural 조인을 통해 Inner join을 더 깊게 이해할 수가 있다.
-- 두 개의 테이블에서 같은 이름을 가진 컬럼 간의 Inner 조인 집합 결과를 출력한다. SQL문 자체가 간소해 지는 방법이다.

create table categories 
(
category_id serial primary key,
category_name varchar (255) not null
)

create table products
(
product_id serial primary key,
product_name varchar (255) not null,
category_id int not null,
foreign key (category_id) references c ategories (category_id) -- 외래키 제약조건, 참조 무결성 제약조건
-- product는 무조건 1개의 카테고리 (다른 테이블) 를 참조해야함을 의미.
)

insert into categories
(category_name)
values
('Smart Phone'),
('Laptop'),
('Tablet')

insert into products
(product_name, category_id)
values
('iPhone', 1),
('Samsung Galaxy', 1),
('HP Elite', 2),
('Lenovo Thinkpad', 2),
('iPad', 3),
('Kindle Fire', 3)

---------------------------------------
-- Natural Join은 특정 컬럼을 따로 명시해주지 않더라도 자동으로 특정 컬럼을 기준으로 테이블을 결합해준다. 하지만 이 자동이라는 것이
-- 100% 안정성을 보장하지 않기때문에 주의해서 사용하고, 실무에서 많이 사용하지는 않음.
-- 여기서는 두 테이블이 category_id 라는 공통의 컬럼을 가지므로, 해당 컬럼을 기준으로 테이블을 결합해준다.

select
	*
from
	products a
natural join
	categories b
	
-- natural join을 사용한 위 sql은 inner join을 사용한 아래 sql 과 동일하다.
---------------------------------------
	
select
	a.category_id ,
	a.product_id ,
	a.product_name ,
	c.category_name
from
	products a
inner join categories c on
	a.category_id = c.category_id 

----------------------------------------
	
select
	a.category_id ,
	a.product_id ,
	a.product_name ,
	c.category_name
from
	products a,
	categories c
where
	a.category_id = c.category_id
	
----------------------------------------
	
select
	*
from
	city a
natural join country b;

-- 위 natural join은 city와 country 테이블 간에 공통되는 컬럼이 있는데도 불구하고 결과 값을 출력하지 않는데,
-- 이는 공통되는 컬럼이 2개이고 그 중 하나가 last update 컬럼으로 이 컬럼은 실시간 데이터므로 같은 값을 가지기 어렵기 때문에 출력되는 값이 없는 것.
-- 따라서 예상치 못하게 데이터가 출력되지 않을 수 있고, 이러한 이유로 Natural Join은 잘 사용되지 않고, 보통 아래처럼 Inner Join을 사용한다.
-----------------------------------------

select
	*
from
	city a
inner join country b on
	a.country_id = b.country_id

-- 아래처럼도 가능.
-----------------------------------------

select
	*
from
	city a,
	country b
where
	a.country_id = b.country_id