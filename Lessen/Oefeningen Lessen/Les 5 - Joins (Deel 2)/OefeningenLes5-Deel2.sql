-- Oefening 1
select s.id as Spelersnr, naam as Naam, ISNULL(convert(varchar, datum, 103), '-') as Datum, ISNULL(bedrag, '0.00') as Bedrag
from Tennis.Speler s 
left join Tennis.Boete b on s.id = b.spelerId

-- Oefening 2
select distinct s.id as Spelersnr, naam as Naam, ISNULL(CAST(w.teamId as varchar), 'Niet gespeeld') as Teamnummers
from Tennis.Speler s
left join Tennis.Wedstrijd w on s.id = w.spelerId
where s.bondsnummer is not null
order by Spelersnr

-- Oefening 3
select distinct s.id as Spelersnr, s.naam as Naam, ISNULL(CAST(t.divisie as varchar), 'Niet gespeeld') as Divisie
from Tennis.Speler s
left join Tennis.Wedstrijd w on w.spelerId = s.id
LEFT join Tennis.Team t on t.id = w.teamId
where s.bondsnummer is not null
order by Spelersnr

-- Oefening 4
select sp.id as Spelersnr, sp.naam as Naam
from Tennis.Speler sp
left join Tennis.Speler s on s.plaats = sp.plaats
where s.id = 27
