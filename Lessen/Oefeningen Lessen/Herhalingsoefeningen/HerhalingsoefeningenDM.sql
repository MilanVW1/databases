-- Oefening 1: Geef per uitvoerdder zijn eventueel uitgegeven albums en de titels van deze nummers.
-- Het resultaat wordt gesorteerd in dalende volgorde van de albumtitels.

select CONCAT(voornaam, ' ', naam) as 'Uitvoerder', 
    case 
        when cd.titel is null then 'Nog geen cd uitgebracht'
        else cd.titel
    end as 'Album',
    nr.titel as 'Titel'
from DM_Oef1.Uitvoerder uv
left join DM_Oef1.Cd cd on uv.id = cd.uitvoerderId
left join DM_Oef1.Nummer nr on nr.cdId = cd.id
order by cd.titel desc -- --> laatste 2 rijen zoals in het gegeven resultaat, niet duidelijk hoe deze moeten komen


-- Oefening 2: Geef per ober weer welke bestelling hij/zij heeft opgenomen bij welke klant. GEEN JOINS Gebruiken

/* select CONCAT(naam, ' ', voornaam) as 'Ober',
from DM_Oef2.Ober
where '...' */



-- Oefening 3: Geef een overzicht van alle werknemer met hun chef.
/* Antwoord 1: INNER JOIN */
select 'De chef van ''' + CONCAT(wrkn.voornaam, SPACE(1), wrkn.naam) + ''' is ''' + CONCAT(wrk.voornaam, SPACE(1), wrk.naam) + '''' as 'Persooneelslid - Chef'
from DM_Oef7.Werknemer wrk
inner join DM_Oef7.Werknemer wrkn on wrk.id = wrkn.werknemerIdChef
where wrkn.werknemerIdChef is not null

/* Antwoord 2: Left-Join */ 
select 'De chef van ''' + CONCAT(wrkn.voornaam, SPACE(1), wrkn.naam) + ''' is ''' + CONCAT(wrk.voornaam, SPACE(1), wrk.naam) + '''' as 'Persooneelslid - Chef'
from DM_Oef7.Werknemer wrk
left join DM_Oef7.Werknemer wrkn on wrk.id = wrkn.werknemerIdChef
where wrkn.werknemerIdChef is not null

/* Antwoord 3: Right-Join */
select 'De chef van ''' + CONCAT(wrkn.voornaam, SPACE(1), wrkn.naam) + ''' is ''' + CONCAT(wrk.voornaam, SPACE(1), wrk.naam) + '''' as 'Persooneelslid - Chef'
from DM_Oef7.Werknemer wrk
right join DM_Oef7.Werknemer wrkn on wrk.id = wrkn.werknemerIdChef
where wrkn.werknemerIdChef is not null



-- Oefening 4: Geef de naam en het aantal bestelling van de chef ober (= met de meeste bestellingen)
select top 1 concat(o.voornaam, ' ', o.naam) as 'Chef ober', COUNT(b.oberId) as 'Aantal bestellingen'
from DM_Oef2.Ober o
inner join DM_Oef2.Bestelling b on o.id = b.oberId
group by concat(o.voornaam, ' ', o.naam)
ORDER by 'Chef ober'



-- Oefening 5: Geef de kapperszaken in dalende volgorde
select CONCAT(ltrim(rtrim(UPPER(SUBSTRING(naam, 1, 1)) + substring(naam, 2, 20))), SPACE(1), ltrim(rtrim(UPPER(SUBSTRING(voornaam, 1, 1)))) + lower(substring(voornaam, 2, 20))) as 'Kapperszaak'
from DM_Oef3.Kapper
order by naam desc



-- Oefening 6: Geef de namen van de kapperszaken en het aantal uitgevoerde behandelingen
select CONCAT(ltrim(rtrim(UPPER(SUBSTRING(naam, 1, 1)) + substring(naam, 2, 20))), SPACE(1), ltrim(rtrim(UPPER(SUBSTRING(voornaam, 1, 1)))) + ltrim(lower(substring(voornaam, 2, 20)))) as 'Kapperszaak', count(b.kapperId) as 'Aantal behandelingen'
from DM_Oef3.Kapper k
left join DM_Oef3.Behandeling b on k.id = b.kapperId
where kapperId is not null
group by CONCAT(ltrim(rtrim(UPPER(SUBSTRING(naam, 1, 1)) + substring(naam, 2, 20))), SPACE(1), ltrim(rtrim(UPPER(SUBSTRING(voornaam, 1, 1)))) + ltrim(lower(substring(voornaam, 2, 20)))), b.kapperId
order by 'Aantal behandelingen' asc, 'Kapperszaak' asc
--==> kan simpeler denk ik



-- Oefening 7: 
select CONCAT(k.naam, space(1), k.voornaam) as Kapperszaak, count(bt.id) as 'Aantal behandelingen'
from DM_Oef3.Kapper k
left join DM_Oef3.Behandeling b on k.id = b.kapperId
left join DM_Oef3.BehandelingType bt on b.behandelingTypeId = bt.id
group by CONCAT(k.naam, space(1), k.voornaam)
having count(bt.id) > 0
order by 'Aantal behandelingen'



-- Oefening 8:
select CONCAT(ltrim(rtrim(UPPER(SUBSTRING(naam, 1, 1)) + substring(naam, 2, 20))), SPACE(1), ltrim(rtrim(UPPER(SUBSTRING(voornaam, 1, 1)))) + ltrim(lower(substring(voornaam, 2, 20)))) as 'Kapperszaak'
from DM_Oef3.Kapper k
where id IN
(
    select kapperId
    from DM_Oef3.Behandeling b
    where b.klantId is not null
)
order by 'Kapperszaak' desc

-- Oefening 9:
select p.personeelsnummer as Personeelsnummer, CONCAT(p.naam, space(1), p.voornaam) as Personeelsnaam, a.naam as Afdeling, l.naam as 'Locatie afdeling', k.naam as Kwalificatie, pk.jaar as Behaald
from DM_Oef5.Gemeente g
left join DM_Oef5.Locatie l on g.id = l.gemeenteId
left join DM_Oef5.Afdeling a on l.id = a.locatieId
left join DM_Oef5.Personeelslid p on a.id = p.afdelingId
left join DM_Oef5.PersoneelslidKwalificatie pk on p.id = pk.personeelslidId
left join DM_Oef5.Kwalificatie k on k.id = pk.kwalificatieId
where p.personeelsnummer is not null
order by p.personeelsnummer


-- Oefening 10:
select CONCAT(p.naam, SPACE(1), p.voornaam) + ' heeft ' + cast(COUNT(pk.kwalificatieId) as varchar) + ' kwalificatie(s)' as 'Overzicht aantal kwalificaties'
from DM_Oef5.Personeelslid p
left join DM_Oef5.PersoneelslidKwalificatie pk on p.id = pk.personeelslidId
left join DM_Oef5.Kwalificatie k on k.id = pk.kwalificatieId
where pk.kwalificatieId is not null
group by p.voornaam, p.naam



-- Oefening 11
select p.personeelsnummer as Personeelsnummer, CONCAT(p.naam, space(1), p.voornaam) as Personeel
from DM_Oef5.Personeelslid p
left join DM_Oef5.PersoneelslidKwalificatie pk on p.id = pk.personeelslidId
where pk.jaar between 1975 and 1985
order by p.personeelsnummer



-- Oefening 12
select CONCAT(YEAR(GETDATE()), '/', ohb.id) as 'Onderhoudsnummer', au.nummerplaat as 'Nummerplaat', mt.merk as 'Merk', mt.[type] as 'Type',  CONCAT(kl.naam, SPACE(1) , kl.voornaam, '(', count(obo.aantal), ')') as 'Klantnaam',
case
    when ohb.kmStand < 20000 then CONCAT('Minder dan ', 20.000, ' km')
    when ohb.kmStand between 20000 and 50000 then CONCAT('Tussen ', 20.000, ' en ', 50.000, ' km')
    when ohb.kmStand > 50000 then CONCAT('Meer dan ', 50.000, ' km') 
end as Kilometerstand,
CONVERT(varchar, ohb.datum, 5)
from DM_Oef6.Onderdeel ond
left join DM_Oef6.OnderhoudsbeurtOnderdeel obo on ond.id = obo.onderdeelId
left join DM_Oef6.Onderhoudsbeurt ohb on ohb.id = obo.onderhoudsbeurtId
left join DM_Oef6.[Auto] au on au.id = ohb.autoId
left join DM_Oef6.MerkType mt on mt.id = au.merkTypeId
left join DM_Oef6.Klant kl on kl.id = au.klantId
group by ohb.kmStand, au.nummerplaat, mt.merk, mt.[type], kl.naam, kl.voornaam, ohb.datum, ohb.id
order by ohb.id


-- Oefening 13
select au.nummerplaat AS 'Nummerplaat', ond.omschrijving AS 'Onderdelen', COUNT(ond.nummer) AS 'Aantal onderdelen'
FROM DM_Oef6.[Onderdeel] ond
left JOIN  DM_Oef6.OnderhoudsbeurtOnderdeel obo ON ond.id = obo.onderdeelId
left JOIN DM_Oef6.Onderhoudsbeurt ohb ON ohb.id = obo.onderhoudsbeurtId
left JOIN DM_Oef6.[Auto] au ON au.id = ohb.autoId
left JOIN DM_Oef6.MerkType mt ON mt.id = au.merkTypeId
left JOIN DM_Oef6.Klant kl ON kl.id = au.klantId
group by au.nummerplaat, ond.omschrijving
having COUNT(ond.nummer) > 1
order by au.nummerplaat;



-- Oefening 14
select a.naam as Afdeling,
case 
    when m.voornaam is null then 'Open vacature'
    when m.naam is null then 'Open vacature'
    else concat(m.voornaam, space(1), m.naam)
end as Afdelingshoofd
from DM_Oef4.Afdeling a
left join DM_Oef4.Medewerker m on m.id = a.medewerkerIdChef


-- Oefening 15
select a.naam as Afdeling,
case 
    when m.voornaam is null then 'Karel Put'
    when m.naam is null then 'Karel Put'
    else concat(m.voornaam, space(1), m.naam)
end as Afdelingshoofd
from DM_Oef4.Afdeling a
left join DM_Oef4.Medewerker m on m.id = a.medewerkerIdChef



-- Oefening 16
--> fuck die kutoefening!!!!
select *
from DM_Oef8.Woonplaats