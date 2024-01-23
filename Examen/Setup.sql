/*
	Belangrijk: Het examenreglement is hier van toepassing.
	Dit bestand is een onderdeel van het examen van Database Essentials (SQL)
	Het is verboden dit te verspreiden. Elke (poging tot) inbreuk kan gerapporteerd worden aan de examencommissie. 
*/
/*
	Database generatie: Woonzorgcentrum Rustvliet
*/
-- Wissen tabellen + schema indien bestaan --
DROP TABLE IF EXISTS WZC.Uitleen;
DROP TABLE IF EXISTS WZC.PersoneelsAfdeling;
DROP TABLE IF EXISTS WZC.Kamer;
DROP TABLE IF EXISTS WZC.Afdeling;
DROP TABLE IF EXISTS WZC.Personeel;
DROP TABLE IF EXISTS WZC.Bewoner;
DROP TABLE IF EXISTS WZC.Boek;
GO
DROP SCHEMA IF EXISTS WZC;
GO
CREATE SCHEMA WZC;
GO
-- Aanmaken tabellen --
CREATE TABLE WZC.Bewoner (
    id 		 		int IDENTITY(1,1),
    voornaam 		varchar(100) 	NOT NULL,
    achternaam 		varchar(100) 	NOT NULL,
    geboortedatum 	DATE 			NOT NULL,
	CONSTRAINT PK_Bewoner PRIMARY KEY (id)
);
GO
CREATE TABLE WZC.Personeel (
    id 			int IDENTITY(1,1),
    voornaam 	varchar(255)	NOT NULL,
    achternaam 	varchar(255)	NOT NULL,
    functie 	varchar(255),
    salaris 	DECIMAL(10, 2),
    inDienstSinds  DATE NOT NULL,
	uitDienstSinds DATE DEFAULT NULL,
	CONSTRAINT PK_Personeel PRIMARY KEY (id)
);
GO
CREATE TABLE WZC.Afdeling (
    id int IDENTITY(1,1),
    titel varchar (40) NOT NULL,
    capaciteit int,
	supervisor int NOT NULL,
	CONSTRAINT PK_Afdeling PRIMARY KEY (id),
	CONSTRAINT FK_Afdeling_Personeel FOREIGN KEY (supervisor) REFERENCES WZC.Personeel (id)
);
GO
CREATE TABLE WZC.Kamer (
    id int			IDENTITY(1,1),
    kamernummer 	varchar(15),
	prijs			money,
    soort			varchar(125),
	bewonerId		int,
	afdelingsId		int,
	CONSTRAINT PK_Kamer PRIMARY KEY (id),
    CONSTRAINT FK_Kamer_Bewoner FOREIGN KEY (bewonerId) REFERENCES WZC.Bewoner(id),
	CONSTRAINT FK_Kamer_Afdeling FOREIGN KEY (afdelingsId) REFERENCES WZC.Afdeling (id)
);
GO
CREATE TABLE WZC.PersoneelsAfdeling (
    id int IDENTITY(1,1),
	personeelId int NOT NULL,
	afdelingsId int NOT NULL,
	CONSTRAINT PK_PersoneelsAfdeling PRIMARY KEY (id),
	CONSTRAINT FK_PersoneelsAfdeling_Personeel FOREIGN KEY (personeelId) REFERENCES WZC.Personeel (id),
	CONSTRAINT FK_PersoneelsAfdeling_Afdeling FOREIGN KEY (afdelingsId) REFERENCES WZC.Afdeling (id),
);
GO
CREATE TABLE WZC.Boek (
    id int IDENTITY(1,1),
    titel varchar(120) NOT NULL,
    publicatiedatum DATE NOT NULL,
	CONSTRAINT PK_Boek PRIMARY KEY (id)
);
GO
CREATE TABLE WZC.Uitleen (
    id int IDENTITY(1,1),
    bewonerId int,
    boekId int,
    uitleendatum DATE,
	CONSTRAINT PK_Uitleen PRIMARY KEY (id),
    CONSTRAINT FK_Uitleen_Bewoner FOREIGN KEY (BewonerId) REFERENCES WZC.Bewoner(id),
    CONSTRAINT FK_Uitleen_Boek FOREIGN KEY (BoekId) REFERENCES WZC.Boek(id)
);
GO
-- Gegevens invoegen in tabellen --
INSERT INTO WZC.Bewoner (voornaam, achternaam, geboortedatum)
VALUES
    ('Anna', 'Jansen', '1935-04-10'),
    ('Piet', 'de Vries', '1940-07-22'),
    ('Maria', 'Bakker', '1945-02-18'),
    ('Zuster Irene', 'Van Hoof', '1904-02-18'),
    ('Sjakie', 'Wijsrecht', '1942-01-01'),
	('Bertha', 'Isacsson', '1946-01-15'),
	('Grace', 'Bourthoumieux', '1948-07-06'),
	('Cesaro', 'Jaumet', '1931-03-22'),
	('Melicent', 'Kem', '1946-05-15'),
	('Niels', 'Michele', '1935-04-30'),
	('Elliot', 'Batey', '1957-01-04'),
	('Lem', 'Arnatt', '1950-09-19'),
	('Perry', 'Colbert', '1953-10-26'),
	('Dela', 'Sokell', '1941-03-03'),
	('Alyson', 'Bostock', '1958-04-18'),
	('Ramona', 'Michallat', '1950-06-12'),
	('Malia', 'Doody', '1946-06-02'),
	('Charyl', 'Berntssen', '1955-12-10'),
	('Haleigh', 'Finch', '1946-08-25'),
	('Silva', 'Bapty', '1927-07-19'),
	('Edeline', 'Bowes', '1930-09-06'),
	('Tadeo', 'Pescott', '1932-09-13'),
	('Randi', 'Cope', '1937-06-16'),
	('Clemmie', 'Prosek', '1960-04-24'),
	('Levin', 'Pennetta', '1953-01-09'),
	('Mack', 'Utridge', '1957-11-19'),
	('Bernadene', 'McCullagh', '1948-07-25'),
	('Thomasina', 'Clayfield', '1928-07-07'),
	('Myles', 'McGrorty', '1962-04-16'),
	('Manfred', 'Pendergast', '1945-06-16'),
	('Doria', 'Bundy', '1924-05-05'),
	('Hephzibah', 'Ginni', '1935-10-25'),
	('Porty', 'Wingate', '1962-02-18'),
	('Jamaal', 'Mordacai', '1954-11-11'),
	('Roxana', 'Bavister', '1935-04-30'),
	('Anabel', 'McDonogh', '1952-06-26'),
	('Eustace', 'Sopp', '1949-09-23'),
	('Nesta', 'Redgrave', '1951-01-30'),
	('Vi', 'Snarr', '1962-07-04'),
	('Ban', 'Sunter', '1956-09-06'),
	('Camila', 'Masterton', '1936-07-03'),
	('Tawnya', 'Hub', '1931-07-13'),
	('Thorndike', 'Fleischmann', '1935-01-18'),
	('Sanders', 'Siret', '1938-11-16'),
	('Giorgi', 'Pietrzyk', '1928-11-27'),
	('Curcio', 'Schoales', '1923-01-02'),
	('Tatum', 'Beddo', '1921-12-31'),
	('Eustace', 'Lube', '1931-04-06'),
	('Karen', 'Fredi', '1956-02-17'),
	('Jedd', 'Laverenz', '1962-09-09'),
	('Merola', 'Shirrell', '1941-09-10'),
	('Barby', 'Trent', '1955-12-30'),
	('Kingston', 'Serrels', '1958-09-15'),
	('Norry', 'Catterson', '1946-12-19'),
	('Dael', 'McGirl', '1922-12-11'),
	('Dolly', 'Sarll', '1929-04-19'),
	('Adda', 'Labuschagne', '1951-08-10'),
	('Danna', 'Reddel', '1950-09-28'),
	('Hedvige', 'Evamy', '1928-07-20'),
	('Yorgos', 'Bertolin', '1947-10-14'),
	('Roma', 'O''Doghesty', '1926-04-25'),
	('Nikaniki', 'Kingswell', '1943-01-23'),
	('Dario', 'Lemanu', '1945-04-13'),
	('Itch', 'Kadar', '1957-03-12'),
	('Elene', 'Locard', '1938-02-25'),
	('Arlyne', 'Harrowing', '1961-05-16'),
	('Seth', 'Pirouet', '1952-07-07'),
	('Brynn', 'Gabala', '1949-11-21'),
	('Russ', 'Simmig', '1933-05-12'),
	('Charmain', 'Poppleton', '1953-06-13'),
	('Jerad', 'Cruxton', '1942-11-09'),
	('Arley', 'Yude', '1961-10-12'),
	('Andi', 'Skeermer', '1950-05-26'),
	('Giorgi', 'Curd', '1960-03-31'),
	('Jo-anne', 'Hearsey', '1959-07-25'),
	('Cyndia', 'Shawley', '1934-02-19'),
	('Udell', 'Hendrick', '1948-12-24'),
	('Karisa', 'Orneblow', '1934-06-02'),
	('Daveen', 'Woodvine', '1948-10-05'),
	('Charisse', 'Freeborne', '1931-06-30'),
	('Zacharie', 'Tomaszczyk', '1929-07-02'),
	('Adaline', 'Kahan', '1931-03-31'),
	('Mathilda', 'Banaszczyk', '1923-11-15'),
	('Jacquelyn', 'Reaney', '1955-12-17'),
	('Binnie', 'Towne', '1930-08-20'),
	('Bearnard', 'Mersey', '1928-10-24'),
	('Oriana', 'Chadband', '1952-10-10'),
	('Artemas', 'Baume', '1925-08-17'),
	('Amby', 'Benitez', '1929-12-28'),
	('Freddy', 'Berston', '1942-09-09'),
	('Aurore', 'McQuillen', '1940-08-28'),
	('Maryjo', 'Grimstead', '1956-06-19'),
	('Sylas', 'Pellatt', '1931-02-13'),
	('Garnette', 'Fere', '1925-12-11'),
	('Lona', 'Forrest', '1953-11-19'),
	('Wernher', 'Franssen', '1959-01-14'),
	('Aigneis', 'Krahl', '1926-05-22'),
	('Tybie', 'Ferneley', '1943-12-26'),
	('Petrina', 'Hollyland', '1928-08-26'),
	('Madel', 'Van Driel', '1941-09-23'),
	('Burke', 'Clarage', '1945-12-22'),
	('Seth', 'Odams', '1923-11-11'),
	('Jobey', 'Culshaw', '1925-03-03'),
	('Guthrie', 'Buy', '1924-03-24'),
	('Gilli', 'Domini', '1940-10-09');

INSERT INTO WZC.Personeel (voornaam, achternaam, functie, salaris, inDienstSinds)
VALUES
    ('Marianne', 'Bos', 'DI', 6500.00, '2002-08-13'),
	('Tessy', 'Dijsselster', 'DI', 6200.4, '2023-10-10'),
    ('Erik', 'Hendriks', 'VP', 2285.00, '2008-04-28'),
    ('Lisa', 'Meijer', 'ADP', 2200.00, '2008-04-28'),
	('Hanna', 'Pieters', 'VP', 2342.43, '2008-09-22'),
	('Ricardo', 'Pieters', 'VP', 2285.00, '2008-03-20'),
	('Ulla', 'Tucsell', 'VP', 5.57, '2017-02-18'),
	('Curry', 'Le Provest', 'VP', 0.22, '2010-12-05'),
	('Hieronymus', 'Sam', 'VP', 0.69, '2009-11-26'),
	('Almeria', 'Blankley', 'VP', 9.90, '2008-02-29'),
	('Ailbert', 'Pessold', 'VP', 4.31, '2022-07-16'),
	('Monty', 'Massei', 'VP', 8.39, '2013-02-12'),
	('Stu', 'Pulfer', 'ADP', 4.41, '2013-07-08'),
	('Priscella', 'Oxley', 'VP', 7.45, '2007-11-16'),
	('Mureil', 'Cable', 'VP', 9.07, '2009-09-21'),
	('Raychel', 'Hovey', 'ADP', 5.35, '2021-04-23'),
	('Mahala', 'Eskrigg', 'ADP', 5.43, '2022-01-02'),
	('Elias', 'Simonnin', 'ADP', 6.21, '2016-01-17'),
	('Berkley', 'Hanniger', 'VP',3.79, '2007-04-04'),
	('Tull', 'Tilliard', 'VP', 7.14, '2008-09-05'),
	('Marion', 'Hymas', 'VP', 5.70, '2016-12-27'),
	('Dur', 'Van den Broek', 'VP', 4.84, '2004-02-10'),
	('Rossy', 'Abramowitch', 'VP', 8.13, '2017-01-27'),
	('Ado', 'Sigge', 'ADP', 2.15, '2020-08-21'),
	('Rubi', 'Daughtrey', 'ADP', 3.30, '2016-07-24'),
	('Lauryn', 'Pipes', 'VP', 1.51, '2010-04-11');

INSERT INTO WZC.Afdeling (titel, capaciteit, supervisor)
VALUES 
    ('Zusters en paters op rust', 60, 6),
	('Zachtwintersdreef', 40, 3),
	('Gesloten afdeling', 14, 5),
	('Serviceflats', 58, 8);
	
INSERT INTO WZC.Kamer (prijs, soort, afdelingsId, bewonerId)
VALUES
    ('€400', 'Tweepersoonskamer', 4, 1),
    ('€1000', 'Eenpersoonskamer', 4, 2),
    ('€2', 'Tweepersoonskamer', 2, 3),
	(NULL, 'Eenpersoonskamer', 1, 4), /* Zusters: vrijstelling kosten */
	('€2', 'Tweepersoonskamer', 2, NULL),
	('€524,98', 'Tweepersoonskamer', NULL, 7),
	(null, 'Eenpersoonskamer', 1, 4),          /* Nog .. */
	(null, 'Tweepersoonskamer', 4, 14),			/* Nog .. */
	('€1842,21', 'Eenpersoonskamer', 4, 33),
	('€1858,39', 'Tweepersoonskamer', 1, 6),
	('€1040,15', 'Tweepersoonskamer', 2, 25),
	('€1773,30', 'Tweepersoonskamer', 3, 20),
	('€1133,62', 'Eenpersoonskamer', 2, 41),
	('€2113,81', 'Tweepersoonskamer', 2, 32),
	('€955,81', 'Eenpersoonskamer', 4, 29),
	('€1857,73', 'Tweepersoonskamer', 1, 8),
	('€1336,84', 'Eenpersoonskamer', 3, 13),
	('€376,30', 'Tweepersoonskamer', 2, 23),
	('€1539,48', 'Tweepersoonskamer', 4, 31),
	('€1669,39', 'Tweepersoonskamer', 4, 17),
	('€1677,49', 'Eenpersoonskamer', 4, 11),
	('€1546,98', 'Tweepersoonskamer', 2, 16),
	('€1295,74', 'Tweepersoonskamer', 1, 28),
	('€2161,75', 'Tweepersoonskamer', 4, 37),
	('€985,71', 'Tweepersoonskamer', NULL, 9),
	('€2230,21', 'Tweepersoonskamer', 1, 45),
	('€895,20', 'Eenpersoonskamer', 4, 21),
	('€1052,71', 'Eenpersoonskamer', 3, 18),
	('€1116,64', 'Tweepersoonskamer', 4, 30),
	('€1603,11', 'Tweepersoonskamer', 2, 21),
	('€1079,65', 'Tweepersoonskamer', 3, 48),
	('€2238,81', 'Tweepersoonskamer', 2, 10),
	('€1968,14', 'Eenpersoonskamer', 3, 24),
	('€748,42', 'Eenpersoonskamer', 2, 32),
	('€779,34', 'Eenpersoonskamer', 1, 38),
	('€630,47', 'Tweepersoonskamer', 1, 34),
	('€2051,47', 'Eenpersoonskamer', 1, 42),
	('€523,61', 'Tweepersoonskamer', 1, 41),
	('€2235,59', 'Tweepersoonskamer', 1, 47),
	('€2012,56', 'Eenpersoonskamer', 3, 50);

-- Kamers nummeren op basis van id
UPDATE WZC.Kamer SET kamernummer = 'KN' + CAST(id AS varchar) + '';

-- 
UPDATE WZC.Kamer SET kamernummer = NULL WHERE id = 17;

-- AK voor kamernr
GO
CREATE UNIQUE INDEX AK_Kamernr ON WZC.Kamer (kamernummer);
GO
	
INSERT INTO WZC.Boek (titel, publicatiedatum)
VALUES
    ('1984', '1949-06-08'),
    ('Animal Farm', '1945-08-17'),
    ('Pride and Prejudice', '1813-01-28'),
    ('Harry Potter and the Philosopher''s Stone', '1997-06-26'),
    ('Romeo and Juliet', '1597-01-20'),
    ('Murder on the Orient Express', '1934-01-01'),
    ('The Adventures of Huckleberry Finn', '1884-12-10'),
    ('Great Expectations', '1861-12-31'),
    ('Wuthering Heights', '1847-12-19'),
    ('The Great Gatsby', '1925-04-10'),
    ('To Kill a Mockingbird', '1960-07-11');

INSERT INTO WZC.Uitleen (bewonerId, boekId, uitleendatum) 
VALUES
	(58, 4, '2023-06-27'),
	(59, 6, '2023-08-03'),
	(4, 9, '2023-02-17'),
	(97, 1, '2022-12-26'),
	(56, 5, '2023-12-10'),
	(58, 10, '2022-12-09'),
	(50, 1, '2023-08-08'),
	(6, 7, '2023-10-26'),
	(56, 5, '2023-08-23'),
	(51, 5, '2023-03-23'),
	(72, 1, '2023-11-13'),
	(14, 6, '2023-10-19'),
	(58, 1, '2023-08-07'),
	(80, 11, '2023-09-06'),
	(4, 2, '2023-07-31'),
	(58, 6, '2023-05-08'),
	(31, 10, '2023-03-10'),
	(58, 5, '2023-05-30'),
	(84, 6, '2023-10-14'),
	(94, 5, '2023-04-08'),
	(38, 5, '2023-11-14'),
	(58, 8, '2023-11-08'),
	(58, 2, '2023-03-04'),
	(76, 1, '2023-08-30'),
	(9, 5, '2023-01-25'),
	(86, 10, '2023-12-18'),
	(58, 9, '2023-05-09'),
	(58, 3, '2023-05-05');

INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (6, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (20, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (7, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (19, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (9, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (10, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (11, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (9, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (12, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (3, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (1, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (5, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (5, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (14, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (2, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (15, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (12, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (3, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (16, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (13, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (15, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (1, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (11, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (14, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (19, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (20, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (18, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (3, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (4, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (13, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (12, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (13, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (2, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (5, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (16, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (16, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (16, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (1, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (8, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (8, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (6, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (17, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (13, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (9, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (6, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (11, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (6, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (8, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (19, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (5, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (7, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (8, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (18, 1);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (9, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (12, 4);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (11, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (4, 3);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (2, 2);
INSERT WZC.PersoneelsAfdeling (personeelId, afdelingsId) VALUES (14, 1);