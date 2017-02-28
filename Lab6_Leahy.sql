--Bridget Leahy
--2/23/17
--Lab 6

--1. Display	the	name	and	city	of	customers	who	live	in	any	city	that	makes	the	most different	kinds	of	products.	
--(There	are	two	cities	that	make	the	most	different products.	Return	the	name	and	city	of	customers	from	either	one	of	those.)	

select c.name, c.city
from customers c
where c.city in 
    (select p.city
    from products p
    group by p.city
    order by count(p.city) DESC
    limit 2)
order by c.name ASC;

--2. Display	the	names	of	products	whose	priceUSD	is	strictly	above	the	average	priceUSD, in	reverse-alphabetical	order.
select p.name
from products p
where p.priceUSD > 
    (select avg(priceUSD)
    from products)
order by p.name DESC;

--3. Display	the	customer	name,	pid	ordered,	and	the	total	for	all	orders,	sorted	by	total from	low	to	high.
select c.name, o.pid, o.totalUSD
from orders o inner join customers c on o.cid = c.cid
order by totalUSD ASC;

--4. Display	all	customer	names	(in	alphabetical	order)	and	their	total	ordered,	and	nothing	more.	Use	coalesce	to	avoid	showing	NULLs.	

select c.name, coalesce(sum(o.totalUSD), 0)
from orders o inner join customers c on o.cid = c.cid
group by c.name
order by c.name ASC;


--5 Display	the	names	of	all	customers	who	bought	products	from	agents	based	in	Newark	along	with	the	names	of	the	products	they	ordered,	and	the	names	of	the	agents	who	sold	it	to	them.	
select c.name, p.name, a.name
from orders o inner join customers c on o.cid = c.cid
			inner join products p on o.pid = p.pid
            inner join agents a on o.aid = a.aid
where a.city = 'Newark';

--6.Write	a	query	to	check	the	accuracy	of	the	totalUSD	column	in	the	Orders	table.	
--This means	calculating	Orders.totalUSD	from	data	in	other	tables	and	comparing	those values	to	the	values	in	Orders.totalUSD.	
--Display	all	rows	in	Orders	where Orders.totalUSD	is	incorrect,	if	any.	

select o.ordNumber, o.month, o.cid, o.aid, o.pid, o.qty, o.totalUSD as inaccurateTotal, o.qty * p.priceUSD - (o.qty * p.priceUSD * c.discount * 0.01) as accurateTotal
from orders o inner join customers c on o.cid = c.cid
			inner join products p on o.pid = p.pid
where o.qty * p.priceUSD - (o.qty * p.priceUSD * c.discount * 0.01) != o.totalUSD;

