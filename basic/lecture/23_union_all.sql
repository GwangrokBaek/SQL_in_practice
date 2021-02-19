-- 집합 연산자와 서브커리 - 02. UnionAll 연산
-- 두 개 이상의 select 문들의 결과 집합을 단일 결과 집합으로 결합하며 결합시 중복된 데이터도 모두 출력 한다.

select
	*
from
	sales2007_1 s
union all
select
	*
from
	sales2007_2 s2

-------------------------

select
	name
from
	sales2007_1 s
union all
select
	name
from
	sales2007_2 s2

-------------------------

select
	amount
from
	sales2007_1 s
union all
select
	amount
from
	sales2007_2 s2

-- 보통 union 연산 보다는 union all 연산을 더 많이 사용한다. 왜냐하면 union의 경우에는 중복을 자동으로 제거해주기때문에
-- union all 연산을 통해 직접 데이터를 핸들링 하고 싶은 경우가 있어서 union all 연산을 더 많이 사용.
--------------------------

select
	*
from
	sales2007_1 s
union all
select
	*
from
	sales2007_2 s2
order by
	amount desc -- order by 는 맨 마지막 select 문에 작성해야 한다. 중간에 작성하면 오류 발생.