create schema Afdeling;

create TABLE Project(
    id int primary key IDENTITY(1,1),
    naam varchar(45) not NULL,
)

create table Medewerker(
    id int PRIMARY key IDENTITY(1,1),
    AfdelingId int FOREIGN key references Afdeling,
    voornaam VARCHAR(45) not NULL,
    achternaam VARCHAR(45) not NULL,
)


create table ProjectMedewerker(
    id int PRIMARY key IDENTITY (1, 1),
    projectId int FOREIGN key REFERENCES Project,
    medewerkerId int FOREIGN key references Medewerker,
    taak VARCHAR(45) NULL,
    urenGewerkt int not null DEFAULT '0'

)






insert into 
