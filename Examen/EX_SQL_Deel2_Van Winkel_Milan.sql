/* Vraag a:

    Geef voor alle afdelingen:
    -De titel in de vorm: 'AFD' gevolgd door het id van de afdeling - titel
    -Het aantal kamers
    -De supervisor met eerste letter van de voornaam in hoofdletters gevolgd door een punt en
    dan door de familienaam

    Geef voor alle kamers die een '6' hebben in hun kamernummer en
    afdelingen met id '1' mogen NIET geselecteerd worden.

    Sorteer het resulaat op basis van de afdelingsnaam

*/

select 'AFD' + cast(a.id as varchar) + '- ' + a.titel as 'Afdeling', count(a.capaciteit) as 'Aantal kamers', concat(upper(substring(p.voornaam, 1, 1)), '. ', p.achternaam) as 'Supervisor'
from WZC.Personeel p 
left join WZC.Afdeling a on p.id = a.supervisor
left join WZC.Kamer k on a.id = k.afdelingsId
where a.id != 1 and k.kamernummer != '%6'
group by 'AFD' + cast(a.id as varchar) + '- ' + a.titel, concat(upper(substring(p.voornaam, 1, 1)), '. ', p.achternaam)
order by 'Afdeling'


--


/* Vraag b:

    Geef voor alle personeelsleden die meer dan 2200 bruto verdienen, maar toch minder dan het maximum salaris
    van alle personeelsleden:
        -Naam en voornaam
        -Sinds wanneer ze in dienst zijn
        -Salaris (afgerond naar boven)
        -Functie

    De functie 'DI' betekent dat het om Directielid gaat. Staat de functie op VP, dan gaat om Verpleging.
    Anders gaat het om administratief personeel.

    Sorteer aflopend op salaris zonder afronding naar boven.
*/

select voornaam, achternaam, inDienstSinds, concat('€', ceiling(salaris)) as Salaris,
case
    when functie = 'DI' then 'Directie'
    when functie = 'VP' then 'Verplegend personeel'
    else 'Administratief personeel'
end as Functie
from WZC.Personeel
where salaris >= 2200 and salaris < 6500
order by salaris desc


--


/* Vraag c:

    Geef alle bewoners, maar vermeld specifiek apart een boodschap 'Er is nog geen afdeling toegewezen'
    indien ze nog geen kamers hebben. De geboortedatum verschijnt zoals in het resultaatvoorbeeld.
    Beâal in welke afdeling de bewoner terecht komt. 

    Als de bewoner geboren is voor 1946 dan mag deze niet in de lijst verschijnen.
    Als een kamernummer 'null' is, mag dit record niet mee verschijnen?

    Sorteer alfabetisch o.b.v. de familienaam en voornaam
*/

select b.id, b.voornaam, b.achternaam, k.kamernummer, convert(varchar, b.geboortedatum, 103) as Geboortedatum, isnull(a.titel, 'Er is nog geen afdeling toegewezen')
from WZC.Bewoner b
left join WZC.Kamer k on b.id = k.bewonerId
left join WZC.Afdeling a on k.afdelingsId = a.id
where year(b.geboortedatum) >= 1946 and k.kamernummer is not null
order by achternaam, voornaam


--


/* Vraag d:

    Zoek de bewoners die minstens 6 boeken hebben uitgeleend met voornaam, familienaam en
    bijhorende boek(en) in de mini-bib van het WZC nog niet hebben teruggebracht en waarvan de uitleningsdatum is
    verlopen met 14 dagen. Sorteer op boekId.
*/

select bw.voornaam, bw.achternaam, bo.titel
from WZC.Bewoner bw
left join WZC.Uitleen u on bw.id = u.bewonerId
left join WZC.Boek bo on u.boekId = bo.id
where bw.voornaam = 'Danna' and datediff(day, u.uitleendatum, getutcdate()) > 14
order by boekId


--


/* Vraag e:

    Een administratieve kracht heeft een boek (uitgeleend op 2023-12-10), gereserveerd op de verkeerde persoon
    zijn naam. nl. Sarll Dolly. Het boek moet echter gereserveerd worden op naam van Maria Bakker.
*/ 

-- Manier 1:
update WZC.Bewoner
set achternaam = 'Bakker', voornaam = 'Maria'
where voornaam = 'Dolly' and achternaam = 'Sarll'

-- Manier 2:
update WZC.Bewoner
set voornaam = 
    (
        select achternaam
        from WZC.Bewoner
        where achternaam = 'Bakker'
    )
where voornaam = 'Dolly'

update WZC.Bewoner
set achternaam = 
    (
        select voornaam
        from WZC.Bewoner
        where voornaam = 'Maria'
    )
where achternaam = 'Sarll'
