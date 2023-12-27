--droppen van tabellen
drop table if exists Games.GamePlatform;
drop table if exists Games.Platform;
drop table if exists Games.GenreGame;
drop table if exists Games.Game;
drop table if exists Games.HardwareProducent;
drop table if exists Games.Uitgever;
drop table if exists Games.Ontwikkelaar;
drop table if exists Games.Genre;

DROP SCHEMA Games;
go

--aanmaken van schema
create schema Games;
go

--aanmaken van tabellen
create table Games.Genre(
    id int PRIMARY key IDENTITY (1,1) not null,
    naam varchar(50) not null,

);
go

create table Games.Ontwikkelaar(
    id int PRIMARY key IDENTITY (1,1) not null,
    naam varchar(50) not null,
    land varchar(50) not null,

);
go

create table Games.Uitgever(
    id int PRIMARY key IDENTITY (1,1) not null,
    naam varchar(50) not null,
    land varchar(50) not null,
);
go

create table Games.HardwareProducent(
    id int PRIMARY key IDENTITY (1,1) not null,
    naam VARCHAR(50) not null,
    land VARCHAR(50) not null

);
go

create table Games.Game(
    id int primary key IDENTITY (1,1) not null,
    naam varchar(50) not null,
    uitgeverId int FOREIGN key references Games.Uitgever(id)  not null,  --on delete restrict is al toegevoegd
    ontwikkelaarId int FOREIGN key references Games.Ontwikkelaar(id) not null, --on delete restrict is al toegevoegd
    beschrijving varchar(MAX) not null,
    minimumLeeftijd int NULL,
    prijs money NULL,
    rating float null,
);
go

create table Games.GenreGame(
    id int primary key IDENTITY (1,1) not null,
    genreId int FOREIGN key references Games.Genre(id),  --on delete restrict is al toegevoegd
    gameId int foreign key references Games.Game(id) on DELETE CASCADE not null

);
go

create table Games.Platform(
    id int primary key IDENTITY (1,1) not null,
    naam varchar(50) not null,
    uitgaveJaar int not null,
    specificaties varchar(225) null,
    adviesprijs money null,
    producentId int FOREIGN key references Games.HardwareProducent(id) on delete set null
);
go

create table Games.GamePlatform(
    id int PRIMARY key IDENTITY (1,1) not null,
    platformId int FOREIGN key references Games.Platform(id) not null, --on delete restrict is al toegevoegd
    gameId int FOREIGN key references Games.Game(id) on delete cascade not null

);
go

--INSERTS--
--Game Genres--
set IDENTITY_INSERT Games.Genre on
insert into Games.Genre (id, naam)
values (1, 'Indie')

insert into Games.Genre(id, naam)
values (2, 'Adventure')

insert into Games.Genre(id, naam)
values (3, 'Action')

insert into Games.Genre(id, naam)
values (4, 'Open World')

insert into Games.Genre(id, naam)
values (5, 'Battle Royale')

insert into Games.Genre(id, naam)
values (6, 'Platformer')

insert into Games.Genre(id, naam)
values (7, 'Horror')

insert into Games.Genre(id, naam)
values (8, 'Strategy')

insert into Games.Genre(id, naam)
values (9, 'RPG')

insert into Games.Genre(id, naam)
values (10, 'MMORPG')

insert into Games.Genre(id, naam)
values (11, 'MMO')

insert into Games.Genre(id, naam)
values (12, 'MOBA')

insert into Games.Genre(id, naam)
values (13, 'Survival')

insert into Games.Genre(id, naam)
values (14, 'Card')

insert into Games.Genre(id, naam)
values (15, 'Adventure')

insert into Games.Genre(id, naam)
values (16, 'Puzzle')

insert into Games.Genre(id, naam)
values (17, 'FPS (First Person Shooter)')

insert into Games.Genre(id, naam)
values (18, 'Simulation')

insert into Games.Genre(id, naam)
values (19, 'Interactive Fiction')

insert into Games.Genre(id, naam)
values (20, 'Sports')

insert into Games.Genre(id, naam)
values (21, 'Fighter')
set IDENTITY_INSERT Games.Genre off
go


--Game Ontwikkelaars-- 
set IDENTITY_INSERT Games.Ontwikkelaar on
insert into Games.Ontwikkelaar(id, naam, land)
values (1, 'Rockstar North', 'Verenigd Koninkrijk') -- uitgever: Rockstar Games

insert into Games.Ontwikkelaar(id, naam, land)
values (2, 'CD Projekt Red', 'Polen') -- uitgever: CD Projekt

insert into Games.Ontwikkelaar(id, naam, land)
values (3, 'Mojang Studios', 'Zweden') -- uitgever: Mojang Studios 

insert into Games.Ontwikkelaar(id, naam, land)
values (4, 'Riot Games', 'Verenigde Staten') -- uitgever: Riot Games

insert into Games.Ontwikkelaar(id, naam, land)
values (5, 'Gearbox Software', 'Verenigde Staten') -- uitgever: 2K Games, Gearbox Publishing

insert into Games.Ontwikkelaar(id, naam, land)
values (6, 'Epic Games', 'Verenigde Staten') -- uitgever: Epic Games

insert into Games.Ontwikkelaar(id, naam, land)
values (7, 'FromSoftware', 'Japan') -- uitgever: verscheidene

insert into Games.Ontwikkelaar(id, naam, land)
values (8, 'Blizzard Entertainment', 'Verenigde Staten') -- uitgever: Blizzard Entertainment 

insert into Games.Ontwikkelaar(id, naam, land)
values (9, 'Ubisoft', 'Frankrijk') -- uitgever: Ubisoft

insert into Games.Ontwikkelaar(id, naam, land)
values (10, 'Naughty Dog', 'Verenigde Staten') -- uitgever: Sony Interactive Entertainment

insert into Games.Ontwikkelaar(id, naam, land)
values (11, 'Nintendo', 'Japan') -- uitgever: Nintendo

insert into Games.Ontwikkelaar(id, naam, land)
values (12, 'Square Enix', 'Verenigde Staten') -- uitgever: Square Enix 

insert into Games.Ontwikkelaar(id, naam, land)
values (13, 'SEGA', 'Japan') -- uitgever: SEGA

insert into Games.Ontwikkelaar(id, naam, land)
values (14, 'Bethesda Game Studios', 'Verenigde Staten') -- uitgever: Bethesda Softworks (onderdeel v. ZeniMax Media) 

insert into Games.Ontwikkelaar(id, naam, land)
values (15, 'Capcom', 'Japan') -- uitgever: Capcom

insert into Games.Ontwikkelaar(id, naam, land)
values (16, 'IO Interactive', 'Denemarken') -- uitgever: Io Interactive (en Square Enix)

insert into Games.Ontwikkelaar(id, naam, land)
values (17, 'Concerned Ape', 'Verenigde Staten') -- uitgever: Chucklefish

insert into Games.Ontwikkelaar(id, naam, land)
values (18, 'Bioware', 'Canada') -- uitgever: Electronic Arts (EA)

insert into Games.Ontwikkelaar(id, naam, land)
values (19, 'Respawn Entertainment', 'Verenigde Staten') -- uitgever: Electronic Arts (EA)

insert into Games.Ontwikkelaar(id, naam, land)
values (20, 'NetherRealm Studios', 'Verenigde Staten') -- uitgever: Warner Bros. Interactive Entertainment

INSERT into Games.Ontwikkelaar(id, naam, land)
values (21, 'Rockstar South (RS San Diego)', 'Verenigde Staten') -- 2de uitgever van 'Rockstar Games'

insert into Games.Ontwikkelaar(id, naam, land)
values (22, 'Re-Logic', 'Verenigde Staten') -- uitgever: 'Re-Logic'

insert into Games.Ontwikkelaar(id, naam, land)
values (23, 'Techland', 'Polen') -- uitgever: 'Techland'

insert into Games.Ontwikkelaar(id, naam, land)
values (24, 'Valve Corporation', 'Verenigde Staten') --uitgever: 'Valve'

insert into Games.Ontwikkelaar(id, naam, land)
values (25, 'Unknown Worlds Entertainment', 'Verenigde Staten') --uitgever: 'Unknown Worlds Ent.'

insert into Games.Ontwikkelaar(id, naam, land)
values(26, 'Behaviour Interactive', 'Canada') -- uitgever:'Behaviour Interactive'

insert into Games.Ontwikkelaar(id, naam, land)
VALUES(27, 'Maxis', 'Verenigde Staten') -- uitgever: 'EA'

INSERT into Games.Ontwikkelaar(id, naam, land)
values(28, 'Colossal Order', 'Finland') -- uitgever: 'Paradox Interactive'

INSERT into Games.Ontwikkelaar(id, naam, land)
values(29, 'Psyonix', 'Verenigde Staten') -- uitgever: Psyonix
set IDENTITY_INSERT Games.Ontwikkelaar off
go


--Games Uitgever--
set IDENTITY_INSERT Games.Uitgever on
insert into Games.Uitgever(id, naam, land)
values (1, 'Electronic Arts' , 'Verenigde Staten') -- uitgever van ontwikkelaar 'Respawn Entertainment', 'Bioware'

insert into Games.Uitgever(id, naam, land)
values (2, 'Square Enix', 'Verenigde Staten') -- uitgever van ontwikkelaar 'Square Enix', 'IO Interactive'

insert into Games.Uitgever(id, naam, land)
values (3, 'Verscheidene', 'Japan') -- uitgever van ontwikkelaar 'FromSoftware'

insert into Games.Uitgever(id, naam, land)
values (4, 'CD Projekt', 'Polen') -- uitgever van ontwikkelaar 'CD Projekt Red'

insert into Games.Uitgever(id, naam, land)
values (5, 'Epic Games', 'Verenigde Staten') -- uitgever van ontwikkelaar 'Epic Games'

insert into Games.Uitgever(id, naam, land)
values (6, 'Sony Interactive Entertainment', 'Verenigde Staten') --uitgever van ontwikkelaar 'Naughty Dog'

insert into Games.Uitgever(id, naam, land)
values (7, 'Capcom', 'Japan') -- uitgever van ontwikkelaar 'Capcom'

insert into Games.Uitgever(id, naam, land)
values (8, 'Rockstar Games', 'Verenigde Staten') -- uitgever van ontwikkelaar 'Rockstar North'

insert into Games.Uitgever(id, naam, land)
values (9, 'SEGA', 'Japan') -- uitgever van ontwikkelaar 'SEGA'

insert into Games.Uitgever(id, naam, land)
values (10, 'Blizzard Entertainment', 'Verenigde Staten') -- uitgever van ontwikkelaar 'Blizzard Entertainment'

insert into Games.Uitgever(id, naam, land)
values (11, 'Mojang Studios', 'Zweden') -- uitgever van ontwikkelaar 'Mojang Studios'

insert into Games.Uitgever(id, naam, land)
values (12, 'Nintendo', 'Japan') --uitgever van ontwikkelaar 'Nintendo'

insert into Games.Uitgever(id, naam, land)
values (13, 'Activision', 'Verenigde Staten') 

insert into Games.Uitgever(id, naam, land)
values (14, 'Io Interactive', 'Denemarken') -- uitgever van 'IO Interactive'

insert into Games.Uitgever(id, naam, land)
values (15, 'Ubisoft', 'Frankrijk') -- uitgever van 'Ubisoft'

insert into Games.Uitgever(id, naam, land)
values (16, 'Warner Bros. Interactive Entertainment', 'Verenigde Staten') -- uitgever van 'NetherRealm Studios'

insert into Games.Uitgever(id, naam, land)
values (17, '2K Games + Gearbox Publishing', 'Verenigde Staten') -- uitgever van 'Gearbox Software'

insert into Games.Uitgever(id, naam, land)
values (18, 'Riot Games', 'Verenigde Staten') -- uitgever van 'Riot Games'

insert into Games.Uitgever(id, naam, land)
values (19, 'Bethesda Softworks', 'Verenigde Staten') -- uitgever van 'Bethesda Game Studios'

insert into Games.Uitgever(id, naam, land)
values (20, 'Chucklefish', 'Verenigd Koninkrijk') -- uitgever van 'Concerned Ape'

insert into Games.Uitgever(id, naam, land)
VALUES (21, 'Techland', 'Polen') -- uitgever van ontwikkelaar 'Techland'

insert into Games.Uitgever(id, naam, land)
values (22, 'Re-Logic', 'Verenigde Staten') --  uitgever van ontwikkelaar 'Re-Logic'

insert into Games.Uitgever(id, naam, land)
values (23, 'Valve Corporation', 'Verenigde Staten') --uitgever van ontwikkelaar 'Valve'

insert into Games.Uitgever(id, naam, land)
values (24, 'Behaviour Interactive', 'Canada') --uitgever van ontwikkelaar 'Behaviour Interactive'

insert into Games.Uitgever(id, naam, land)
values (25, 'Unknown Worlds Entertainment', 'Verenigde Staten') --uitgever van ontwikkelaar 'Unknown Worlds Ent.'

insert into Games.Uitgever(id, naam, land)
VALUES (26, 'Paradox Interactive', 'Zweden') --uitgever van 'Colossal Order'

insert into Games.Uitgever(id, naam, land)
VALUES (27, 'Psyonix', 'Verenigde Staten') --uitgever van 'Psyonix'
set IDENTITY_INSERT Games.Uitgever off
go

--HardwareProducent--
set IDENTITY_INSERT Games.HardwareProducent on
insert into Games.HardwareProducent (id, naam, land)
values (1, 'AMD (Advanced Micro Devices)', 'Verenigde Staten')

insert into Games.HardwareProducent (id, naam, land)
values (2, 'NVIDIA', 'Verenigde Staten')

insert into Games.HardwareProducent (id, naam, land)
values (3, 'SteelSeries', 'Denemarken / Verenigde Staten')

insert into Games.HardwareProducent (id, naam, land)
values (4, 'Acer', 'Taiwan')

insert into Games.HardwareProducent (id, naam, land)
values (5, 'MSI (Micro-Star International)', 'Taiwan')

insert into Games.HardwareProducent (id, naam, land)
values (6, 'Razer', 'Singapore')

insert into Games.HardwareProducent (id, naam, land)
values (7, 'Corsair', 'Verenigde Staten')

insert into Games.HardwareProducent (id, naam, land)
values (8, 'ASUS', 'Taiwan')

insert into Games.HardwareProducent (id, naam, land)
values (9, 'Elgato', 'Duitsland')

insert into Games.HardwareProducent (id, naam, land)
values (10, 'HP', 'Verenigde Staten')

insert into Games.HardwareProducent (id, naam, land)
values (11, 'Microsoft', 'Verenigde Staten')

insert into Games.HardwareProducent(id, naam, land)
values (12, 'Logitech', 'Zwitserland')

insert into Games.HardwareProducent(id, naam, land)
values (13, 'HyperX', 'Verenigde Staten')

insert into Games.HardwareProducent(id, naam, land)
values (14, 'Lenovo Legion', 'China')

insert into Games.HardwareProducent(id, naam, land)
values (15, 'Thrustmaster', 'Frankrijk')

insert into Games.HardwareProducent(id, naam, land)
values (16, 'Alienware (Dell)', 'Verenigde Staten')

insert into Games.HardwareProducent(id, naam, land)
values (17, 'Nintendo', 'Japan')

insert into Games.HardwareProducent(id, naam, land)
values (18, 'Sony Interactive Entertainment', 'Japan')

insert into Games.HardwareProducent(id, naam, land)
values (19, 'BenQ', 'Taiwan')

insert into Games.HardwareProducent(id, naam, land)
values (20, 'Gebruiker van PC', 'hangt af van waar persoon is')

insert into Games.HardwareProducent(id, naam, land)
values (21, 'Atari', 'Frankrijk')

insert into Games.HardwareProducent(id, naam, land)
values (22, 'Google', 'Verenigde Staten')

insert into Games.HardwareProducent(id, naam, land)
values (23, 'SEGA', 'Japan')

insert into Games.HardwareProducent(id, naam, land)
values (24, 'Valve Corporation', 'Verenigde Staten')
set IDENTITY_INSERT Games.HardwareProducent off
go

--Games--
SET IDENTITY_INSERT Games.Game on
insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (1, 'Overwatch 2', 10, 8, 'Overwatch 2 is de opvolger van de populaire teamgebaseerde first-person shooter Overwatch. 
Het biedt een diverse cast van helden met unieke vaardigheden en introduceert een verhalende verhaalmodus naast de bekende competitieve multiplayermodus. 
Verbeterde graphics en nieuwe helden maken ook deel uit van het pakket. Spelers kunnen verwachten om samen te werken en te strijden in doelgerichte wedstrijden of 
het verhaal van het spel te verkennen in coöperatieve missies.', 12, 0.00, 12)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (2, 'Minecraft', 11, 3, 'Minecraft is een sandbox-game waarin spelers creatieve vrijheid hebben om te bouwen, 
verkennen en overleven in een blokkerige wereld. De game is een platform voor eindeloze creativiteit.', 7, 26.95, 12)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (3, 'Grand Theft Auto 5', 8, 1, 'Grand Theft Auto V is een open-wereld actieavontuur waarin je de fictieve stad Los Santos verkent. 
Je kunt deelnemen aan diverse activiteiten, van bankovervallen tot races, terwijl je de wereld van de misdaad betreedt', 18, 29.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (4, 'Cyberpunk 2077', 4, 2, 'Cyberpunk 2077 plaatst je in Night City, een futuristische stad, waar je de straten doorkruist als V, een huurling op zoek naar roem. 
Verken een open-wereld omgeving, maak keuzes die de loop van het verhaal beïnvloeden en ontrafel het mysterie van de stad.', 18, 49.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (5, 'The Last of Us Part II', 6, 10, 'The Last of Us Part II is een emotioneel en meeslepend actie-avontuur dat zich afspeelt in een post-apocalyptische wereld. 
Het volgt Ellie, een jonge vrouw, terwijl ze strijdt om te overleven en wraak zoekt in een gevaarlijke en meedogenloze omgeving.', 18, 39.99, 18)


insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (6, 'Stardew Valley', 20, 17, 'Stardew Valley is een ontspannende boerderijsimulator waar je gewassen verbouwt, dieren verzorgt en het dorpsleven verkent. 
Geniet van het beheren van je boerderij en het opbouwen van relaties in deze charmante game.', 7, 13.99, 7)


insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (7, 'Fallout 4', 19, 14, 'Fallout 4 is een open-wereld RPG die zich afspeelt in een post-apocalyptisch Boston. 
Je komt uit een kluis tevoorschijn in een woestenij en moet overleven, bouwen en keuzes maken die de toekomst van de Commonwealth beïnvloeden.', 18, 19.99, 18)


insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (8, 'League of Legends', 18, 4, 'League of Legends is een populaire multiplayer online battle arena (MOBA) waar teams van kampioenen tegen elkaar strijden. 
Strategische gameplay en teamwork zijn essentieel voor de overwinning.', 12, 0.00, 12)


insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (9, 'Resident Evil Village (Resident Evil 8)', 7, 15, 'Resident Evil Village is een survival-horrorspel dat het verhaal van Ethan Winters voortzet. 
Verken een mysterieus dorp en wordt geconfronteerd met angstaanjagende wezens en personages. Het spel heeft naast de "main game" ook een DLC, genaamd "Shadows of Rose", waarin je speelt als de dochter van het hoofdpersonage Ethan Winters, Rose Winters. 
Deze DLC speelt zich af na het verhaal van de main-game. Rose heeft rare en bizarre krachten, waardoor ze zo goed als onsterfelijk is. Tijdens de DLC ben je als Rose op zoek naar "The Purifying Crystal" die haar krachten kan genezen en doen verdwijnen.
Het verhaal van deze DLC speelt zich af in een nachtmerrie-achtige versie van het dorp, waar je als Ethan in de "main game" doorgaat als je speelt.', 18, 49.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (10, 'The Legend of Zelda: Breath of the Wild', 12, 11, 'The Legend of Zelda: Breath of the Wild is een actie-avonturenspel waarin je als Link een uitgestrekte wereld verkent, 
puzzels oplost en vecht tegen gevaarlijke wezens.', 12, 56.93, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (11, 'Star Wars: Jedi - Fallen Order', 1, 19, 'Star Wars: Jedi - Fallen Order is een actievolle game waarin je de rol van een jonge Jedi, Cal Kestis, 
op je neemt terwijl je probeert te overleven in het Star Wars-universum.', 16, 59.99, 16)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (12, 'Far Cry 5', 15, 9, 'Far Cry 5 is een first-person shooter die zich afspeelt in het fictieve Hope County, Montana. 
Je moet een gewelddadige religieuze sekte bestrijden en de stad redden.', 18, 59.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (13, 'Sekiro: Shadows Die Twice', 13, 7, 'Sekiro: Shadows Die Twice is een actiegame die zich afspeelt in het feodale Japan. 
Je speelt als een shinobi die wraak zoekt en neemt het op tegen krachtige vijanden.', 18, 59.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (14, 'Monster Hunter: World', 7, 15, 'Monster Hunter: World is een actie-RPG waarin je jaagt op gigantische monsters in een levendige, ademende wereld. 
Je kan ook samen werken met andere spelers om deze angstaanjagende wezens te verslaan.', 16, 29.99, 16)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (15, 'Mass Effect Legendary Edition', 1, 18, 'Mass Effect Legendary Edition bevat geremasterde versies van de epische sciencefiction-RPGs. 
Mass Effect, Mass Effect 2 en Mass Effect 3. Verken het universum, maak keuzes en vecht tegen buitenaardse bedreigingen.', 16, 59.99, 16)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (16, 'Borderlands 3', 17, 5, 'Borderlands 3 is een first-person shooter met een unieke grafische stijl en miljoenen wapencombinaties. 
Verken Pandora en andere werelden, verzamel buit en vecht tegen bizarre vijanden.', 18, 59.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (17, 'Mortal Kombat 11', 16, 20, 'Mortal Kombat 11 is een vechtspel met iconische personages en gewelddadige gevechten. 
Test je vechtvaardigheden in singleplayer of multiplayer gevechten.', 18, 49.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (18, 'Red Dead Redemption 2', 8, 21, 'Red Dead Redemption 2 is een epische open-wereld actie-avonturengame die zich afspeelt in het Wilde Westen. 
Verken de uitgestrekte omgeving, neem deel aan schietgevechten en beleef een meeslepend verhaal. De game heeft meerdere "Game Of The Year" awards op zijn naam staan, en is en blijft tot op de dag van vandaag, 
één van de populairste games die ooit gemaakt werden. Het spel is zo goed als 50 uur lang met een meeslepend verhaal met een adembenemende omgeving waar je zeker van versteld zal staan.', 16, 59.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (19, 'Dying Light', 21, 23, 'Dying Light is een first-person survival horror game met parkour-elementen. 
Overleef in een door zombies geteisterde stad en verken de gevaarlijke nacht.', 18, 29.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (20, 'Subnautica', 25, 25, 'Subnautica is een onderwateroverlevingsspel op een buitenaardse planeet. 
Verken de diepe oceanen, bouw onderwaterbasissen en overleef in een gevaarlijke omgeving.', 7, 19.99, 7)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (21, 'The Sims 4', 1, 27, 'The Sims 4 is een levenssimulatiegame waarin je virtuele personages creëert en hun levens beheert. 
Bouw huizen, ontwikkel relaties en volg hun verhalen. Je kan doen wat je wil in de game, van het spelen als een dakloze, tot een millionair, het kan allemaal!', 12, 0.00, 12)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (22, 'Bloodborne', 3, 7, 'Bloodborne is een action-RPG en souls-like game die bekend staat om zijn uitdagende gevechten en duistere sfeer. 
Verken de stad Yharnam en ontrafel een sinistere samenzwering.', 18, 12.99, 18)

insert into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (23, 'VALORANT', 18, 4, 'Valorant is een free-to-play tactische first-person shooter (FPS) ontwikkeld en uitgegeven door Riot Games, dezelfde studio achter League of Legends. De game is uitgebracht in 2020 en heeft sindsdien een enorme spelersbasis aangetrokken. 
Valorant combineert strategie, precisieschieten en vaardigheidsgebaseerde actie in een teamgebaseerde omgeving. In Valorant vormen twee teams van vijf spelers elk een team van "Agents," elk met unieke vaardigheden en rollen. Het doel van het spel varieert afhankelijk van de spelmodus, maar omvat vaak het plaatsen of onschadelijk maken van bommen, vergelijkbaar met Counter-Strike. 
Spelers moeten samenwerken, communiceren en strategische keuzes maken om te slagen. Wat Valorant onderscheidt, zijn de "Agent Abilities." Elke Agent heeft specifieke vaardigheden die variëren van aanvallen tot defensieve mogelijkheden en ondersteunende hulpmiddelen. 
Spelers moeten deze vaardigheden strategisch gebruiken om voordeel te behalen ten opzichte van hun tegenstanders.', 16, 0.00, 16)

INSERT into Games.Game(id, naam, uitgeverId, ontwikkelaarId, beschrijving, minimumLeeftijd, prijs, rating)
values (24, 'Rocket League', 27, 29, 'Rocket League combineert voetbal en raketauto-s in een snel, zeer competitief multiplayerspel. Scoor doelpunten en voer ongelooflijke luchtmanoeuvres uit in dit unieke sportspel.', 3, 0.00, 3)
SET IDENTITY_INSERT Games.Game off
go


--Genre Game
set IDENTITY_INSERT Games.GenreGame on
insert into Games.GenreGame (id, genreId, gameId)
values (1, 4, 18)

insert into Games.GenreGame (id, genreId, gameId)
values (2, 4, 3)

insert into Games.GenreGame (id, genreId, gameId)
values (3, 12, 8)

insert into Games.GenreGame (id, genreId, gameId)
values (4, 18, 21)

insert into Games.GenreGame (id, genreId, gameId)
values (5, 18, 6)

insert into Games.GenreGame (id, genreId, gameId)
values (6, 4, 2)

insert into Games.GenreGame (id, genreId, gameId)
values (7, 17, 1)

insert into Games.GenreGame (id, genreId, gameId)
values (8, 17, 24)

insert into Games.GenreGame (id, genreId, gameId)
values (9, 21, 17)

insert into Games.GenreGame (id, genreId, gameId)
values (10, 7, 9)

insert into Games.GenreGame (id, genreId, gameId)
values (11, 20, 24)

insert into Games.GenreGame (id, genreId, gameId)
values (12, 9, 7)

insert into Games.GenreGame (id, genreId, gameId)
values (13, 2, 7)

insert into Games.GenreGame (id, genreId, gameId)
values (14, 3, 23)

insert into Games.GenreGame (id, genreId, gameId)
values (15, 9, 23)

insert into Games.GenreGame (id, genreId, gameId)
values (16, 13, 20)

insert into Games.GenreGame (id, genreId, gameId)
values (17, 17, 16)

insert into Games.GenreGame (id, genreId, gameId)
values (18, 4, 4)

insert into Games.GenreGame (id, genreId, gameId)
values (19, 3, 11)

insert into Games.GenreGame (id, genreId, gameId)
values (20, 13, 9)

insert into Games.GenreGame (id, genreId, gameId)
values (21, 7, 19)

insert into Games.GenreGame (id, genreId, gameId)
values (22, 13, 13)

insert into Games.GenreGame (id, genreId, gameId)
values (23, 2, 5)

insert into Games.GenreGame(id, genreId, gameId)
values (24, 3, 5)
set IDENTITY_INSERT Games.GenreGame off
GO



--Platform--
set IDENTITY_INSERT Games.Platform on
insert into Games.Platform(id, naam, uitgaveJaar, specificaties, adviesprijs, producentId)
VALUES (1, 'Xbox Series X', 2020, 'CPU: Custom AMD Zen 2 Octa-core | GPU: Custom AMD RDNA 2 | RAM: 16GB | Opslagruimte: 1TB SSD | Resolutie: tot 8K', 549.99, 11),
       (2, 'Nintendo Switch', 2017, 'CPU: Custom NVIDIA Tegra | GPU: Custom NVIDIA Tegra | RAM: 4GB | Opslagruimte: 32GB (uitbreidbaar) | Resolutie: tot 720p (handheld), tot 1080p (in tv modus)', 299.99, 17),
       (3, 'PC', 2023, 'CPU: Intel Core I of AMD Ryzen | GPU: Nvidia GeForce RTX/GTX of AMD Radeon Graphics of Intel Graphics | RAM: 4-128GB | Opslagruimte: 128GB-1TB SSD en/of 500GB-2TB HDD | Resolutie: te kiezen doorgebruiker', 2000.00, 20),
       (4, 'Nintendo 3DS', 2011, 'CPU: Custom ARM11 en ARM9 | GPU: PICA200 | RAM: 128MB | Opslagruimte: 2-4GB | Resolutie: 800x240 (Bovenscherm) en 320x240 (Onderste scherm)', 169.99, 17),
       (5, 'Playstation 5', 2020, 'CPU: Custom AMD Zen 2 Octa-Core | GPU: Custom AMD RDNA 2 | RAM: 16GB | Opslagruimte: 825 GB SSD | Resolutie: tot 8K', 549.00, 18),
       (6, 'Atari VCS', 2020, 'CPU: AMD Ryzen APU | GPU: AMD Radeon Vega | RAM: 8GB | Opslagruimte: 32GB | Resolutie: tot 4K', 390.00, 21),
       (7, 'Google Stadia (Cloud Gaming Platform)', 2019, 'Afhankelijk van de hardware van de serverfarmen van Google --> geen lokale console (gaming in de cloud)', 0.00, 22),
       (8, 'Sega Genesis Mini', 2019, 'Vooraf geladen Sega Genesis-spellen | 720p HD-uitvoer via HDMI | Inclusief 2 bedrade controllers', 110.00, 23),
       (9, 'HP OMEN', 2023, 'Specificaties zijn afhankelijk van het model | Aanpasbare configuraties', 4499.00, 10),
       (10, 'Alienware', 2023, 'Specificaties zijn afhankelijk van het model | Aanpasbare configuraties', 1349.00, 16),
       (11, 'Acer Predator', 2023, 'Specificaties zijn afhankelijk van het model | Aanpasbare configuraties', 1558.00, 4),
       (12, 'Razer Blade', 2023, 'Specificaties zijn afhankelijk van het model | Aanpasbare configuraties', 2500.00, 6),
       (13, 'Nvidia Shield TV', 2015, 'CPU: Nvidia Tegra X1 | GPU: Nvidia Maxwell | RAM: 3GB | Opslagruimte: 16GB (verschillende modellen beschikbaar) | Besturingssysteem: Android TV', 247.70, 2),
       (14, 'ASUS ROG (Republic of Gamers)', 2023, 'Diverse gaming-pc(s), laptops, monitoren en randapparatuur met AMD- en Nvidia componenten. | Aanpasbare configuraties', 899.00, 8),
       (15, 'Alienware Aurora R11 Gaming Desktop', 2023, 'Gaming desktops met Intel CPUs en Nvidia GPUs, waaronder de mogelijkheid om Nvidia GeForce RTX-serie kaarten te configureren | Aanpasbare configuraties', 2199.00, 16),
       (16, 'ROG Zephyrus Gaming Laptops', 2023, 'Gaming-laptops met krachtige AMD Ryzen- of Intel CPUs en Nvidia GeForce GPUs. | Aanpasbare configuraties', 3000.00, 8),
       (17, 'Nintendo GameCube', 2001, 'CPU: IBM PowerPC Gekko | GPU: ATI Hollywood | RAM: 40MB | Opslagruimte: 128MB | Scherm: ondersteunde 480p-resolutie', 100.00, 17),
       (18, 'Sony Playstation Portable (PSP)', 2004, 'CPU: MIPS R4000 | GPU: Sony GPU | RAM: 32MB | Opslagruimte: 16GB - 32GB (bij uitbreiding) | Scherm: 4,3 inch (480x272 pixels)', 180.00, 18),
       (19, 'Sega Dreamcast', 1999, 'CPU: Hitachi SH-4 | GPU: PowerVR Series 2 | RAM: 16MB | Opslagruimte: Dataopslag van 128kB | Scherm: ondersteunde 480p-resolutie', 199.00, 23), 
       (20, 'Steam Deck (Handheld Gaming PC)', 2022, 'Aangepaste AMU (CPU/GPU) van AMD | RAM: 16GB | Opslagruimte: 64GB eMMC (andere configuraties mogelijk) | Scherm: 7-inch touchscreen-display', 799.00, 24),
       (21, 'Atari 2600', 1977, 'CPU: MOS Technology 6507 | GPU: Atari TIA | RAM: 128 bytes | Opslagruimte: 4-64KB | Scherm: ondersteunde 160x192 resolutie', 380.00, 21),
       (22, 'Sega Saturn', 1994, 'CPU: Hitachi SH-2 (2x) | GPU: VDP1 en VDP2 | RAM: 2MB | Opslagruimte: 680MB | Scherm: ondersteunde 320x224 (NTSC)', 399.00, 23),
       (23, 'Xbox One', 2013, 'CPU: 8 Core AMD custom | GPU: AMD Radeon RX 560 of Nvidia GeForce GTX 750 | RAM: 8GB | Opslagruimte: 500GB HDD (externe harde schijf mogelijk) | Resolutie: 1080p en 720p', 539.00, 11),
       (24, 'Playstation 4', 2013, 'CPU: AMD Jaguar Octa-core | GPU: AMD Radeon based graphics card | RAM: 8GB | Opslagruimte: 500GB, 1TB | Resolutie: 2160p tot 4K ', 399.00, 18);
set IDENTITY_INSERT Games.Platform off
go

--GamePlatform
        --omdat meerdere games op meerder platformen speelbaar zijn, staat er hieronder bij de platformId maar 1 platform waarop de game te spelen is.
set IDENTITY_INSERT Games.GamePlatform on
insert into Games.GamePlatform(id, gameId, platformId)
values (1, 18, 3),
       (2, 21, 23),
       (3, 21, 5),
       (4, 19, 23),
       (5, 6, 3),
       (6, 10, 2),
       (7, 1, 1),
       (8, 3, 23),
       (9, 17, 5),
       (10, 16, 3),
       (11, 13, 7),
       (12, 9, 24),
       (13, 7, 24),
       (14, 5, 23),
       (15, 8, 3),
       (16, 4, 1),
       (17, 23, 2),
       (18, 22, 24),
       (19, 2, 23),
       (20, 11, 5),
       (21, 12, 7),
       (22, 14, 3),
       (23, 15, 1),
       (24, 24, 24),
       (25, 20, 2);
set IDENTITY_INSERT Games.GamePlatform off
go




