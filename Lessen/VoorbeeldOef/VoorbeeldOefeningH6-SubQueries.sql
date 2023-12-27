-- Geef iedereen die in hetzelfde dorp woont als Pieter
select *
from Tennis.Speler
where plaats = (
    select plaats
    from Tennis.Speler
    where voornaam = (
        select voornaam
        from Tennis.Speler
        where geboortedatum = '1976-11-11'
    )
)

-- Geef iedereen die in hetzelfde jaar is geboren dan Pieter
select *
from Tennis.Speler
where year(geboortedatum) = (
    select YEAR(geboortedatum)
    from Tennis.Speler
    where voornaam = 'Peter'
) and month(geboortedatum) = (
    select month(geboortedatum)
    from Tennis.Speler
    where voornaam = 'Peter'
)


select *
from Tennis.Speler
where month(geboortedatum) = (
    select month(geboortedatum)
    from Tennis.Speler
    where voornaam = 'Peter'
)


select *
from Tennis.Speler
where year(geboortedatum) = 1983
and month(geboortedatum) = 5

-- Geef alle spelers die een boete hebben gekregen
/* Zelfde QUERY met gebruik van subquery */
select voornaam, naam
from Tennis.Speler
where id not in --in gebruiken ipv '=' ==> geeft error | '=' kun je vervangen door in bij andere subqueries, meerdere resultaten | bij 1 resultaat --> '='
(
    select spelerId
    from Tennis.Boete
)

/* Zelfde QUERY met gebruik van joins */
select distinct voornaam, naam
from Tennis.Speler
inner join Tennis.Boete on Tennis.Speler.id = Tennis.Boete.spelerId

-- Geef alle spelers die ouder zijn dan meneer Meuleman
select geboortedatum
from Tennis.Speler
where naam = 'Meuleman'

select naam, voornaam, geboortedatum,
       (select geboortedatum from Tennis.Speler where naam = 'Meuleman') as 'Geboortedatum van Meuleman'
from Tennis.Speler
where geboortedatum < ( -- ==> is mogelijk met andere operaties (<, !=, <=, >=...) --> enkel bij 1 resultaat, anders 'in' gebruiken
    select geboortedatum
    from Tennis.Speler
    where voornaam = 'Marjan'
) and geboortedatum < (
    select geboortedatum
    from Tennis.Speler
    where voornaam = 'Carla'
)

-- Geef iedereen die in hetzelfde team speelt als Raf
select distinct teamId
from Tennis.Speler
inner join Tennis.Wedstrijd on Tennis.Wedstrijd.spelerId = Tennis.Speler.id
where voornaam = 'Raf'

select distinct naam, voornaam
from Tennis.Speler
inner join Tennis.Wedstrijd on Tennis.Wedstrijd.spelerId = Tennis.Speler.id
where teamId = (
    select distinct teamId
    from Tennis.Speler
    inner join Tennis.Wedstrijd on Tennis.Wedstrijd.spelerId = Tennis.Speler.id
    where voornaam = 'Raf'
)

/* Kijk goed of je iets van hetzelfde type vergelijkt ==> geen appelen met peren vergelijken!! (voornaam met teamId...) */

------------------------------------------------------------------

/* SET-FUNCTIES */
-- 1. Count()
select count(bondsnummer) --maar 1 kolom mogelijk
from Tennis.Speler

select count(*)
from Tennis.Boete

-- 2. Min() & Max() 
select min(bedrag)
from Tennis.Boete

select max(bedrag)
from Tennis.Boete


-- 3. Avg() & Sum()
select AVG(bedrag) -- AVG = 'average'
from Tennis.Boete

select sum(bedrag)
from Tennis.Boete

/* Elke SCALAIRE FUNCTIE geeft een lijst van gegevens terug en SET-functies geven een bewerking terug!!!!! */


-- Geef iedere speler die ouder is dan Cools.
select *
from Tennis.Speler
where geboortedatum >
(
    select min(geboortedatum)
    from Tennis.Speler
    where naam = 'Cools'
)


select count(distinct plaats) as 'Aantal unieke plaatsen', COUNT(geboortedatum) as 'Aantal geboortedata', sum(id) as 'Som van IDs'
from Tennis.Speler