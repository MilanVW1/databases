/*========================*/
/*OEFENINGEN SUBQUERIES H6*/
/*========================*/

-- Oefening 1
select id, CONCAT(voornaam, ' ', familienaam) as naam
from HnS.Klant
where gemeente in
(
    select gemeente
    from Hns.Klant
    where postcode in
    (
        select postcode
        from Hns.Klant
        where id = 1
    )
)
order by familienaam

-- Oefening 2
select id as Productnummer, verkoopprijs as Verkoopprijs
from Hns.Product
where categorieId IN
(
    select categorieId
    FROM Hns.Product
    where id = 115
)
order by verkoopprijs

-- Oefening 3
select id, naam, verkoopprijs, ROUND((verkoopprijs+(verkoopprijs*(btwPercentage/100))), 2) as '[verkoopsprijs inclusief BTW]'
from Hns.Product
where verkoopprijs <
(
    select verkoopprijs
    from Hns.Product
    where id = 115
)
order by '[verkoopsprijs inclusief BTW]'

-- Oefening 4
select distinct postcode
from Hns.Klant
where id IN
(
  select klantId
  from Hns.[Order]
)
order by postcode

-- Oefening 5
select id as Klantnummer, CONCAT(familienaam, ' ', voornaam) as Klantnaam
from Hns.Klant
where id not IN 
(
    select klantId
    from HnS.[Order]
)
order by id

-- Oefening 6
select kl.id as Klantnummer, CONCAT(familienaam, ' ', voornaam) as Klantnaam
from Hns.Klant as kl
left join Hns.[Order] od on kl.id = od.klantId
where od.klantId is null
ORDER by Klantnummer



/*============================*/
/* OEFENINGEN SET-FUNCTIES H6*/
/*============================*/

-- Oefening 1
select 'Hns heeft ' + CAST(COUNT(*)as varchar) + ' klanten.' as '[Aantal klanten]'
from Hns.Klant

-- Oefening 2
select COUNT(distinct gemeente) as '[Aantal gemeenten]'
from Hns.Klant

-- Oefening 3
SELECT COUNT(*) as Aantal
from Hns.Klant
where gsm is null


select count(id) - COUNT(gsm) as 'Aantal'
from Hns.Klant

-- Oefening 4
SELECT count(*) as '[Aantal geabonneerde klanten op nieuwsbrief 1]'
from Hns.NieuwsbriefKlant
where nieuwsbriefId = 1

-- Oefening 5
select count(nieuwsbriefId) as '[Aantal geabonneerde klanten op nieuwsbrief Games]'
from Hns.NieuwsbriefKlant nbk
inner join Hns.Nieuwsbrief nb on nb.id = nbk.nieuwsbriefId
where omschrijving = 'Games'

-- Oefening 6
select count(id) as '[Aantal orders van klantnummer 14]'
from Hns.[Order]
where klantId = 14


-- Oefening 7
select sum(verkoopprijs * hoeveelheid * (1 + (btwPercentage/100)) * (1 - (korting/100))) as '[Totaal bedrag inclusief BTW voor klant 14]'
from Hns.Orderlijn
inner join Hns.[Order] on Hns.[Order].id = Hns.Orderlijn.orderId
where klantId = 14
