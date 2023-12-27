--Oefening 1
select id
from Tennis.Speler
where lidsinds between 2000 and 2003


--Oefening 2
select id
from Tennis.Boete
where bedrag BETWEEN 50 and 100


--Oefening 3
select id
from Tennis.Boete
where bedrag  not BETWEEN 50 and 100


--Oefening 4
select id
from Tennis.Speler
where plaats not in ('Den Haag', 'Voorburg')


--Oefening 5
select id, naam
from Tennis.Speler
where naam like '%en%'


--Oefening 6
select id, naam 
from Tennis.Speler 
where naam like '%a_'
order by naam asc

-- kan ook naam & id omgewisseld zijn


--Oefening 7
select id, naam, voornaam
from Tennis.Speler 
where naam like '_e%e_'


--Oefening 8
select id, bedrag,
CASE
    when bedrag BETWEEN 0 and 40 then 'laag'
    when bedrag between 41 and 80 then 'middelmatig'
    when bedrag > 80 then 'hoog'
end as categorie
from Tennis.Boete


--Oefening 9
select id,
case 
    when divisie = 'ere' then 'eredivisie'
    when divisie = 'tweede' then 'tweede divisie'
end as divisie
from Tennis.Team


--Oefening 10
select distinct spelerId
from Tennis.Boete


--Oefening 11
select distinct lidSinds
from Tennis.Speler
where lidSinds >= 2000
order by lidSinds


--Oefening 12
select DISTINCT spelerId
from Tennis.Bestuurslid
where functie = 'penningmeester'
