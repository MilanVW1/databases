-- Oefening 1
select Tennis.Team.id as teamnr, naam, voornaam
from Tennis.Speler
inner join Tennis.Team on Tennis.Speler.id = Tennis.Team.spelerId


-- Oefening 2
SELECT w.id as wedstrijdnr, naam, voornaam, spelerId
from Tennis.Speler as s
inner join Tennis.Wedstrijd as w on s.id = w.spelerId
order by wedstrijdnr


-- Oefening 3
select Tennis.Wedstrijd.id as wedstrijdnr, naam, voornaam, divisie
from Tennis.Wedstrijd
inner join Tennis.Speler on Tennis.Wedstrijd.spelerId = Tennis.Speler.id
inner join Tennis.Team on Tennis.Wedstrijd.teamId = Tennis.Team.id

-- Oefening 4
SELECT b.id as betalingsnr, naam
from Tennis.Speler
inner join Tennis.Team as t on Tennis.Speler.id = t.spelerId
inner join Tennis.Boete as b on Tennis.Speler.id = b.spelerId

-- Oefening 5
select distinct(naam)
from Tennis.Speler
inner JOIN Tennis.Team on Tennis.Speler.id = Tennis.Team.spelerId
order by naam 

-- Oefening 6
select distinct naam, voornaam
from Tennis.Speler as Speler
inner join Tennis.Wedstrijd as Wedstrijd on Speler.id = Wedstrijd.spelerId
order by naam 

-- Oefening 7
select b.id as betalingsnr, naam, datum
FROM Tennis.Speler as s
inner join Tennis.Boete as b on s.id = b.spelerId
where Year(datum) = 2000

-- Oefening 8
select bl.spelerId as spelerId, naam, functie
from Tennis.Speler as s
inner join Tennis.Bestuurslid as bl on s.id = bl.spelerId
where bl.eindDatum is NULL
order by functie