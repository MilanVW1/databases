/*============================*/
/* 1. Vragen ivm SELECT/WHERE */
/*============================*/
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



/*=================================*/
/* 2. Vragen ivm Scalaire Functies */
/*=================================*/
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



/*=====================*/
/* 3. Vragen ivm Joins */
/*=====================*/
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

-- Vraag 4: Geef de naam van de game(s), waarvan de ontwikkelaar 'Bethesda Game Studios' is.
select g.naam
from Games.Game g
left join Games.Ontwikkelaar o on o.id = g.ontwikkelaarId
where o.naam = 'Bethesda Game Studios'

-- Vraag 5: ...



/*==========================*/
/* 4. Vragen ivm Subqueries */
/*==========================*/
-- Vraag 1: Toon alle games die duurder zijn dan het gemiddelde van alle gameprijzen.
select naam
from Games.Game
where prijs >
(
    select avg(prijs)
    from Games.Game
)

-- Vraag 2: Geef de gemiddelde prijs van alle games uitgebracht door 'Capcom'
select AVG(prijs) as 'Gemiddelde prijs van alle games v/ uitgever'
from Games.Game
where uitgeverId = 
(
    select id 
    from Games.Uitgever 
    where naam = 'Capcom'
)

-- Vraag 3: ...
-- Vraag 4: ...
-- Vraag 5: ...



/*============================*/
/* 5. Vragen ivm SET-functies */ 
/*============================*/
-- Vraag 1: Geef het gemiddelde van alle prijzen van de platformen (afgerond op 2 getallen na de komma)
select round(avg(adviesprijs), 2) as 'Gemiddelde adviesprijs v/ alle platformen'
from Games.Platform
where adviesprijs is not null

-- Vraag 2: Geef de laagste prijs dat een game kost
select min(prijs)
from Games.Game
where prijs != 0

-- Vraag 3: Geef het aantal games waarvan de minimumleeftijd 16 jaar is
select count(naam) as 'Aantal games met minimumleeftijd 16'
from Games.Game
where minimumLeeftijd = 16



/*==================================*/
/* 6. Vragen ivm Group-By & Havings */ 
/*==================================*/
-- Vraag 1: Toon het aantal games per platform
select p.naam, count(*) as 'Aantal games'
from Games.GamePlatform gp
left join Games.Platform p on p.id = gp.platformId
group by p.naam

-- Vraag 2: Toon alle genres en het games per genre, gesorteerd op het aantal games in aflopende volgorde. Het aantal games mag niet nul zijn.
select ge.naam as 'Genre', count(gega.gameId) as 'Aantal games in genre'
from Games.Genre ge
left join Games.GenreGame gega on ge.id = gega.genreId
group by ge.naam
having count(gega.gameId) > 0
order by 'Aantal games in genre' desc

-- Vraag 3: Geef het aantal games per hardwareproducent, waar het aantal groter is dan 1
select hp.naam as 'Hardwareproducent', count(*) as 'Aantal games per hardwareproducent'
from Games.HardwareProducent hp
left join Games.Platform p on hp.id = p.producentId
left join Games.GamePlatform gp on p.id = gp.platformId
group by hp.naam
having count(*) > 1

-- Vraag 4: Toon de landen van de uitgevers die 2 of meer games hebben 
select u.land, count(uitgeverId) as 'Aantal games per land'
from Games.Uitgever u
left join Games.Game ga on u.id = ga.uitgeverId
group by u.land
having count(uitgeverId) >= 2

-- Vraag 5: Toon het aantal consoles/ platformen die uitgebracht zijn per jaar
select uitgaveJaar, count(naam) as 'Aantal platformen uitgebracht in uitgavejaar'
from Games.Platform
group by uitgaveJaar