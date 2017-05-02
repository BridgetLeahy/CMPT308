--Bridget Leahy
--CMPT 308, Dr. Labouseur
--Dunkin Donuts Database
--Contains Roles/Security Privileges
--Create Tables Statments, Insert Data Statements, Views, Stored Procedures, Triggers, Reports are in Leahy_FinalProject_SQL1
--Last Modified: 5/2/17

-------------------------
-- Drop Existing Roles --
-------------------------
drop role if exists admin;
drop role if exists ceo;
drop role if exists managers;

-------------------
-- Create Roles --
-------------------
create role admin;
create role CEO;
create role managers;

----------------------
-- Grant Privileges --
----------------------

-- admin:
grant all on all tables in schema public to admin; 

-- CEO:
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

-- Managers:
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


-----------------------
-- Revoke Privileges --
-----------------------
revoke all on all tables in schema public from CEO; 