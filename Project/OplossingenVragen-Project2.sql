/* 1. Vragen ivm SELECT/WHERE */
-- Vraag 1: Geef de naam van alle uitgevers die gevestigd zijn in Japan
select naam
from Games.Uitgever
where land = 'Japan'

-- Vraag 2:  Geef de namen van het spel, waar dat de rating hoger is dan 12 jaar
select naam
from Games.Game
where rating > 12

-- Vraag 3: Geef alle platformen die een prijs hebben die hoger is dan 100 euro
select naam, uitgaveJaar, adviesprijs
from Games.Platform 
where adviesprijs > 100

-- Vraag 4: Geef alle ontwikkelaars die gevestigd zijn in Frankrijk
select naam
from Games.Ontwikkelaar
where land = 'Frankrijk'

-- Vraag 5: Geef de id van de ontwikkelaar van het spel 'Minecraft'
select ontwikkelaarId
from Games.Game
where naam = 'Minecraft'



/* 2. Vragen ivm Scalaire Functies */
-- Vraag 1: Geef alle games met hun prijs weer, en rangschik deze vervolgens van goedkoopst naar het duurst. Het spel mag niet gratis zijn.
select naam, prijs
from Games.Game
where prijs > 0
order by prijs

-- Vraag 2: Geef in een zin weer, hoeveel de speler moet betalen om de game 'Red Dead Redemption 2' te spelen
select 'De speler moet ' + CAST(prijs as varchar) + ' betalen om de game Red Dead Redemption 2 te spelen.' as 'Wat moet de speler betalen?'
from Games.Game
where naam = 'Red Dead Redemption 2'

-- Vraag 3: Toon de positie van de eerste letter 'e' die je tegenkomt, samen met de volledige naam.
select charindex('e', naam), naam
from Games.Platform

-- Vraag 4: Toon de namen van alle uitgevers in hoofdletters.
select upper(naam)
from Games.Uitgever

-- Vraag 5: Geef de lengte weer van de namen van de games en toon hun volledige naam. Rangschik ze tenslotte obv hun lengte, van klein naar groot.
select len(naam) as 'Lengte naam', naam
from Games.Game
order by len(naam)



/* 3. Vragen ivm Joins */
-- Vraag 1: Geef alle ontwikkelaars weer, waarvan het land overeen komt met de uitgever
select o.naam, o.land
from Games.Ontwikkelaar o
inner join Games.Uitgever u on o.id = u.id --> left join is hier ook mogelijk
where o.land = u.land

-- Vraag 2: Geef alle uitgevers weer, die ook de ontwikkelaar zijn van hun spel
select u.naam
from Games.Uitgever u
left join Games.Ontwikkelaar o on u.naam = o.naam
where u.naam = o.naam

-- Vraag 3: Geef alle actie-games weer
select ga.naam
from Games.Game ga
left join Games.GenreGame gega on ga.id = gega.gameId
left join Games.Genre ge on gega.genreId = ge.id
where ge.naam = 'Action'

-- Vraag 4: ...

-- Vraag 5: ...


/* 4 . Vragen ivm Subqueries */
-- Vraag 1:
-- Vraag 2:
-- Vraag 3:
-- Vraag 4:
-- Vraag 5: