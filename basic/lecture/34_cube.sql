-- 조인과 집계 데이터 - 12. Cube 절
-- 지정된 Grouping 컬럼의 다차원 소계를 생성하는데 사용된다. 간단한 문법으로 다차원 소계를 출력할 수 있다.

-- cube 절과 아래 grouping sets 절은 똑같은 결과를 출력한다.
-- 이때 cube 절은 인자의 개수를 N으로 하여 2의 N승만큼의 소계를 출력한다.

cube(c1, c2, c3)

grouping sets(
(c1, c2, c3),
(c1, c2),
(c1, c3),
(c2, c3),
(c1),
(c2),
(c3),
()
)

select
	brand,
	segment,
	sum(quantity)
from
	sales
group by
	cube(brand, segment) -- group by 절 합계 + brand 별 합계 + segment 별 합계 + 전체합계를 출력한다.
order by
	brand,
	segment

----------------------------------------

select
	brand,
	segment,
	sum(quantity)
from
	sales
group by
	brand,
	cube(segment) -- 부분 cube 는 group by별 합계 + 맨앞에 쓴 컬럼별 (group by 에 적힌 컬럼) 합계를 출력하고, group by에 적힌 컬럼과 cube에 적힌 컬럼을 묶어 합계를 출력.
				  -- 이때 뒤에 cube절 안에 적힌 컬럼별 합계와 전체 합계는 출력하지 않는다.
order by
	brand,
	segment