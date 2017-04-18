-- Bridget Leahy
-- 4/18/17
-- Lab 10


-- 1): PreReqsFor:
create or replace function PreReqsFor(courseNum integer, 
					resultSet refcursor) returns refcursor as
$$
declare
   courseNum int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select prerequisites.preReqNum
      from   Prerequisites 
      where prerequisites.courseNum = $1;
   return resultset;
end;
$$ 
language plpgsql;

-- ex:
select PreReqsFor(308, 'result');
fetch all from result;



-- 2). isPreRe
create or replace function isPreReqFor(preReqNum integer, 
					resultSet refcursor) returns refcursor as
$$
declare
   courseNum int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select prerequisites.courseNum
      from   Prerequisites 
      where prerequisites.preReqNum= $1;
   return resultset;
end;
$$ 
language plpgsql;


select isPreReqFor(120, 'results');
fetch all from results;


