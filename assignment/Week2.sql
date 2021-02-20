문제1번)  주문일이 2017-09-02 일에 해당 하는 주문건에 대해서,  어떤 고객이, 어떠한 상품에 대해서 얼마를 지불하여  상품을 구매했는지 확인해주세요.

select
	o.orderdate ,
	o.customerid ,
	od.productnumber ,
	od.quantityordered * od.quotedprice as prices
from
	orders o
inner join order_details od on
	o.ordernumber = od.ordernumber
where
	date(o.orderdate) = '2017-09-02'
order by
	o.orderdate ,
	o.customerid

문제2번)  헬멧을 주문한 적 없는 고객을 보여주세요. 헬맷은, Products 테이블의 productname 컬럼을 이용해서 확인해주세요.

select
	c.customerid,
	order_hm.*
from
	customers c
left outer join (
	select
		o.ordernumber ,
		o.customerid ,
		od.productnumber ,
		p.productname
	from
		orders o
	inner join order_details od on
		od.ordernumber = o.ordernumber
	inner join products p on
		p.productnumber = od.productnumber
	where
		p.productname like '%Helmet' ) order_hm on
	c.customerid = order_hm.customerid
where
	order_hm.customerid is null

문제3번)  모든 제품 과 주문 일자를 나열하세요. (주문되지 않은 제품도 포함해서 보여주세요.)

select
	p.productnumber ,
	p.productname ,
	o.ordernumber,
	o.orderdate
from
	products p
left outer join order_details od on
	od.productnumber = p.productnumber
left outer join orders o on
	o.ordernumber = od.ordernumber
order by
	p.productnumber

문제4번)  캘리포니아 주와 캘리포니아 주가 아닌 STATS 로 구분하여 각 주문량을 알려주세요. (CASE문 사용)

select
	case
		c.custstate when 'CA' then 'CA'
		else 'Others'
	end as "STATS",
	count(c.custstate)
from
	customers c
inner join orders o on
	o.customerid = c.customerid
group by
	case
		c.custstate when 'CA' then 'CA'
		else 'Others'
	end

----------------------------------------

select
	db.ca_yn,
	count(distinct ordernumber) as cnt
from
	(
	select
		c.customerid ,
		c.custstate ,
		case
			when c.custstate = 'CA' then 'CA_Y'
			else 'CA_N'
		end as CA_YN,
		o.ordernumber
	from
		customers c
	join orders o on
		o.customerid = c.customerid
	left outer join order_details od on
		o.ordernumber = od.ordernumber ) as db
group by
	db.ca_yn

문제5번) 공급 업체 와 판매 제품 수를 나열하세요. 단 판매 제품수가 2개 이상인 곳만 보여주세요.

select
	v.vendname,
	count(distinct pv.productnumber)
from
	product_vendors pv
inner join vendors v on
	pv.vendorid = v.vendorid
group by
	v.vendname
having
	count(distinct pv.productnumber) >= 2

문제6번) 가장 높은 주문 금액을 산 고객은 누구인가요? 
 - 주문일자별,  고객의 아이디별로, 주문번호,  주문 금액도 함께 알려주세요.

select
	o.orderdate ,
	o.customerid ,
	o.ordernumber ,
	d.amount
from
	(
	select
		od.ordernumber,
		sum(od.quotedprice * od.quantityordered) as amount
	from
		order_details od inner join orders o on o.ordernumber = od.ordernumber 
	group by
		od.ordernumber 
	order by
		amount desc
	limit 1
	) d
inner join orders o on
	o.ordernumber = d.ordernumber

--------------------------------------------------------

select
	orderdate,
	customerid ,
	ordernumber ,
	sum(prices) as order_price
from
	(
	select
		o.orderdate ,
		o.customerid ,
		o.ordernumber ,
		od.productnumber ,
		od.quantityordered * od.quotedprice as prices
	from
		orders o
	inner join order_details od on
		o.ordernumber = od.ordernumber ) as db
group by
	orderdate,
	customerid,
	ordernumber
order by
	order_price desc
limit 1

문제7번) 주문일자별로, 주문 갯수와,  고객수를 알려주세요 
 ex) 하루에 한 고객이 주문을 2번이상했다고 가정했을때 -> 해당의 경우는 고객수는 1명으로 계산해야합니다.

select
	orderdate,
	count(ordernumber),
	count(distinct customerid)
from
	orders
group by
	orderdate
order by
	orderdate

문제8번) 타이어과 헬멧을 모두 산적이 있는 고객의 ID 를 알려주세요.
- 타이어와 헬멧에 대해서는 , Products 테이블의 productname 컬럼을 이용해서 확인해주세요.

select
	o.customerid
from
	orders o
inner join order_details od on
	od.ordernumber = o.ordernumber
inner join products p on
	p.productnumber = od.productnumber
where
	p.productname like '%Helmet'
intersect
select
	o.customerid
from
	orders o
inner join order_details od on
	od.ordernumber = o.ordernumber
inner join products p on
	p.productnumber = od.productnumber
where
	p.productname like '%Tires'

문제9번) 타이어는 샀지만,  헬멧을 사지 않은 고객의 ID 를 알려주세요.   Except 조건을 사용하여, 풀이 해주세요.
- 타이어, 헬멧에 대해서는, Products 테이블의 productname 컬럼을 이용해서 확인해주세요.

select
	o.customerid
from
	orders o
inner join order_details od on
	od.ordernumber = o.ordernumber
inner join products p on
	p.productnumber = od.productnumber
where
	p.productname like '%Tires'
except
select
	o.customerid
from
	orders o
inner join order_details od on
	od.ordernumber = o.ordernumber
inner join products p on
	p.productnumber = od.productnumber
where
	p.productname like '%Helmet'





