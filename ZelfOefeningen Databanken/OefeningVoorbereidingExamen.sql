-- 1. Welke afdelingen hebben meer dan 10 bewoners?
select a.titel, count(k.bewonerId) as 'Aantal bewoners in afdeling'
from WZC.Kamer k
left join WZC.Bewoner b on b.id = k.bewonerId
left join WZC.Afdeling a on a.id = k.afdelingsId
group by a.titel
having count(k.bewonerId) >= 10

-- 2. Welke boeken zijn uitgeleend aan een bewoner die ouder is dan 30 jaar?
select b.titel as 'Boek', CONCAT(bw.voornaam, space(1), bw.achternaam) as 'Naam', CONVERT(varchar, u.uitleendatum, 5) as 'Uitleendatum', DATEDIFF(year, bw.geboortedatum, GETUTCDATE()) as 'Leeftijd bewoner'
from WZC.Uitleen u
left join WZC.Boek b on b.id = u.boekId
left join WZC.Bewoner bw on bw.id = u.bewonerId

-- 3. Wat is het gemiddelde salaris van de werknemers die rapporteren aan een supervisor met de naam "Jan Janssen"?

select AVG(p.salaris) as 'Gemiddeld Salaris'
from WZC.Personeel p
left join WZC.Afdeling a on p.id = a.supervisor
where a.supervisor = 
(
    select id
    from WZC.Personeel
    where voornaam = 'Hanna' and achternaam = 'Pieters'
)

-- 4. Wat is de naam van de afdeling met het hoogste gemiddelde salaris?
select a.titel, avg(p.salaris) as 'Gemiddeld Salaris'
from WZC.Personeel p
left join WZC.Afdeling a on a.id = p.salaris
group by a.titel
order by 'Gemiddeld Salaris' desc