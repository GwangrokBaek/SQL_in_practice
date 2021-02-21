문제1번) dvd 대여를 제일 많이한 고객 이름은?   (with 문 활용)	

with cus as (
select
	r.customer_id , count(r.rental_id) as cnt
from
	rental r
group by
	r.customer_id
order by
	cnt desc
limit 1 )
select
	c.first_name ,
	c.last_name ,
	cus.cnt
from
	cus
inner join customer c on
	cus.customer_id = c.customer_id

문제2번) 영화 시간 유형 (length_type)에 대한 영화 수를 구하세요.
영화 상영 시간 유형의 정의는 다음과 같습니다.
영화 길이 (length) 은 60분 이하 short , 61분 이상 120분 이하 middle , 121 분이상 long 으로 한다.

with db as (
select
	case
		when f.length >= 121 then 'long'
		when f.length between 61 and 120 then 'middle'
		else 'short'
	end as time_table
from
	film f )
select
	db.time_table,
	count(db.time_table) as cnt
from
	db
group by
	db.time_table

-----------------------------------------

with db as (
	select 0 as chk1 , 60 as chk2, 'short' as length_flag union all -- with 문 사용 사례는 대부분 똑같다. 이런 식으로 새로운 테이블을 생성해주면 된다.
	select 61 as chk1 , 120 as chk2, 'middle' as length_flag union all
	select 121 as chk1 , 999 as chk2, 'long' as length_flag
)
select
	length_flag,
	count(distinct film_id) as cnt
from
	(
	select
		f.film_id,
		f.length,
		db.length_flag
	from
		film f
	left outer join db on
		f.length between db.chk1 and db.chk2 ) as db
group by
	length_flag

문제3번) 약어로 표현되어 있는 영화등급(rating) 을 영문명, 한글명과 같이 표현해 주세요. (with 문 활용)

G        ? General Audiences (모든 연령대 시청가능)
PG      ? Parental Guidance Suggested. (모든 연령대 시청가능하나, 부모의 지도가 필요)
PG-13 ? Parents Strongly Cautioned (13세 미만의 아동에게 부적절 할 수 있으며, 부모의 주의를 요함)
R         ? Restricted. (17세 또는 그이상의 성인)
NC-17 ? No One 17 and Under Admitted.  (17세 이하 시청 불가)	

with db as (
	select 'G' as chk1, 'General Audiences' as chk2, '(모든 연령대 시청가능)' as chk3 union all
	select 'PG' as chk1, 'Parental Guidance Suggested.' as chk2, '(모든 연령대 시청가능하나, 부모의 지도가 필요)' as chk3 union all
	select 'PG-13' as chk1, 'Parents Strongly Cautioned' as chk2, '(13세 미만의 아동에게 부적절 할 수 있으며, 부모의 주의를 요함)' as chk3 union all
	select 'R' as chk1, 'Restricted.' as chk2, '(17세 또는 그이상의 성인)' as chk3 union all
	select 'NC-17' as chk1, 'No One 17 and Under Admitted.' as chk2, '(17세 이하 시청 불가)' as chk3
)
select f.film_id , f.rating , db.chk2, db.chk3
from film f
left outer join db on cast(f.rating as varchar) = db.chk1 -- f.rating 이 문자열 데이터가 아닌 특수한 형태의 데이터라서 cast 함수를 통해 문자형으로 바꿔줘야 한다.

문제4번) 고객 등급별 고객 수를 구하세요. (대여 횟수에 따라 고객 등급을 나누고 조건은 아래와 같습니다.)

A 등급은 31회 이상
B 등급은 21회 이상 30회 이하 
C 등급은 11회 이상 20회 이하
D 등급은 10회 이하

with db as (
	select 0 as chk1, 10 as chk2, 'D' as rating union all
	select 11 as chk1, 20 as chk2, 'C' as rating union all
	select 21 as chk1, 30 as chk2, 'B' as rating union all
	select 31 as chk1, 999 as chk2, 'A' as rating
)
select
	db.rating,
	count(*)
from
	(
	select
		c.customer_id ,
		count(r.rental_id) as rental_cnt
	from
		customer c
	left outer join rental r on
		c.customer_id = r.customer_id
	group by
		c.customer_id ) d
inner join db on
	d.rental_cnt between db.chk1 and db.chk2
group by
	db.rating
order by
	db.rating

문제5번) 고객 이름 별로 , flag  를 붙여서 보여주세요.
- 고객의 first_name 이름의 첫번째 글자가, A, B,C 에 해당 하는 사람은  각 A,B,C 로 flag 를 붙여주시고 
   A,B,C 에 해당하지 않는 인원에 대해서는 Others 라는 flag 로  붙여주세요.	

with db as (
	select 'A' as chk1, 'A' as flag union all
	select 'B' as chk1, 'B' as flag union all
	select 'C' as chk1, 'C' as flag
)
select
	c.first_name ,
	coalesce (db.flag, 'Others')
from
	customer c
left outer join db on
	substring(c.first_name, 1, 1) = db.chk1
   
문제6번) payment 테이블을 기준으로,  2007년 1월~ 3월 까지의 결제일에 해당하며,  staff2번 인원에게 결제를 진행한  결제건에 대해서는, Y 로   
그 외에 대해서는 N 으로 표기해주세요. with 절을 이용해주세요.	

with db as (
	select 1 as chk1, 'N' as chk2 union all
	select 2 as chk1, 'Y' as chk2
)
select
	*
from
	payment p
inner join db on
	p.staff_id = db.chk1
where
	to_char(p.payment_date, 'YYYY-MM') between '2007-01' and '2007-03'
order by
	p.payment_date

문제7번) Payement 테이블을 기준으로,  결제에 대한 Quarter 분기를 함께 표기해주세요.
with 절을 활용해서 풀이해주세요.
1~3월의 경우 Q1
4~6월 의 경우 Q2
7~9월의 경우 Q3
10~12월의 경우 Q4

with db as (
	select 1 as chk1, 3 as chk2, 'Q1' as chk3 union all
	select 4 as chk1, 6 as chk2, 'Q2' as chk3 union all
	select 7 as chk1, 9 as chk2, 'Q3' as chk3 union all
	select 10 as chk1, 12 as chk2, 'Q4' as chk3
)
select
	*
from
	payment p
inner join db on
	extract(month from p.payment_date) between db.chk1 and db.chk2

문제8번) Rental 테이블을 기준으로,  회수일자에 대한 Quater 분기를 함께 표기해주세요. 
with 절을 활용해서 풀이해주세요.
1~월의 경우 Q1
4~6월 의 경우 Q2
7~9월의 경우 Q3
10~12월의 경우 Q4 로 함께 보여주세요.

with db as (
	select 1 as chk1, 3 as chk2, 'Q1' as chk3 union all
	select 4 as chk1, 6 as chk2, 'Q2' as chk3 union all
	select 7 as chk1, 9 as chk2, 'Q3' as chk3 union all
	select 10 as chk1, 12 as chk2, 'Q4' as chk3
)
select
	*
from
	rental r
left outer join db on
	extract(month from r.return_date) between db.chk1 and db.chk2

문제9번) 직원이이  월별  대여를 진행 한  대여 갯수가 어떻게 되는 지 알려주세요. 
대여 수량이   아래에 해당 하는 경우에 대해서, 각 flag 를 알려주세요 .

0~ 500개 의 경우  under_500 
501~ 3000 개의 경우  under_3000
3001 ~ 99999 개의 경우  over_3001  

with db as (
	select 0 as chk1, 500 as chk2, 'under_500' as chk3 union all
	select 501 as chk1, 3000 as chk2, 'under_3000' as chk3 union all
	select 3001 as chk1, 99999 as chk2, 'over_3001' as chk3
)
select
	d.mon,
	d.staff_id,
	d.cnt,
	db.chk3
from
	(
	select
		to_char(r.rental_date, 'YYYY-MM') as mon,
		r.staff_id,
		count(r.rental_id) as cnt
	from
		rental r
	group by
		to_char(r.rental_date, 'YYYY-MM') ,
		r.staff_id
	order by
		mon,
		r.staff_id ) d
inner join db on
	d.cnt between db.chk1 and db.chk2

문제10번) 직원의 현재 패스워드에 대해서, 새로이  패스워드를 지정하려고 합니다.
직원1의 새로운 패스워드는 12345  ,  직원2의 새로운 패스워드는 54321입니다.
해당의 경우, 직원별로 과거 패스워드와 현재 새로이 업데이트할 패스워드를 
함께 보여주세요.
with 절을 활용하여  새로운 패스워드 정보를 저장 후 , 알려주세요.	

with db as (
	select 1 as staff_id, '12345' as password union all
	select 2 as staff_id, '54321' as password
)
select
	s.staff_id ,
	s."password" as old_password,
	db.password as new_password
from
	staff s
inner join db on
	s.staff_id = db.staff_id
