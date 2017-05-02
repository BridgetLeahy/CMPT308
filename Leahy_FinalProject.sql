-- Bridget Leahy
-- Dunkin Donuts DB
--KNOWN PROBLEM:
--Issue when I combined my separate SQL scripts for creating tables, inserting data, and creating viws/storedprocedures/triggers etc
--When the whole script is run at once the tables aren't properly created
--Must be run in sections

-- DROP TABLE STATEMENTS --


DROP TABLE IF EXISTS BannedCustomers;
DROP TABLE IF EXISTS Managers;
DROP TABLE IF EXISTS Crew;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Food;
DROP TABLE IF EXISTS Drinks;
DROP TABLE IF EXISTS StoreOfferings;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Stores;
DROP TABLE IF EXISTS ZipCode;

--CREATE TABLE STATEMENTS
--Zipcode
CREATE TABLE ZipCode (
ZipCode int not null,
City text,
State text,
Country text,
primary key(ZipCode)
);

--People
CREATE TABLE People (
PID char(4) not null,
FirstName text,
LastName text,
DOB date,
StreetAddress text,
ZipCode int not null references ZipCode(ZipCode),
primary key(PID)
);

--Stores
CREATE TABLE Stores (
SID char(4) not null,
StreetAddress text, 
Zipcode int not null references Zipcode(Zipcode),
primary key(SID)
);


--BannedCustomers
CREATE TABLE BannedCustomers (
PID char(4) not null references People(PID),
DateofBan date,
Reason text,
primary key (PID)
); 

--Customers
CREATE TABLE Customers (
PID char(4) not null references People(PID), 
PerksMember text DEFAULT 'No',
primary key(PID),
CONSTRAINT CHK_Member CHECK (PerksMember='Yes' OR PerksMember='No')
);

--Staff
CREATE TABLE Staff (
PID char(4) not null references People(PID),
SID char(4)  not null references Stores(SID),
primary key(PID)
);

--Managers
CREATE TABLE Managers (
PID char(4) not null references Staff(PID),
SID char(4)  not null references Stores(SID),
HireDate date,
PromotionDate date,
HourlyWageUSD numeric(10,2) default 20.00,
primary key(PID),
check (PromotionDate > HireDate)
);

--Staff
CREATE TABLE Crew (
PID char(4) not null references Staff(PID),
SID char(4)  not null references Stores(SID),
HireDate date,
HourlyWageUSD numeric(10,2) default 10.00,
primary key(PID)
);

--Items
CREATE TABLE Items (
IID char(4) not null, 
Type text,
primary key(IID),
CONSTRAINT CHK_Type CHECK (Type='food' OR Type='drink')
);

--Store Offerings
CREATE TABLE StoreOfferings (
SID char(4)  not null references Stores(SID),
IID char(4)  not null references Items(IID),
primary key(SID, IID)
);

--Drinks
CREATE TABLE Drinks (
IID char(4) not null references items(IID), 
Description text,
Calories integer,
PriceUSD numeric(10,2)
);

--Food
CREATE TABLE Food(
IID char(4) not null references items(IID), 
Description text,
Calories integer,
PriceUSD numeric(10,2)
);

--Orders
CREATE TABLE Orders (
OID char(4) not null,
PID char(4) not null references Customers(PID),
SID char(4),
IID char(4), 
DateOrdered date,
totalUSD numeric(10,2),
foreign key(SID, IID) references StoreOfferings(SID, IID),
primary key(OID)
); 


--INSERT STATEMENTS
--insert Zipcodes--
insert into Zipcode(Zipcode, State, City, Country) values (06475, 'CT', 'Old Saybrook', 'USA');
insert into Zipcode(Zipcode, State, City, Country) values (07446, 'NJ', 'Ramsey', 'USA');
insert into Zipcode(Zipcode, State, City, Country) values (12601, 'NY', 'Poughkeepsie', 'USA');
insert into Zipcode(Zipcode, State, City, Country) values (12538, 'NY', 'Hyde Park', 'USA');
insert into Zipcode(Zipcode, State, City, Country) values (01524, 'MA', 'Leicester', 'USA');


--insert people --
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p001', 'Tien', 'Liengtiraphan', '1996-05-26', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p002', 'Alan', 'Labouseur', '2017-04-01', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p003', 'Mary', 'Morrison', '1996-01-21', '11 Fox Hollow Road', 06475);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p004', 'Rachel', 'Wheaton', '1996-04-30', '52 Sun Valley Road', 07446);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p005', 'Bridget', 'Leahy', '1995-09-08', '5 Pryor Road', 01524);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p006', 'John', 'Doe', '1990-05-06', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p007', 'Jane', 'Deer', '1989-09-22', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p008', 'Data', 'Base', '1970-01-01', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p009', 'Ronald', 'McDonald', '1960-11-04', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p010', 'Star', 'Buck', '1971-03-31', '3434 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p011', 'Jeff', 'Kortina', '1989-12-13','34 Main Street', 07446);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p012', 'Spoon', 'Wotherspoon', '1993-04-01', '83 Bee Way', 07446);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p013',  'Alex', 'Carlin', '1990-06-05', '4 Pleasant Street', 07446);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p014',  'Hannah', 'Youseff', '1990-06-05', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p015',  'Emma', 'Leahey', '1996-08-08', '3 Britney Drive', 01524);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p016',  'Michael', 'Leahy', '1993-11-07', '5 Pryor Road', 01524);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p017',  'Anna', 'Young', '1998-02-26', '3399 North Road', 12601);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p018',  'Erin', 'Concannon', '1996-02-14', '13 Irish Lane', 07446);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p019',  'Michael', 'Leahy', '1993-11-07', '5 Orange Road', 07446);
insert into people(PID, FirstName, LastName, DOB, StreetAddress, Zipcode) values ('p020',  'Anna', 'Young', '1998-02-26', '98 Sun Road', 06475);


--stores--
insert into stores(SID, StreetAddress, Zipcode) values ('s001', '101 Main Street', 01524);
insert into stores(SID, StreetAddress, Zipcode) values ('s002', '3979 Albany Post Road', 12538);
insert into stores(SID, StreetAddress, Zipcode) values ('s003', '1 Dunkin Way', 12601);
insert into stores(SID, StreetAddress, Zipcode) values ('s004', '22 Sunset Road', 06475);
insert into stores(SID, StreetAddress, Zipcode) values ('s005', '92 Flower Lane', 07446);

--insert banned customers --
insert into bannedcustomers(PID, dateofban, reason) values ('p002', '2017-04-21', 'Fan of Starbucks');
insert into bannedcustomers(PID, dateofban, reason) values ('p010', '1971-05-01', 'Brought Starbucks into Dunkin');

--insert customers--
insert into customers(PID) values ('p009');
insert into customers(PID, Perksmember) values ('p004', 'Yes');
insert into customers(PID, Perksmember) values ('p006', 'Yes');
insert into customers(PID, Perksmember) values ('p018', 'No');
insert into customers(PID, Perksmember) values ('p019', 'Yes');
insert into customers(PID, Perksmember) values ('p020', 'Yes');

--insert staff --
insert into staff(PID, SID) values ('p001', 's003');
insert into staff(PID, SID) values ('p003', 's004');
insert into staff(PID, SID) values ('p005', 's001'); 
insert into staff(PID, SID) values ('p007', 's005');
insert into staff(PID, SID) values ('p011', 's005');
insert into staff(PID, SID) values ('p012', 's002'); 
insert into staff(PID, SID) values ('p013', 's001');
insert into staff(PID, SID) values ('p014', 's003');
insert into staff(PID, SID) values ('p015', 's001'); 
insert into staff(PID, SID) values ('p016', 's005');
insert into staff(PID, SID) values ('p017', 's004');

--insert managers--
insert into managers(pid, sid, hiredate, promotiondate) values ('p001', 's003', '2016-02-03', '2017-02-03');
insert into managers(pid, sid, hiredate, promotiondate, hourlywageUSD) values ('p007', 's002', '2015-10-15', '2016-12-31', 25);
insert into managers(pid, sid, hiredate, promotiondate, hourlywageUSD) values ('p015', 's001', '2013-04-19', '2014-06-13', 27);
insert into managers(pid, sid, hiredate, promotiondate, hourlywageUSD) values ('p016', 's005', '2012-09-01', '2014-12-01', 25);
insert into managers(pid, sid, hiredate, promotiondate, hourlywageUSD) values ('p017', 's004', '2015-03-15', '2017-02-01', 30);


--insert crew--
insert into crew(pid, sid, hiredate, hourlywageUSD) values ('p005', 's001', '2010-06-18', 10);
insert into crew(pid, sid, hiredate, hourlywageUSD) values ('p003', 's004', '2010-06-18', 10);
insert into crew(pid, sid, hiredate, hourlywageUSD) values ('p011', 's005', '2010-06-18', 10);
insert into crew(pid, sid, hiredate, hourlywageUSD) values ('p012', 's002', '2010-06-18', 10);
insert into crew(pid, sid, hiredate, hourlywageUSD) values ('p013', 's001', '2010-06-18', 10);
insert into crew(pid, sid, hiredate, hourlywageUSD) values ('p014', 's003', '2016-12-22', 11);


--items--
insert into items(IID, Type) values ('i001', 'food');
insert into items(IID, Type) values ('i002', 'drink');
insert into items(IID, Type) values ('i003', 'food');
insert into items(IID, Type) values ('i004', 'food');
insert into items(IID, Type) values ('i005', 'food');
insert into items(IID, Type) values ('i006', 'drink');
insert into items(IID, Type) values ('i007', 'drink');
insert into items(IID, Type) values ('i008', 'drink');
insert into items(IID, Type) values ('i009', 'food');
insert into items(IID, Type) values ('i010', 'drink');
insert into items(IID, Type) values ('i011', 'food');

--food--
insert into food(IID, description, calories, priceUSD) values ('i001', 'Plain Bagel', 310, 2.50); 
insert into food(IID, description, calories, priceUSD) values ('i003', 'Chocolate Coconut Donut', 400, 1.00); 
insert into food(IID, description, calories, priceUSD) values ('i004', 'Lemon Stick', 430, 1.50); 
insert into food(IID, description, calories, priceUSD) values ('i005', 'Blueberry Bagel', 310, 3.00); 
insert into food(IID, description, calories, priceUSD) values ('i009', 'Poppy Seed Bagel',350, 3.00); 
insert into food(IID, description, calories, priceUSD) values ('i011', 'Blueberry Crumb Cake Donut', 420, 1.25); 
 

--drinks--
insert into drinks(IID, description, calories, priceUSD) values ('i002', 'Medium Dunkaccino', 350, 3.00);
insert into drinks(IID, description, calories, priceUSD) values ('i006', 'Medium Hot Chocolate', 330, 2.75);
insert into drinks(IID, description, calories, priceUSD) values ('i007', 'Small Hot Coffee', 5, 1.75);
insert into drinks(IID, description, calories, priceUSD) values ('i008', 'Espresso', 5, 1.99);
insert into drinks(IID, description, calories, priceUSD) values ('i010', 'Espresso with Sugar', 30, 2.25);


--store offerings-- 
--store 1--
insert into storeofferings(SID, IID) values ('s001', 'i001');
insert into storeofferings(SID, IID) values ('s001', 'i002');
insert into storeofferings(SID, IID) values ('s001', 'i003');
insert into storeofferings(SID, IID) values ('s001', 'i004');
insert into storeofferings(SID, IID) values ('s001', 'i005');
insert into storeofferings(SID, IID) values ('s001', 'i006');
insert into storeofferings(SID, IID) values ('s001', 'i007');
insert into storeofferings(SID, IID) values ('s001', 'i008');
insert into storeofferings(SID, IID) values ('s001', 'i009');
insert into storeofferings(SID, IID) values ('s001', 'i010');
insert into storeofferings(SID, IID) values ('s001', 'i011');

--store 2-- only drinks
insert into storeofferings(SID, IID) values ('s002', 'i002');
insert into storeofferings(SID, IID) values ('s002', 'i006');
insert into storeofferings(SID, IID) values ('s002', 'i007');
insert into storeofferings(SID, IID) values ('s002', 'i008');
insert into storeofferings(SID, IID) values ('s002', 'i010');

--store 3--
insert into storeofferings(SID, IID) values ('s003', 'i001');
insert into storeofferings(SID, IID) values ('s003', 'i002');
insert into storeofferings(SID, IID) values ('s003', 'i003');
insert into storeofferings(SID, IID) values ('s003', 'i004');
insert into storeofferings(SID, IID) values ('s003', 'i005');
insert into storeofferings(SID, IID) values ('s003', 'i007');
insert into storeofferings(SID, IID) values ('s003', 'i008');
insert into storeofferings(SID, IID) values ('s003', 'i009');
insert into storeofferings(SID, IID) values ('s003', 'i010');
insert into storeofferings(SID, IID) values ('s003', 'i011');

--store 4--
insert into storeofferings(SID, IID) values ('s004', 'i001');
insert into storeofferings(SID, IID) values ('s004', 'i002');
insert into storeofferings(SID, IID) values ('s004', 'i005');
insert into storeofferings(SID, IID) values ('s004', 'i006');
insert into storeofferings(SID, IID) values ('s004', 'i008');
insert into storeofferings(SID, IID) values ('s004', 'i009');

--store 5-- 

insert into storeofferings(SID, IID) values ('s005', 'i001');
insert into storeofferings(SID, IID) values ('s005', 'i002');
insert into storeofferings(SID, IID) values ('s005', 'i003');
insert into storeofferings(SID, IID) values ('s005', 'i004');
insert into storeofferings(SID, IID) values ('s005', 'i005');
insert into storeofferings(SID, IID) values ('s005', 'i006');
insert into storeofferings(SID, IID) values ('s005', 'i007');
insert into storeofferings(SID, IID) values ('s005', 'i008');
insert into storeofferings(SID, IID) values ('s005', 'i009');
insert into storeofferings(SID, IID) values ('s005', 'i010');
insert into storeofferings(SID, IID) values ('s005', 'i011');


--orders
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o001', 'p004', 's002','i002', '2017-04-26', 3);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o002', 'p018', 's001', 'i006', '2017-02-02', 2.75);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o003', 'p009', 's005', 'i003', '2016-05-22', 1);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o005', 'p020', 's003', 'i010', '2017-01-15', 2.25);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o006', 'p006', 's005', 'i009', '2014-12-26', 3);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o004', 'p004', 's004', 'i002', '2017-04-14', 3);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o007', 'p004', 's005', 'i011', '2017-01-31', 1.25);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o008', 'p020', 's001', 'i007', '2016-12-25', 1.75);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o009', 'p009', 's002','i002', '2017-03-17', 3);
insert into orders(OId, PID, SID, iid, dateordered, totalUSD) values ('o010', 'p004', 's003', 'i001', '2017-04-26', 2.5);

--VIEWS
--inactive customers
create or replace view inactiveCustomers
as select distinct p.pid, p.firstname, p.lastname
from customers c, orders o, people p
where c.pid not in 
(select pid from orders)
 and c.pid = p.pid
order by p.pid ASC;

Select * from inactiveCustomers;

--unordered food
create or replace view unorderedFood 
as select * from food f
where f.iid in (
select distinct i.iid
	from items i
	where i.iid not in 
	(select iid from orders))
order by f.iid ASC;

select * from unorderedFood;

--perksLocations
create or replace view perksLocations
as 
select z.city, z.state
from zipcode z, customers c, people p
where z.zipcode = p.zipcode
and c.pid = p.pid and c.perksmember = 'Yes'
group by z.city, z.state;

Select * from perksLocations;

--STORED PROCEDURES

--Searching with customer name

CREATE OR REPLACE FUNCTION searchCustomerName(TEXT, TEXT, REFCURSOR) RETURNS refcursor AS
$$
	DECLARE
		searchFirst TEXT := $1;
		searchLast TEXT := $2;
		resultSet REFCURSOR := $3;
BEGIN
 	OPEN resultset FOR
 SELECT *
 FROM people 
 WHERE firstname LIKE searchFirst
 AND lastname LIKE searchLast;
 	return resultSet;
end;
$$
LANGUAGE plpgsql;

--test it

SELECT searchCustomerName('A%', 'L%', 'ref');
FETCH ALL FROM ref;

SELECT searchCustomerName('%', 'Leah%', 'ref1');
FETCH ALL FROM ref1;

SELECT searchCustomerName('%n', '%', 'ref2');
FETCH ALL FROM ref2;

--Calories consumed
CREATE OR REPLACE FUNCTION getCalories(TEXT, TEXT, REFCURSOR) RETURNS refcursor AS
$$
	DECLARE
		searchFirst TEXT := $1;
		searchLast TEXT := $2;
		resultSet REFCURSOR := $3;
BEGIN
 	OPEN resultset FOR
 select p.pid, p.firstname, p.lastname, sum(f.calories) + sum(d.calories) as calories 
from orders o left outer join drinks d on o.iid = d.iid
		left outer join food f on o.iid = f.iid
		left outer join customers c on o.pid = c.pid
		left outer join people p on o.pid = p.pid	
where o.pid=c.pid and 
 p.firstname LIKE searchFirst
 AND p.lastname LIKE searchLast
 group by p.pid, p.firstname, p.lastname;
 	return resultSet;
end;
$$
LANGUAGE plpgsql;

--test it

SELECT getCalories('R%', 'W%', 'ref3');
FETCH ALL FROM ref3;

SELECT getCalories('%%', 'M%', 'ref4');
FETCH ALL FROM ref4;

-- location
CREATE OR REPLACE FUNCTION storeLocation(TEXT, REFCURSOR) RETURNS refcursor AS
$$
	DECLARE
		searchZip TEXT := $1;
		resultSet REFCURSOR := $2;
BEGIN
 	OPEN resultset FOR
 select * from zipcode z
	
where z.city like searchZip
and z.zipcode in (select zipcode from stores);
 	return resultSet;
end;
$$
LANGUAGE plpgsql;

SELECT storeLocation('%e%','ref5');
FETCH ALL FROM ref5;

SELECT storeLocation('%o%','ref6');
FETCH ALL FROM ref6;

--TRIGGERS
--check food

CREATE OR REPLACE FUNCTION checkFood()
RETURNS TRIGGER AS
$$
BEGIN 
   IF (select i.type from items i where i.iid=NEW.IID ) = 'drink'

    THEN
  delete from food where iid = NEW.IID;
  insert into drinks(IID, description, calories, priceUSD) values (NEW.IID, NEW.Description, NEW.CALORIES, NEW.PriceUSD); 
   END IF;
   RETURN NEW;
END;
$$
language plpgsql;

CREATE TRIGGER checkFood	
AFTER INSERT ON Food
FOR EACH ROW 
EXECUTE PROCEDURE checkFood();

insert into items(IID, Type) values ('i013', 'drink');

insert into food(IID, description, calories, priceUSD) values ('i013', 'Testing', 310, 3); 

select * from food;
select * from drinks;
select * from items;

--checkDrink
CREATE OR REPLACE FUNCTION checkDrink()
RETURNS TRIGGER AS
$$
BEGIN 
   IF (select i.type from items i where i.iid=NEW.IID ) = 'food'

    THEN
  delete from drinks where iid = NEW.IID;
  insert into food(IID, description, calories, priceUSD) values (NEW.IID, NEW.Description, NEW.CALORIES, NEW.PriceUSD); 
   END IF;
   RETURN NEW;
END;
$$
language plpgsql;

CREATE TRIGGER checkDrink	
AFTER INSERT ON Drinks
FOR EACH ROW 
EXECUTE PROCEDURE checkDrink();

insert into items(IID, Type) values ('i012', 'food');

insert into drinks(IID, description, calories, priceUSD) values ('i012', 'Testing food', 352, 2.29); 
select * from food;

select * from food;
select * from drinks;
select * from items;

--price ceiling trigger
CREATE OR REPLACE FUNCTION foodCeiling()
RETURNS TRIGGER AS
$$
BEGIN 
   IF NEW.priceUSD >=5 THEN
  delete from food where priceUSD = NEW.priceUSD;
  delete from items where iid = NEW.iid;
   END IF;
   RETURN NEW;
END;
$$
language plpgsql;

CREATE TRIGGER foodCeiling
AFTER INSERT ON Food
FOR EACH ROW 
EXECUTE PROCEDURE foodCeiling();

--test it:
insert into items(IID, Type) values ('i014', 'food');
insert into food(IID, description, calories, priceUSD) values ('i014', 'Too Expensive', 310, 6); 
select * from food;
Select * from items;

--REPORTS
--total $ collected in 2017:
select sum(totalUSD) 
from orders 
where dateordered >= '2017-01-01';

--Total number of orders in 2017:
select count(oid) from orders where dateordered >= '2017-01-01';

--Average calories from every item:
Select round((avg(d.calories) + avg(f.calories))/2) from drinks d, food f;

--Average price from every item:
Select round((round(avg(d.priceUSD), 2) + round(avg(f.priceUSD), 2))/2, 2) 
from drinks d, food f;

create role admin;
create role CEO;
create role managers;
grant all on all tables in schema public to admin; 

grant SELECT, INSERT, UPDATE, DELETE on managers to CEO;
grant SELECT, INSERT, UPDATE, DELETE on crew to CEO;
grant SELECT, INSERT, UPDATE, DELETE on staff to CEO;
grant SELECT, INSERT, UPDATE, DELETE on people to CEO;
grant SELECT, INSERT, UPDATE on bannedCustomers to CEO;
grant SELECT, INSERT, UPDATE on customers to CEO;
grant SELECT, INSERT, UPDATE, DELETE on orders to CEO;
grant SELECT, INSERT, UPDATE, DELETE on items to CEO;
grant SELECT, INSERT, UPDATE, DELETE on food to CEO;
grant SELECT, INSERT, UPDATE, DELETE on drinks to CEO;
grant SELECT, INSERT, UPDATE, DELETE on storeOfferings to CEO;
grant SELECT, INSERT, UPDATE, DELETE on stores to CEO;
grant SELECT, INSERT, UPDATE, DELETE on zipcode to CEO;

grant SELECT, INSERT, UPDATE, DELETE on crew to managers;
grant SELECT, INSERT, UPDATE, DELETE on staff to managers;
grant SELECT, INSERT, UPDATE on people to managers;
grant SELECT, INSERT, UPDATE on bannedCustomers to managers;
grant SELECT, INSERT, UPDATE on customers to managers;
grant SELECT on orders to managers;
grant SELECT on items to managers;
grant SELECT on food to managers;
grant SELECT on drinks to managers;
grant SELECT on storeofferings to managers;

revoke all on all tables in schema public from CEO; 
