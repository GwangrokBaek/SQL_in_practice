-- 조인과 집계 데이터 - 11. Roll up 절
-- 지정된 Grouping 컬럼의 소계를 생성하는데 사용된다. 간단한 문법으로 다양한 소계를 출력할 수 있다.
-- roll up 절은 group by와 함께 사용된다.

select
	brand,
	segment,
	sum(quantity)
from
	sales
group by
	rollup (brand, segment) -- roll up 절은 명시해준 컬럼을 기준으로 먼저 합계를 출력해주고, roll up 절에 명시된 컬럼 중 맨 앞의 컬럼을 기준으로 합계를 출력해 준 다음, 전체 합계를 출력해준다.
							-- 즉, brand, segment를 기준으로 합계를 출력해주고, brand를 기준으로 합계를 출력해준 다음, 전체 합계를 출력해준다.
							-- group by 별 합계 + roll up 절의 맨 앞에 쓴 컬럼의 합계 + 전체 합계 출력.
order by
	brand,
	segment

-- roll up은 간단하지만 매우 강력한 소계 기능을 지원해주므로 매우 많이 사용된다.

select
	segment,
	brand,
	sum(quantity)
from
	sales
group by
	segment,
	rollup(brand) -- 부분 roll up은 group by에 명시된 segment와 roll up에 명시된 brand를 기준으로 합계를 출력해주고, group by에 명시된 segment를 기준으로 합계를 출력해주지만, 전체 합계는 출력하지 않는다.
				  -- 이때 부분 roll up group by 별 합계 + roll up 절의 맨 앞에 쓴 컬럼과 group by에 명시된 컬럼별 합계를 출력해준다.
order by
	segment,
	brand

-- 부분 roll up은 전체 합계를 출력하지 않는다는 것이 핵심.
