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



-- Oefening 8:
select CONCAT(ltrim(rtrim(UPPER(SUBSTRING(naam, 1, 1)) + substring(naam, 2, 20))), SPACE(1), ltrim(rtrim(UPPER(SUBSTRING(voornaam, 1, 1)))) + ltrim(lower(substring(voornaam, 2, 20)))) as 'Kapperszaak'
from DM_Oef3.Kapper k
where id IN
(
    select kapperId
    from DM_Oef3.Behandeling b
    where b.behandelingTypeId >= 1
)
order by 'Kapperszaak' desc -- ???????????????????????????????????????
/* PROBEREN OM LATER AF TE MAKEN */



-- Oefening 9: later maken



-- Oefening 10:
select CONCAT(p.naam, SPACE(1), p.voornaam) + ' heeft ' + cast(COUNT(pk.kwalificatieId) as varchar) + ' kwalificatie(s)' as 'Overzicht aantal kwalificaties'
from DM_Oef5.Personeelslid p
left join DM_Oef5.PersoneelslidKwalificatie pk on p.id = pk.personeelslidId
left join DM_Oef5.Kwalificatie k on k.id = pk.kwalificatieId
where pk.kwalificatieId is not null
group by p.voornaam, p.naam



-- Oefening 11 - 16, later eventueel maken