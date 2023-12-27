-- Oefening 1
select lidSinds, count(*) as 'Aantal spelers'
from Tennis.Speler
group by lidSinds


-- Oefening 2
select spelerId, AVG(bedrag) as 'Gemiddelde boete', count(*) as 'Aantal boetes'
from Tennis.Boete
group by spelerId


-- Oefening 3
SELECT w.teamId as id, COUNT(*) as 'Aantal wedstrijden', sum(aantalGewonnenSets) as 'Totaal gewonnen'
from Tennis.Wedstrijd w
inner join Tennis.Team t on t.id = w.teamId
where t.divisie = 'ere'
group by w.teamId


-- Oefening 4
select id  as 'spelersnr', naam
from Tennis.Speler
where id in 
(
    select spelerId
    from Tennis.Boete
    where spelerId not in 
    (
        select spelerId
        from Tennis.Team
        where divisie = 'ere'
    )
)


-- Oefening 5
select s.naam, s.voornaam, COUNT(b.bedrag)
from Tennis.Speler s
inner join Tennis.Boete b on b.spelerId = s.id
where plaats = 'Rijswijk'
GROUP by naam, voornaam


-- Oefening 6
select t.id as 'teamnr', divisie, SUM(aantalGewonnenSets) as 'gewonnen sets'
from Tennis.Team t
inner join Tennis.Wedstrijd w on w.teamId = t.id
GROUP by t.id, divisie


-- Oefening 7
select plaats
from Tennis.Speler
GROUP by plaats
having COUNT(naam) > 4


-- Oefening 8
select s.naam, s.voornaam, count(b.bedrag) as 'aantal boetes'
from Tennis.Speler s
INNER join Tennis.Boete b on b.spelerId = s.id
GROUP by s.naam, s.voornaam
having COUNT(bedrag) > 1

-- Oefening 9
select naam, voornaam
from Tennis.Speler s
inner join Tennis.Boete b on b.spelerId = s.id
where bedrag > 40 -- hier kan nooit een scalaire functie staan
GROUP by naam, voornaam
having COUNT(bedrag) >= 2