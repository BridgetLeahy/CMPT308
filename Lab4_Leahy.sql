--Bridget Leahy
--Lab 4
--2/8/17

--1.
select city
from agents
where aid in (
		select aid
		from orders
		where cid = 'c006')
order by city ASC;


--2. 
select distinct pid
from orders
where aid in (
    select aid 
    from orders
    where cid in (
        select cid
        from customers
        where city = 'Kyoto')
	)
order by pid DESC;


--3.
select cid, name
from customers
where cid not in (
	select distinct cid
	from orders
	where aid = 'a01')
order by cid ASC;

--4.
select cid
from orders 
    where pid = 'p07' and cid in (
    select cid
    from orders
    where pid = 'p01' )
order by cid ASC;


--5.
select distinct pid
from orders
where cid not in (
	select cid
	from orders
	where aid = 'a08' )
order by pid DESC;


--6. 
select name, discount, city
from customers
where cid in (
    select distinct cid
    from orders
    where aid in (
        select aid
        from agents
        where city in ('Tokyo', 'New York'))
    )
order by name ASC;


---7. 
select cid, name
from customers
where discount in (
    select discount
    from customers
    where city in ('Duluth', 'London')
     ) 
order by cid ASC;