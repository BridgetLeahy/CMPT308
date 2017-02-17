--Bridget Leahy
--2/14/17
--Lab 5

--1.
select a.city 
from agents a inner join orders o on a.aid = o.aid
where o.cid = 'c006'  
order by a.city ASC;


--2. 	
select distinct o.pid
from orders o inner join customers c on o.cid = c.cid
              inner join agents a on o.aid = a.aid
where c.city = 'Kyoto'
	and c.cid = o.cid
    and o.aid = a.aid
order by o.pid DESC ;
                           
                 
--3 	                 
select name
from customers 
where cid not in (select distinct cid 
                  from orders);

---4.
select distinct  c.name 
from orders o right outer join customers c on o.cid = c.cid
where o.ordNumber is null;


--5 	
select distinct c.name, a.name
from orders o inner join customers c on o.cid = c.cid
		  	inner join agents a on o.aid = a.aid
where c.city = a.city;

                                                                                                                                                      
--  6.                
select c.city, a.name as "agent name", c.name as "customer name"
from customers c, agents a
where c.city = a.city
group by c.city, a.name, c.name
order by c.city ASC;


--7. 
 select name, city
 from customers
 where city = (select city
              from products
              group by city
              order by count(pid) ASC
              limit 1)
 order by name ASC;