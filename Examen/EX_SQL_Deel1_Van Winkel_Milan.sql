-- Originele versie:
CREATE TABLE Dieren.Insect
(
    id int IDENTITY(1,1),
    soortId int NOT NULL DEFAULT '1',
    titel varchar(45) NOT NULL,
    CONSTRAINT FK_Dier_Insect PRIMARY KEY (id)
);

INSER INTO Insect.Dieren (id, soortId, titel) VALUES (1, 1, 'Honingbij')
INSER INTO Insect.Dieren (id, soortId, titel) VALUES (2, NULL, 'Wesp');


-- Verbeterde versie:
CREATE TABLE Dieren.Insect
(
    id int IDENTITY(1,1),
    soortId int NOT NULL DEFAULT '1',
    titel varchar(45) NOT NULL,
    CONSTRAINT FK_Dier_Insect PRIMARY KEY (id)
);

INSERT INTO Insect.Dieren (id, soortId, titel) VALUES (1, 1, 'Honingbij')
INSERT INTO Insect.Dieren (id, soortId, titel) VALUES (2, NULL, 'Wesp');
/* Bij de inserts zijn hier 2 'T's aan toegevoegd, waardoor de query kan werken en uitgevoerd worden */

