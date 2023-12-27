create schema TestLes2;

drop table if exists TestLes2.Cd
drop table if exists TestLes2.Uitvoerder


create table TestLes2.Uitvoerder(
    id int primary key identity(1,1),
    naam VARCHAR(30) not null,
    voornaam varchar(30),
    gemeente VARCHAR(40) not null DEFAULT 'Lier'
)

CREATE TABLE TestLes2.Cd(
    id int PRIMARY KEY IDENTITY(1,1),
    uitvoerderId int FOREIGN key REFERENCES TestLes2.Uitvoerder(id),
    titel varchar(100) not null,
)


insert into TestLes2.Uitvoerder (naam, voornaam)
values('Van Winkel', 'Milan')

insert into TestLes2.Cd(uitvoerderId, titel)
values(1, 'The Best of')