--Oefening 1
create schema Project
go

drop schema Project
drop table if exists Project.Afdeling
drop table if exists Project.Medewerker
drop table if exists Project.Project
drop table if exists Project.ProjectMedewerker


--Oefening 2
create table Project.Afdeling(
    id int primary key IDENTITY (1,1),        
    naam varchar(45) not null,
    
)

create table Project.Medewerker(
    id int primary key IDENTITY,
    voornaam varchar(45) not NULL,
    achternaam varchar(45) not null,
)

CREATE table Project.Project(
    id int PRIMARY key IDENTITY (1, 1),
    naam varchar(45) not null,
    afdelingId int foreign KEY references Project.Afdeling(id) not null,

)

CREATE table Project.ProjectMedewerker(
    id int primary key IDENTITY,
    projectId int FOREIGN key references Project.Project(id) ON DELETE CASCADE not null unique,
    medewerkerId int FOREIGN key references Project.Medewerker(id)  ON DELETE CASCADE not null unique,
    taak varchar(45) null,
    urengewerkt int not null default 0

)

--Oefening 3--

--inserts voor Afdeling tabel
set IDENTITY_INSERT Project.Afdeling on
insert into Project.Afdeling (id, naam)
values (1, 'Programmatie')

insert into Project.Afdeling (id, naam)
values (2, 'Analyse')

insert into Project.Afdeling (id, naam)
values (3, 'Research')
set IDENTITY_INSERT Project.Afdeling off
--inserts voor Afdeling tabel


--inserts voor Project tabel
set IDENTITY_INSERT Project.Project on
insert into Project.Project (id, naam, afdelingId)
VALUES (1, 'Creating the models', 1) 

insert into Project.Project (id, naam, afdelingId)
VALUES (2, 'Creating the controllers', 1) 

insert into Project.Project (id, naam, afdelingId)
VALUES (3, 'Creating the views', 1) 

insert into Project.Project (id, naam, afdelingId)
VALUES (4, 'Setting up DFS', 3) 
set IDENTITY_INSERT Project.Project off
--inserts voor Project tabel


--inserts voor Medewerkers tabel
set IDENTITY_INSERT Project.Medewerker on
insert into Project.Medewerker(id, voornaam, achternaam)
VALUES (925, 'Matt', 'Damon')

insert into Project.Medewerker(id, voornaam, achternaam)
VALUES (1319, 'Quentin', 'Tarantino')

insert into Project.Medewerker(id, voornaam, achternaam)
VALUES (1386, 'John', 'Cleese')

insert into Project.Medewerker(id, voornaam, achternaam)
VALUES (2017, 'George', 'Clooney')
set IDENTITY_INSERT Project.Medewerker off
--inserts voor Medewerkers tabel



--inserts voor ProjectMedewerker tabel
set IDENTITY_INSERT Project.ProjectMedewerker on
insert into Project.ProjectMedewerker(id, projectId, medewerkerId, taak, urengewerkt)
VALUES (1, 2, 2017, null, 86)

insert into Project.ProjectMedewerker(id, projectId, medewerkerId, taak, urengewerkt)
VALUES (2, 1, 1386, null, 0)

insert into Project.ProjectMedewerker(id, projectId, medewerkerId, taak, urengewerkt)
VALUES (3, 2, 925, 'analist', 0)

insert into Project.ProjectMedewerker(id, projectId, medewerkerId, taak, urengewerkt)
VALUES (4, 3, 1319, null, 135)

insert into Project.ProjectMedewerker(id, projectId, medewerkerId, taak, urengewerkt)
VALUES (5, 3, 2017, null, 0)
set IDENTITY_INSERT Project.ProjectMedewerker off
--inserts voor ProjectMedewerker tabel

        -- ==> niet alle values gaan in tabel?? --> vragen
    