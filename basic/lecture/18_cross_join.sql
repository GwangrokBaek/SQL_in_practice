-- 조인과 집계 데이터 - 06. CROSS 조인 

-- 두 개의 테이블의 catesian product 연산의 결과를 출력. 데이터 복제에 많이 쓰이는 기법.

create table cross_t1
(
label char(1) primary key
)

create table cross_t2
(
score int primary key
)

insert into cross_t1 (label)
values
('A'),
('B')

insert into cross_t2 (score)
values
(1),
(2),
(3)

select * from cross_t1 ct ;
select * from cross_t2 ct2 ;

--------------------------------
-- 가능한 모든 경우의 수를 출력. 이때 모든 경우의 수를 출력하므로 on 키워드를 따로 사용하지 않는다.

select
	*
from
	cross_t1 ct
cross join cross_t2 ct2

--------------------------------

select *
from cross_t1 ct , cross_t2 ct2 

-- inner join을 표현하는 또 다른 방법인데 이때 on 키워드를 사용하지 않았으므로 cross join처럼 모든 경우의 수에 대해 출력.
-- 이때 sql 문 자체는 다르더라도 연산에 다른 정보가 같다면 이들을 동일한 sql 문이라고 한다.
