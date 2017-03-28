--Zip--
DROP TABLE IF EXISTS ZipCode;
CREATE TABLE ZipCode (
ZipCode real not null,
City text,
State text,
primary key(ZipCode)
);

--People --
DROP TABLE IF EXISTS People;
CREATE TABLE People (
PID char(4) not null,
FirstName text,
LastName text,
StreetAddress text,
ZipCode real not null references ZipCode(ZipCode),
Married bool,
Actor bool,
Director bool,
primary key(PID)
);

--Actors--
DROP TABLE IF EXISTS Actors;
CREATE TABLE Actors (
PID char(4) not null references People(PID),
HairColor text,
EyeColor text,
HeightInches integer,
WeightLBs integer,
FavColor text,
ActorsGuildAnnivDate date,
unique (PID),
primary key(PID)
);

--Directors --
DROP TABLE IF EXISTS Directors;
CREATE TABLE Directors (
PID char(4) not null references People(PID),
FilmSchool text,
FavLensMaker text, 
DirGuildAnnivDate date,
unique (PID),
primary key(PID)
);

--Movies--
DROP TABLE IF EXISTS Movies;
CREATE TABLE Movies (
MID char(4) not null,
Name text,
YearReleased char(4),
MPAANum real,
DomBoxSalesUSD money,
ForeignBoxSalesUSD money,
DVDBluBoxSalesUSD money,
primary key(MID)
);

--Spouses--
DROP TABLE IF EXISTS Spouses;
CREATE TABLE Spouses (
PID char(4) not null references People(PID),
SpouseFirstName text,
SpouseLastName text,
unique (PID),
primary key(PID)
);

--CastCrew--
DROP TABLE IF EXISTS CastCrew;
CREATE TABLE CastCrew (
MID char(4) not null references Movies(MID),
PID char(4) not null references People(PID),
Role text not null,
unique (MID, PID),
primary key(MID, PID, Role)
);
----SAMPLE DATA TO CHECK QUERY ACCURACY: --


--random zipcode--
insert into zipcode(zipcode) values (22222);

--people--
insert into people(pid, firstname, lastname, zipcode, actor, director) values (000, 'Sean', 'Connery', 22222, true, false);
insert into people(pid, firstname, lastname, zipcode, actor, director) values (001, 'Random', 'Director', 22222, false, true);
insert into people(pid, firstname, lastname, zipcode, actor, director) values (002, 'Random', 'Actor', 22222, true, false);
insert into people(pid, firstname, lastname, zipcode, actor, director) values (003, 'SeanDir1', 'SeanDir1', 22222, true, true);
insert into people(pid, firstname, lastname, zipcode, actor, director) values (004, 'SeanDir2', 'SeanDir2', 22222, false, true);

--movies--
insert into movies(MID) values (000);
insert into movies(MID) values (001);
insert into movies(MID) values (002);

--castcrew--
insert into CastCrew(MID, PID, role) values (000, 000, 'Actor');
insert into CastCrew(MID, PID, role) values (001, 000, 'Actor');
insert into CastCrew(MID, PID, role) values (000, 002, 'Actor');
insert into CastCrew(MID, PID, role) values (000, 003, 'Director');
insert into CastCrew(MID, PID, role) values (001, 004, 'Director');
insert into CastCrew(MID, PID, role) values (002, 002, 'Actor');
insert into CastCrew(MID, PID, role) values (002, 001, 'Director');



--query for directors who have worked with Sean Connery--
Select FirstName, Lastname
From People
Where PID in
	(Select PID from CastCrew 
	Where MID in 
		(Select MID from CastCrew 
		Where PID in
			(Select pid from people 
			Where FirstName = 'Sean'
			and LastName = 'Connery'
			and Actor = true)
		and Role = 'Actor')
	and Role = 'Director')
and Director = true;

