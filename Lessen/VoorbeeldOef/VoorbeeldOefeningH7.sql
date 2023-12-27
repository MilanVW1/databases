-- 1. Geef alle plaatsen uit de Speler tabel
select distinct plaats
from Tennis.Speler

select plaats
from Tennis.Speler
group by plaats --> steekt alle zelfde waarden in 1 groepje

select plaats, count(*) as 'Aantal inwoners'
from Tennis.Speler
GROUP by plaats


-- 2. Geef het totaal bedrag van boetes per persoon
select spelerId, sum(bedrag) as 'Totaal bedrag'
from Tennis.Boete
group by spelerId

select spelerId, sum(bedrag) as 'Totaal bedrag', count(bedrag) as 'Aantal boetes'
from Tennis.Boete
group by spelerId

-- 3. Geef alle boetes per jaar
/* GROUP BY */
select YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag'
from Tennis.Boete
group by YEAR(datum)

select spelerId, YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag'
from Tennis.Boete
group by spelerId, YEAR(datum)

select CONCAT(naam, ' ', voornaam) as Naam, YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag'
from Tennis.Boete b
inner join Tennis.Speler s on b.spelerId = s.id 
group by naam, voornaam, YEAR(datum)

select naam, voornaam, YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag', COUNT(*)
from Tennis.Boete b
inner join Tennis.Speler s on b.spelerId = s.id 
group by naam, voornaam, YEAR(datum)

-- WHERE gebruiken
select naam, voornaam, YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag', COUNT(*)
from Tennis.Boete b
inner join Tennis.Speler s on b.spelerId = s.id 
where YEAR(datum) > 2002
group by naam, voornaam, YEAR(datum)

select naam, voornaam, YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag', COUNT(*)
from Tennis.Boete b
inner join Tennis.Speler s on b.spelerId = s.id 
where naam != 'Cools'
group by naam, voornaam, YEAR(datum)


/*-------------------*/
/* HAVING gebruiken  */
/*-------------------*/
select naam, voornaam, YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag', COUNT(*)
from Tennis.Boete b
inner join Tennis.Speler s on b.spelerId = s.id 
group by YEAR(datum)
having YEAR(datum) > 2002

select YEAR(datum) as 'Jaar van boete', sum(bedrag) as 'Totaalbedrag', COUNT(*)
from Tennis.Boete b
inner join Tennis.Speler s on b.spelerId = s.id 
group by YEAR(datum)
having SUM(bedrag) > 100


/* GOUDEN REGEL = Als je group-by hebt, dan moet je bij 'select' zetten wat je in group-by zet, of als je set-functies gebruikt. 
==> werkt dus niet als je bij 'select' een scalaire functie hebt. Meerdere kolommen zijn mogelijk bij 'group-by'. */

-- INNER JOIN is mogelijk bij group BY

select bondsnummer, count(*)
from Tennis.Speler
group by bondsnummer -- 'NULL' wordt als een groepje genomen


/*===================*/
/* VOLGORDE VAN SQL */
/*==================*/
-- 1. Select
-- 2. From
-- 3. Joins
-- 4. Where
-- 5. Group By
-- 6. Havings
-- 7. Order By
