-- 조인과 집계 데이터 - 10. Grouping Set 절
-- Grouping Set 절을 사용하여 여러 개의 Union all 을 이용한 SQL과 같은 결과를 도출할 수 있다.

create tables sales
(
brand varchar not null,
segment varchar not null,
quantity int not null,
primary key (brand, segment)
)

insert into sales (brand, segment, quantity)
values
('ABC', 'Premium', 100),
('ABC', 'Basic', 200),
('XYZ', 'Premium', 100),
('XYZ', 'Basic', 300)

------------------------------------

select
	brand,
	segment,
	sum(quantity) -- group by 후 quantity 컬럼의 합계를 구한다.
from
	sales -- sales 테이블을 조회한다.
group by
	brand,
	segment -- brand와 segment 컬럼 기준으로 group by 한다.

select
	brand,
	sum(quantity)
from
	sales
group by
	brand

select
	segment,
	sum(quantity)
from
	sales
group by
	segment

select
	sum(quantity)
from
	sales

-- 이때 위 3 가지 조회를 결합하여 보고 싶다면 다음과 같이 union all을 사용할 수 있다.

select
	brand,
	segment,
	sum(quantity)
from
	sales
group by
	brand,
	segment
union all
select
	brand,
	null,
	sum(quantity)
from
	sales
group by
	brand
union all
select
	null,
	segment,
	sum(quantity)
from
	sales
group by
	segment
union all
select
	null,
	null,
	sum(quantity)
from
	sales

-- 하지만, 동일한 테이블을 4번이나 읽고 있기에 성능 저하 가능성이 존재하며, sql 문이 매우 길어지므로 복잡해져 유지보수가 어려워진다.
-----------------------------------------

select
	brand,
	segment,
	sum(quantity)
from
	sales
group by
	grouping sets (
	(brand,segment), -- brand, segment 컬럼 기준으로 합계를 구한다.
	(brand), -- brand 컬럼 기준으로 합계를 구한다.
	(segment), -- segment 컬럼 기준으로 합계를 구한다.
	() -- 테이블 전체를 기준으로 합계를 구한다.
	)

-------------------------------------------

-- grouping 함수를 사용해서 추가적인 정보를 나타낼 수 있다. 이때 해당 컬럼이 집계에 사용되었으면 0, 그렇지 않으면 1을 리턴 한다.

select
	grouping(brand) grouping_brand,
	grouping(segment) grouping_segment,
	brand,
	segment,
	sum (quantity)
from
	sales
group by
	grouping sets (
	(brand,segment),
	(brand),
	(segment),
	()
	)

-------------------------------------------

select
	case
		when grouping(brand) = 0
		and grouping(segment) = 0 then '브랜드별+등급별'
		when grouping(brand) = 0
		and grouping(segment) = 1 then '브랜드별'
		when grouping(brand) = 1
		and grouping(segment) = 0 then '등급별'
		when grouping(brand) = 1
		and grouping(segment) = 1 then '전체합계'
		else ''
	end as "집계기준", -- 작은 따옴표 사용하면 오류 발생.
	brand,
	segment,
	sum(quantity)
from
	sales
group by
	grouping sets (
	(brand,segment),
	(brand),
	(segment),
	()
	)
order by brand, segment