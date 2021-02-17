-- 조인과 집계 데이터 - 01. 조인이란

create table basket_a ( id int primary key,
fruit varchar (100) not null );

create table basket_b ( id int primary key,
fruit varchar (100) not null );

insert
	into
	basket_a (id,
	fruit)
values (1,
'Apple'),
(2,
'Orange'),
(3,
'Banana'),
(4,
'Cucumber') ;

insert
	into
	basket_b (id,
	fruit)
values (1,
'Orange'),
(2,
'Apple'),
(3,
'Watermelon'),
(4,
'Pear') ;