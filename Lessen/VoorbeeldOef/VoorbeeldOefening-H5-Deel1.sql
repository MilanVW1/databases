-- Geef alle personen die een boete hebben gehad
select spelerId
from Tennis.boete

select naam, voornaam
from Tennis.Speler
where id in (6,44,27,104,44,8,44,27)

-- Met Inner Join
select *
from Tennis.Speler
INNER join Tennis.Boete on Tennis.Speler.id = Tennis.Boete.spelerId

select naam, voornaam, bedrag
from Tennis.Speler
inner join Tennis.Boete on Tennis.Speler.id = Tennis.Boete.spelerId

select CONCAT(naam, voornaam) as naam, bedrag, s.id, w.aantalGewonnenSets
from Tennis.Speler s                            -- 'as' is hier niet verplicht/nodig 
inner join Tennis.Boete b on s.id = b.spelerId
inner join Tennis.Wedstrijd as w on w.spelerId = s.id
where bedrag > 50
order by bedrag


-- Domme Dingen
SELECT *
from Tennis.Bestuurslid
inner join Tennis.Wedstrijd on Tennis.Bestuurslid.spelerId = Tennis.Wedstrijd.id


-- Algemene structuur
select     {kolom1, kolom2}
from       {tabel1}
inner join {tabel2} on ...=...
where      {filtering}
order by   {kolom1}


