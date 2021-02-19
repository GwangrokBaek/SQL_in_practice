-- 집합 연산자와 서브커리 - 04. Except 연산
-- Except 연산자는 맨위에 Select 문의 결과 집합에서 그 아래에 있는 Select 문의 결과 집합을 제외한 결과를 리턴한다.

-- 즉, A와 B집합이 있는 경우, Except 연산자는 A 집합에서 B 집합을 뺀 나머지, 즉, A와 B의 차집합을 리턴한다.
-- Except 연산자는 실무에서 정말 많이 사용된다.
-- 예를 들어, 이행 작업 시, 데이터가 동일하게 옮겨졌는지를 확인할 때, 옮기기전의 데이터와 옮긴 후의 데이터의 차집합을 계산할때
-- Except 연산을 주로 사용한다. 이때 뺀 결과가 공집합이라면, 변조 없이 데이터가 잘 옮겨졌다는 것을 의미.

select
	distinct i.film_id , -- 필름과 인벤토리가 1:m 관계이므로 두 테이블을 조인하면, 영화하나당 여러개의 재고가 나옴. 따라서 그것을 방지하기 위해 인벤토리의 film_id에 distinct 사용.
	title
from
	inventory i
inner join film f on
	f.film_id = i.film_id
order by
	title

-- 재고가 존재하는 영화의 필름 ID와 영화 제목을 추출.
-- 이때 재고가 존재하지 않는 영화는 어떻게 추출하는가?
------------------------------------
-- 모든 film 데이터에서 재고가 있는 영화를 빼주면 재고가 존재하지 않는 영화 추출 가능. 이때 except 연산자를 사용.
select
	film_id,
	title
from
	film
except
select
	distinct i.film_id,
	title
from
	inventory i
inner join film f on
	f.film_id = i.film_id
order by
	title