--Bridget Leahy
--Lab three
--1/31/17

--1)
select ordNumber, totalUSD 
from Orders
order by ordNumber ASC;

--2)
select name, city
from Agents
where name = 'Smith';

--3)
select pid, name, priceUSD
from products
where quantity > 200100;

--4)
select name, city
from customers 
where city = 'Duluth';

--5)
select name
from agents
where city not in ('New York', 'Duluth');

--6)
select * 
from products
where priceUSD >= 1 
and city not in ('Dallas', 'Duluth');

--7)
select *
from orders
where month in ('Feb', 'May');

--8)
select *
from orders 
where month = 'Feb' and totalUSD >= 600;

--9)
select * 
from orders
where cid = 'C005';