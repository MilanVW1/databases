--Oefening 1
select upper(naam) as 'naam'
from Tennis.Speler
order BY naam 

--Oefening 2
select naam, len(naam) as 'karakters'
from Tennis.Speler

--Oefening 3
SELECT LOWER(voornaam) + '. ' + UPPER(naam) as 'naam', bondsnummer
from Tennis.Speler
where plaats = 'Den Haag'

--Oefening 4
select id, left(voornaam, 1) + '. ' + naam as 'naam'
from Tennis.Speler
where LEFT(naam, 1) = 'B'

--Oefening 5
select id
from Tennis.Boete
where YEAR(datum) = 2000

--Oefening 6
select id
from Tennis.Boete
where YEAR(datum) > 2000

--Oefening 7
select voornaam + naam as naam, ISNULL(bondsnummer, 'geen')
FROM Tennis.Speler

--Oefening 8
SELECT id, geboortedatum,
        DATENAME(WEEKDAY, geboortedatum) as 'weekdag',
        DATENAME(MONTH, geboortedatum) as 'maand'
from Tennis.Speler
where id < 10

--Oefening 9
select 'Speler ' + TRIM(naam) + ' is geboren op ' + CAST(geboortedatum as varchar) + ', woont in ' + UPPER(plaats )  + 'en heeft als bondsnr ' + bondsnummer as 'wedstrijdspeler'
from Tennis.Speler
where bondsnummer  is not null

--Oefening 10
select 'Speler ' + cast(spelerId as varchar) + ' heeft volgende boete gehad: ' + cast(bedrag as varchar) as '[speler met boetes]'
FROM Tennis.Boete

--Oefening 11
select naam as 'NAAM', DATEDIFF(month, geboortedatum, GETDATE()) as 'maanden_geleefd'
from Tennis.Speler
order by DATEDIFF(month, geboortedatum, GETDATE())

--Oefening 12
select id, spelerId, DATEADD(MONTH, 3, datum) as bestuursdag
from Tennis.Boete