/**
 * Opgave 1 (3 punten):
 * Geef alle acteurs die geboren zijn in het jaar 1974.
 * Sorteer op naam van de acteur.
 */

select naam, geboortedatum
from Film.Acteur
where YEAR(geboortedatum) = 1974
order by naam

/**
 * Opgave 2 (3 punten):
 * Geef van alle films die een releasedatum hebben en die in USA uitgebracht zijn de titel in hoofdletters
 * en de releasedatum
 */

select UPPER(titel) as name, CONVERT(varchar, releasedatum, 103) as 'releasedatum'
from Film.Film
where releasedatum is not NULL and land like '%USA%'

/**
 * Opgave 3 (4 punten):
 * Toon de volgende informatie van alle films met genre �Romance�:
 *  � De URL van de film op IMDB. Dat is het IMDB-nummer uit de tabel met ervoor https://www.imdb.com/title/
 *  � De titel van de film
 *  � Hoe oud de film is:
 *	    - Ouder dan 1997: �zeer oude film�
 *      - Tussen 1998 en 2012: �oude film�
 *      - Na 2012: �jongere film�
 * Sorteer op naam van de film.
 */

select CONCAT('https://www.imdb.com/title/' , imdbnr) as urlfilm, titel,
case
    when YEAR(releasedatum) < 1997 then 'Zeer oude film'
    when YEAR(releasedatum) BETWEEN 1998 and 2012 then 'Oude film'
    else 'jongere film'
end as ouderdom
from Film.Film as f
inner join Film.Filmgenre as fg on f.id = fg.filmId
INNER join Film.Genre as g on g.id = fg.genreId
where releasedatum is not null and g.naam = 'Romance'
ORDER by titel

/**
 * Opgave 4 (4 punten):
 * Je vriend(in) argumenteert dat Morgan Freeman de meest universele
 * acteur is. Geef alle genres van films waarin hij ooit geacteerd
 * heeft.
 */

select g.naam
from Film.Acteur as a
INNER join Film.Medewerker as m on a.id = m.acteurId
INNER join Film.Film as f on f.id = m.filmId
inner join Film.Filmgenre as fg on f.id = fg.filmId
inner join Film.Genre as g on g.id = fg.genreId
where a.naam = 'Morgan Freeman'


/**
 * Opgave 5a (2 punten):
 * Maak een tabel �Medewerkertype� aan met de kolommen
 * id (primary key, autonummering), type (varchar(20), not null) in het schema Film.
 */

create table Film.Medewerkertype
(
    id int PRIMARY key IDENTITY(1,1),
    type varchar(20) not null,

) 

/**
 * Opgave 5b (1 punt):
 * Voeg in de tabel medewerkertype 2 records toe
 */

    insert into Film.Medewerkertype(id, type)
    values (1, 'Regisseur'),
           (2, 'Productieleider')

/**
 * Opgave 5c (3 punten):
 * Voeg aan de tabel Medewerker een FK 'typeId'(NNA, DTC) toe.  Deze kolom is een FK naar
 * de tabel medewerkertype.
 */



