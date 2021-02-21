-- 조인과 집계 데이터 - 13. 분석함수란
-- 분석함수는 특정 집합 내에서 결과 건수의 변화 없이 해당 집합안에서 합계 및 카운트 등을 계산할 수 있는 함수이다.

create table product_group (
group_id serial primary key,
group_name varchar (255) not null
)

create table product (
product_id serial primary key,
product_name varchar (255) not null,
price decimal (11, 2),
group_id int not null,
foreign key (group_id),
references product_group (group_id)
)

insert into product_group (group_name)
values
('Smartphone'),
('Laptop'),
('Tablet')

insert into product (product_name, group_id, price)
values
('Microsoft Lumia', 1, 200),
('HTC One', 1, 400),
('Nexus', 1, 500),
('iPhone', 1, 900),
('HP Elite', 2, 1200),
('Lenovo Thinkpad', 2, 700),
('Sony VAIO', 2, 700),
('Dell Vostro', 2, 800),
('iPad', 3, 700),
('Kindle Fire', 3, 150),
('Samsung Galaxy Tab', 3, 200)

-- count() 와 같이 집계 함수는 집계의 결과만을 출력한다. 따라서 데이터는 볼 수가 없다.

select
	count(*)
from
	product p

-- over () 가 붙은 분석 함수는 집계의 결과 및 집합을 함께 출력한다.

select
	count(*) over(),
	a.*
from
	product a

