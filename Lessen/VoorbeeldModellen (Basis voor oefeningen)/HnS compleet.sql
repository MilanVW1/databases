-- Verwijder alle bestaande tabellen in het HnS schema als dit al bestaat.

DROP TABLE IF EXISTS HnS.Orderlijn;
DROP TABLE IF EXISTS HnS.[Order];
DROP TABLE IF EXISTS HnS.Product;
DROP TABLE IF EXISTS HnS.Categorie;
DROP TABLE IF EXISTS HnS.NieuwsbriefKlant;
DROP TABLE IF EXISTS HnS.Nieuwsbrief;
DROP TABLE IF EXISTS HnS.Klant;

DROP SCHEMA IF EXISTS HnS;
GO

-- creatie schema HnS
CREATE SCHEMA HnS;
GO

-- Tabellen van H&S
-- Creëren tabellen
-- creatie tabel Categorie --
CREATE TABLE HnS.Categorie
(
    id   int IDENTITY (1,1),
    naam varchar(50) NOT NULL,
    CONSTRAINT PK_Categorie
        PRIMARY KEY (id)
);

-- creatie tabel Product --
CREATE TABLE HnS.Product
(
    id                   int,
    categorieId          int           NOT NULL,
    naam                 varchar(100)  NOT NULL,
    inkoopprijs          money         NULL,
    verkoopprijs         money         NULL,
    btwPercentage        numeric(6, 2) NOT NULL,
    eenhedenInVoorraad   int           NOT NULL,
    eenhedenInBestelling int           NOT NULL,
    bestellingsniveau    int           NOT NULL,
    stopgezet            smallint      NOT NULL,
    inCatalogus          date          NULL,
    CONSTRAINT PK_Product
        PRIMARY KEY (id),
    CONSTRAINT FK_Product_Categorie
        FOREIGN KEY (categorieId)
            REFERENCES HnS.Categorie (id)
);

-- creatie tabel Klant --
CREATE TABLE HnS.Klant
(
    id          int,
    familienaam varchar(50) NOT NULL,
    voornaam    varchar(50),
    straat      varchar(50),
    postcode    varchar(4),
    gemeente    varchar(50),
    telefoon    varchar(20),
    gsm         varchar(20),
    email       varchar(50),
    CONSTRAINT PK_Klant
        PRIMARY KEY (id)
);

-- creatie tabel Nieuwsbrief --
CREATE TABLE HnS.Nieuwsbrief
(
    id           int,
    omschrijving varchar(100),
    CONSTRAINT PK_Nieuwsbrief
        PRIMARY KEY (id)
);

-- creatie tabel Nieuwsbrief --
CREATE TABLE HnS.NieuwsbriefKlant
(
    id            int IDENTITY (1,1),
    nieuwsbriefId int NOT NULL,
    klantId       int NOT NULL,
    CONSTRAINT PK_NieuwsbriefKlant
        PRIMARY KEY (id),
    CONSTRAINT FK_NieuwsbriefKlant_Nieuwsbrief
        FOREIGN KEY (nieuwsbriefId)
            REFERENCES HnS.Nieuwsbrief (id)
            ON DELETE CASCADE,
    CONSTRAINT FK_NieuwsbriefKlant_Klant
        FOREIGN KEY (klantId)
            REFERENCES HnS.Klant (id),

);

CREATE UNIQUE INDEX AK_NieuwsbriefKlant_nieuwsbriefId_klantId
    ON Hns.NieuwsbriefKlant (nieuwsbriefid, klantId);

-- creatie tabel Order --
CREATE TABLE HnS.[Order]
(
    id             int,
    klantId        int  NOT NULL,
    orderdatum     date NOT NULL,
    leveringsdatum date,
    CONSTRAINT PK_Order
        PRIMARY KEY (id),
    CONSTRAINT FK_Order_Klant
        FOREIGN KEY (klantId)
            REFERENCES HnS.Klant (id)
);

-- creatie tabel Orderlijn --
CREATE TABLE HnS.Orderlijn
(
    id            int IDENTITY (1,1),
    orderId       int           NOT NULL,
    productId     int           NOT NULL,
    verkoopprijs  money         NOT NULL,
    btwPercentage numeric(6, 2) NOT NULL,
    hoeveelheid   smallint      NOT NULL,
    korting       smallint      NULL,
    CONSTRAINT PK_Orderlijn
        PRIMARY KEY (id),
    CONSTRAINT UK_Orderlijn
        UNIQUE (orderId, productId),
    CONSTRAINT FK_Orderlijn_Order
        FOREIGN KEY (orderId)
            REFERENCES HnS.[Order] (id)
            ON DELETE CASCADE,
    CONSTRAINT FK_Orderlijn_Product
        FOREIGN KEY (productId)
            REFERENCES HnS.Product (id)
);

-- Opvullen Categorieën
INSERT INTO HnS.Categorie (naam)
VALUES ('Printers (inkjet)');
INSERT INTO HnS.Categorie (naam)
VALUES ('Printers (laser)');
INSERT INTO HnS.Categorie (naam)
VALUES ('Monitoren');
INSERT INTO HnS.Categorie (naam)
VALUES ('Software');
INSERT INTO HnS.Categorie (naam)
VALUES ('Moederbord');
INSERT INTO HnS.Categorie (naam)
VALUES ('Smartphone');
INSERT INTO HnS.Categorie (naam)
VALUES ('Grafische kaart');
INSERT INTO HnS.Categorie (naam)
VALUES ('Digitale camera');
INSERT INTO HnS.Categorie (naam)
VALUES ('Pocket pc');
INSERT INTO HnS.Categorie (naam)
VALUES ('Palm-PDA');
INSERT INTO HnS.Categorie (naam)
VALUES ('WLAN-sets/-access points');
INSERT INTO HnS.Categorie (naam)
VALUES ('Printers (foto''s)');
INSERT INTO HnS.Categorie (naam)
VALUES ('Processoren');
INSERT INTO HnS.Categorie (naam)
VALUES ('Geheugen');
INSERT INTO HnS.Categorie (naam)
VALUES ('Modems');
INSERT INTO HnS.Categorie (naam)
VALUES ('Computerkast');
INSERT INTO HnS.Categorie (naam)
VALUES ('Voeding');
INSERT INTO HnS.Categorie (naam)
VALUES ('Toetsenbord');
INSERT INTO HnS.Categorie (naam)
VALUES ('Muis');
INSERT INTO HnS.Categorie (naam)
VALUES ('Multimedia');
INSERT INTO HnS.Categorie (naam)
VALUES ('Scanner');
INSERT INTO HnS.Categorie (naam)
VALUES ('Harde schijf');
INSERT INTO HnS.Categorie (naam)
VALUES ('Geluidskaart');
INSERT INTO HnS.Categorie (naam)
VALUES ('Speakers');
INSERT INTO HnS.Categorie (naam)
VALUES ('Cd-rom, DVD');

-- Opvullen Product
INSERT INTO HnS.Product
VALUES (1, 1, 'HP DesignJet 110 Plus', 885.00, 985.00, 21.00, 5, 0, 3, 0, '2016-08-02');
INSERT INTO HnS.Product
VALUES (2, 1, 'HP DeskJet 6940', 80.00, 98.00, 21.00, 2, 3, 3, 0, '2016-08-02');
INSERT INTO HnS.Product
VALUES (4, 1, 'HP Business Inkjet 1000', 100.00, 119.00, 21.00, 3, 0, 3, -1, '2016-08-02');
INSERT INTO HnS.Product
VALUES (5, 1, 'HP DesignJet 800', 4000.00, 4602.00, 21.00, 4, 0, 2, 0, '2016-08-02');
INSERT INTO HnS.Product
VALUES (6, 1, 'Canon Selphy DS810', 75.00, 90.00, 21.00, 5, 0, 3, 0, '2016-08-02');
INSERT INTO HnS.Product
VALUES (7, 5, 'Gigabyte 8KNXP', 182.61, 210.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (8, 5, 'Aopen AX4C Max', 186.96, 215.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (9, 5, 'DFI Lanparty Pro 875', 178.26, 205.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (10, 5, 'Epox 4PCA3+', 134.78, 155.00, 21.00, 0, 0, 0, -1, '2016-08-03');
INSERT INTO HnS.Product
VALUES (11, 5, 'Asus P4C800 Deluxe', 152.17, 175.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (12, 5, 'Asus A7V8X KT400 6xP u133 A8x sound lan DDR333', 52.17, 60.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (13, 5, 'MSI KT4V-L KT400 6xP A8x u133 sound/LAN DDR', 56.52, 65.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (14, 5, 'MSI KT6V-LSR 5xP u133 snd ser.ata lan RAId DDR400', 65.22, 75.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (15, 5, 'MSI K8T-NEO-FSR 754 K8T800 snd/lan/Sata/raId DDR400', 100.00, 115.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (16, 6, 'Sony Ericsson P900', 652.17, 750.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (17, 6, 'Treo 600', 669.57, 770.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (18, 6, 'Palm one Tungsten W', 408.70, 470.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (19, 6, 'Siemens SX1', 486.96, 560.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (20, 6, 'Motorola MPx200', 408.70, 470.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (21, 6, 'Nokia 6600', 373.91, 430.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (22, 7, 'MSI FX5900XT-VTD128', 191.30, 220.00, 21.00, 2, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (23, 7, 'Sapphire Radeion 9800 Atlantis Dual-DVI', 156.52, 180.00, 21.00, 3, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (24, 7, 'Innovision Tornado Geforce FX 5900 XT', 191.30, 220.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (25, 7, 'Creative Radion 9600', 147.83, 170.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (26, 7, 'Aopen Aeolus FX 5600', 108.70, 125.00, 21.00, 3, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (27, 7, 'Chaintech A-FX30', 160.87, 185.00, 21.00, 4, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (28, 7, 'Albatron FX5200U', 143.48, 165.00, 21.00, 3, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (29, 8, 'Canon Powershot G5', 556.52, 640.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (30, 8, 'Minolta Dimage A1', 782.61, 900.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (31, 8, 'Canon Powershot S45', 465.22, 535.00, 21.00, 2, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (32, 8, 'Konica Digital Revio KD 500Z', 360.87, 415.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (33, 8, 'Kodak Easyshare DX4900', 347.83, 400.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (34, 9, 'HP Compaq Ipaq 4150', 473.91, 545.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (35, 9, 'Dell Axim X3i', 347.83, 400.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (36, 9, 'Asus Mypal A620', 273.91, 315.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (37, 9, 'Yakumo delta 400', 208.70, 240.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (38, 9, 'Toshiba e330', 382.61, 440.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (39, 9, 'Acer n20', 234.78, 270.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (40, 10, 'Palm Tungsten T3', 365.22, 420.00, 21.00, 1, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (41, 10, N'Sony Clié PEG-NX73V', 426.09, 490.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (42, 11, 'Lancom 1821 Wireless ADSL', 695.65, 800.00, 21.00, 0, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (43, 11, 'Belkin F5D7630-48', 130.43, 150.00, 21.00, 2, 0, 0, 0, '2016-08-03');
INSERT INTO HnS.Product
VALUES (44, 11, 'SMC 7804WBRB', 160.87, 185.00, 21.00, 1, 0, 0, -1, '2016-08-04');
INSERT INTO HnS.Product
VALUES (45, 1, 'Canon i965', 256.52, 295.00, 21.00, 1, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (46, 1, 'HP Photosmart 7350', 169.57, 195.00, 21.00, 1, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (47, 1, 'HP Business inkjet 2300DTN', 565.22, 650.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (48, 1, 'HP Inkjet 1160', 417.39, 480.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (49, 12, 'Canon CP-300', 286.96, 330.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (50, 12, 'Sanyo DVP-P1-EX', 239.13, 275.00, 21.00, 2, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (51, 12, 'Fuji CX-400', 717.39, 825.00, 21.00, 2, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (52, 2, 'Oki C5300DN', 1565.22, 1800.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (53, 2, 'Lexmark C510n', 608.70, 700.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (54, 2, 'Minolta Magicolor 2350', 956.52, 1100.00, 21.00, 2, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (55, 2, 'HP Color Laserjet 3700', 956.52, 1100.00, 21.00, 2, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (56, 2, 'Epson Aculaser C900n', 565.22, 650.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (57, 13, 'AMD Athlon XP2500+ 1,83 GHz 333MHz FSB 512k box', 82.61, 95.00, 21.00, 12, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (58, 13, 'AMD Athlon XP2700+ 2,17 GHz 333MHz FSB 256k box', 113.04, 130.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (59, 13, 'AMD Athlon XP2800+ 2,08 GHz 333MHz FSB 512k box', 126.09, 145.00, 21.00, 0, 0, 0, -1, '2016-08-04');
INSERT INTO HnS.Product
VALUES (60, 13, 'AMD Athlon XP3000+ 2,17 GHz 333MHz FSB 512k box', 152.17, 175.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (61, 13, 'AMD Athlon XP3200+ 2,20 GHz 400MHz FSB 512k box', 195.65, 225.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (62, 13, 'AMD ATH. XP64 3000+ 2,0 GHz 800MHz FSB 512k box', 230.43, 265.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (63, 13, 'AMD ATH. XP64 3200+ 2,2 GHz 800MHz FSB 1 MB box', 291.30, 335.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (64, 13, 'AMD ATH. XP64 3400+ 2,4 GHz 800MHz FSB 1 MB box', 391.30, 450.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (65, 13, 'Intel Celeron 2,4 GHz 478 400MHz FSB 128k box', 69.57, 80.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (66, 13, 'Intel Celeron 2,6 GHz 478 400MHz FSB 128k box', 89.57, 103.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (67, 13, 'Intel Celeron 2,8 GHz 478 400MHz FSB 128k box', 118.26, 136.00, 21.00, 3, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (68, 13, 'Intel P4 2,80GHz 478 533MHz FSB 512k box', 169.57, 195.00, 21.00, 2, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (69, 13, 'Intel P4 3,06GHz 478 533MHz FSB 512k HT box', 219.13, 252.00, 21.00, 15, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (70, 13, 'Intel P4 2,80GHz 478 800MHz FSB 512k HT box', 182.61, 210.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (71, 13, 'Intel P4 3,00GHz 478 800MHz FSB 512k HT box', 221.74, 255.00, 21.00, 0, 0, 0, -1, '2016-08-04');
INSERT INTO HnS.Product
VALUES (72, 13, 'Intel P4 3,20GHz 478 800MHz FSB 512k HT box', 280.00, 322.00, 21.00, 0, 0, 0, -1, '2016-08-04');
INSERT INTO HnS.Product
VALUES (73, 13, 'Intel P4 3, 40GHz 478 800MHz FSB 512k HT box', 418.26, 481.00, 21.00, 0, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (74, 13, 'Cooler voor P2/3 P4 AMD', 13.04, 15.00, 21.00, 20, 0, 0, 0, '2016-08-04');
INSERT INTO HnS.Product
VALUES (75, 14, 'SDRAM 133MHz 128/256/512 MB', 117.39, 135.00, 21.00, 5, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (76, 14, 'DDR 333/400MHz 256/512 MB', 100.00, 115.00, 21.00, 3, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (77, 14, 'RIMM 400MHz PC800 128/256 MB', 95.65, 110.00, 21.00, 10, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (78, 14, 'Corsair Value 256/512 MB 333 of 400', 100.00, 115.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (79, 14, 'Corsair Twinx 512 MB DDR500', 156.52, 180.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (80, 14, 'Corsair Twinx 1024 MB 400/500/550', 421.74, 485.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (81, 14, 'Corsair Twinx 2048 MB 400', 526.09, 605.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (82, 14, 'Cors. XMS 512 MB 400/500/550', 204.35, 235.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (83, 14, 'Corsair Pro LED XMS 512 MB 400', 169.57, 195.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (84, 14, 'Corsair Pro LED TWINX 1024 MB 400/500', 326.09, 375.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (85, 14, 'SO-DIMM SDRAM 133MHz 256 MB notebook', 73.91, 85.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (86, 14, 'SO-DIMM DDR 266MHz 256/512 MB notebook', 108.70, 125.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (87, 4, 'Windows XP NL/UK oem', 86.96, 100.00, 21.00, 12, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (88, 4, 'Windows XP-Pro NL/UK oem', 134.78, 155.00, 21.00, 2, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (89, 4, 'MS Office 2003 Basic Word/Excel/Outlook NL/UK', 191.30, 220.00, 21.00, 1, 0, 0, -1, '2016-08-05');
INSERT INTO HnS.Product
VALUES (90, 4, 'MS Office 2003 SBE W./E./Outl./Publisher/Powerp. NL/UK', 247.83, 285.00, 21.00, 3, 0, 0, 0,
        '2016-08-05');
INSERT INTO HnS.Product
VALUES (91, 4, 'MS Office 2003 Pro Idem met Acces NL/UK', 300.00, 345.00, 21.00, 1, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (92, 4, 'Ahead Nero 5.5/6.0 OEM', 8.70, 10.00, 21.00, 2, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (93, 4, 'Symantec Norton AntiVirus 2004 NL OEM', 39.13, 45.00, 21.00, 24, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (94, 4, 'Symantec Norton Firewall 2003 6.0 NL', 43.48, 50.00, 21.00, 3, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (95, 4, 'Symantec Norton Internet Security 2004 7.0 NL', 65.22, 75.00, 21.00, 2, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (96, 15, '56k modem intern/extern', 34.78, 40.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (97, 15, '56k PCMCIA voor notebook', 43.48, 50.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (98, 15, 'ISDN PCI 64k', 21.74, 25.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (99, 16, 'MIditower BLUE 300W ATX 3x5 25/3x3,5', 47.83, 55.00, 21.00, 15, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (100, 16, 'Aopen QF50 Blue 300W 4x5 25/4x3,5', 47.83, 55.00, 21.00, 5, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (101, 16, 'Aopen QF50 Black 300W 3x5, 25/3x3,5', 47.83, 55.00, 21.00, 10, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (102, 16, 'Aopen HQ48 Blue 300W 3x5, 25/3x3,5 front usb+audio', 58.26, 67.00, 21.00, 4, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (103, 16, 'Aopen HQ95 Blue 300W 3x5, 25/3x3,5 desktop', 58.26, 67.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (104, 16, 'Aopen H600A wit 300W 4x5, 25/5x3,5 front usb+audio', 65.22, 75.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (105, 16, 'Aopen H600B zwart 300W 4x5, 25/5x3,5 front usb+audio', 78.26, 90.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (106, 16, 'Aopen H700A wit 350W 6x5, 25/6x3,5 front usb+audio', 86.96, 100.00, 21.00, 0, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (107, 16, 'Chieftec BX-01B, BX-01SL 360W zwart of zilver usb/1394', 91.30, 105.00, 21.00, 0, 0, 0, -1,
        '2016-08-05');
INSERT INTO HnS.Product
VALUES (108, 16, 'Chieftec BX03B, BX-03SL 360W zwart of zilver usb/1394', 93.04, 107.00, 21.00, 0, 0, 0, 0,
        '2016-08-05');
INSERT INTO HnS.Product
VALUES (109, 16, 'Case cooler 80x80mm 12V', 8.70, 10.00, 21.00, 12, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (110, 17, 'ATX voeding 350W', 21.74, 25.00, 21.00, 34, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (111, 17, 'ATX voeding 400W', 39.13, 45.00, 21.00, 57, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (112, 18, 'Logitech Internet keyboard', 12.17, 14.00, 21.00, 2, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (113, 18, 'Logitech Internet Navigator keyboard wit', 30.43, 35.00, 21.00, 3, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (114, 18, 'Logitech Internet Navigator keyboard zwart', 30.43, 35.00, 21.00, 1, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (115, 18, 'Logitech Cordless Desktop DeLuxe wit/zilver', 47.83, 55.00, 21.00, 3, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (116, 18, 'Logitech Cordless Desktop DeLuxe zwart', 65.22, 75.00, 21.00, 3, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (117, 19, 'Logitech Pilotmouse Optical Ps/2 oem wt of zwart', 13.04, 15.00, 21.00, 3, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (118, 19, 'Logitech Cordless Mouse retail', 26.96, 31.00, 21.00, 2, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (119, 19, 'Logitech Cordless Optical Mouse retail', 41.74, 48.00, 21.00, 1, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (120, 19, 'Logitech MX310 optical muis Ps/2/USB retail', 30.43, 35.00, 21.00, 2, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (121, 19, 'Logitech MX510 optical muis Ps/2/USB retail', 36.52, 42.00, 21.00, 3, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (122, 19, 'Logitech MX700 Cordless optical muis Ps/2/USB retail', 60.00, 69.00, 21.00, 4, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (123, 19, 'Logitech MX900 Cordless optical muis Bluetooth USB', 73.91, 85.00, 21.00, 5, 0, 0, -1, '2016-08-05');
INSERT INTO HnS.Product
VALUES (124, 20, 'Logitech Wingman Attack3 joystick USB', 21.74, 25.00, 21.00, 1, 0, 0, 0, '2016-08-05');
INSERT INTO HnS.Product
VALUES (125, 20, 'Logitech Wingman Force 3D joystick USB', 47.83, 55.00, 21.00, 3, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (126, 20, 'Logitech Rumblepad gamepad USB', 27.83, 32.00, 21.00, 6, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (127, 20, 'Logitech Cordless Rumblepad Wingman USB', 41.74, 48.00, 21.00, 3, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (128, 20, 'Logitech Formula Force GP met force feedback USB', 56.52, 65.00, 21.00, 2, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (129, 20, 'Creative Webcam NX USB', 25.22, 29.00, 21.00, 0, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (130, 20, 'Creative Webcam NX PRO INCL. MICROFOON USB', 41.74, 48.00, 21.00, 0, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (131, 20, 'Philips ToUcam Pro2 60fps USB retail', 72.17, 83.00, 21.00, 0, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (132, 20, 'Logitech Quickcam Zoom incl. microfoon USB', 56.52, 65.00, 21.00, 0, 0, 0, 0, '2016-08-06');
INSERT INTO HnS.Product
VALUES (133, 20, 'Trust gamepoortswitch 4 poorten', 10.43, 12.00, 21.00, 0, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (134, 20, 'Externe USB2.0 hub incl. PSU', 18.26, 21.00, 21.00, 0, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (135, 20, 'Interne USB hub 4 poorten', 13.04, 15.00, 21.00, 0, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (136, 20, 'Interne multi media poort met 1394 USB cf/sm/ms/sd/mm', 26.09, 30.00, 21.00, 0, 0, 0, 0,
        '2016-08-08');
INSERT INTO HnS.Product
VALUES (137, 21, 'HP Scanjet 2400C usb', 63.48, 73.00, 21.00, 0, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (138, 21, 'HP Scanjet 3670C usb2 1200dpi dias en negatieven', 85.22, 98.00, 21.00, 0, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (139, 21, 'HP Scanjet 3690C usb2 1200dpi dias en negatieven', 103.48, 119.00, 21.00, 4, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (140, 21, 'HP Scanjet 3970C usb2 2400dpi dias en negatieven', 128.70, 148.00, 21.00, 3, 0, 0, -1, '2016-08-08');
INSERT INTO HnS.Product
VALUES (141, 22, 'Maxtor/WD 40gb 7200rpm 2 MB cache', 53.91, 62.00, 21.00, 0, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (142, 22, 'Maxtor/WD 80gb 7200rpm 8 MB cache', 72.17, 83.00, 21.00, 2, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (143, 22, 'Maxtor/WD 120gb 7200rpm 8 MB cache', 89.57, 103.00, 21.00, 3, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (144, 22, 'Maxtor/WD 160gb 7200rpm 8 MB cache', 101.74, 117.00, 21.00, 2, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (145, 22, 'Maxtor/WD 200gb 7200rpm 8 MB cache', 122.61, 141.00, 21.00, 2, 0, 0, 0, '2016-08-08');
INSERT INTO HnS.Product
VALUES (146, 22, 'Maxtor/WD 250gb 7200rpm 8 MB cache', 185.22, 213.00, 21.00, 1, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (147, 22, 'Maxtor/WD 80gb Ser. ATA 7200rpm 8 MB cache', 73.04, 84.00, 21.00, 5, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (148, 22, 'Maxtor/WD 120gb Ser. ATA 7200rpm 8 MB cache', 94.78, 109.00, 21.00, 3, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (149, 22, 'Maxtor/WD 160gb Ser. ATA 7200rpm 8 MB cache', 110.43, 127.00, 21.00, 2, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (150, 22, 'Maxtor/WD 200gb Ser. ATA 7200rpm 8 MB cache', 133.91, 154.00, 21.00, 3, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (151, 22, 'Maxtor/WD 250gb Ser. ATA 7200rpm 8 MB cache', 198.26, 228.00, 21.00, 1, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (152, 22, 'WD Raptor 36gb Ser. ATA 10krpm 8 MB cache', 108.70, 125.00, 21.00, 4, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (153, 22, 'WD Raptor 72gb Ser. ATA 10krpm 8 MB cache', 208.70, 240.00, 21.00, 4, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (154, 22, 'Hitachi 30gb 2,5" 4200rpm', 86.96, 100.00, 21.00, 3, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (155, 22, 'Hitachi 40gb 2,5" 4200rpm', 117.39, 135.00, 21.00, 3, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (156, 22, 'Extern WD 80Gb 7200rpm USB2.0', 126.09, 145.00, 21.00, 2, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (157, 22, 'Extern WD 120Gb 7200rpm USB2.0/1394', 173.91, 200.00, 21.00, 2, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (158, 22, 'Extern WD 250Gb 7200rpm USB2.0/1394', 273.91, 315.00, 21.00, 2, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (159, 23, 'Soundkaart 16 bits PnP stereo PCI', 8.70, 10.00, 21.00, 4, 0, 0, -1, '2016-08-10');
INSERT INTO HnS.Product
VALUES (160, 23, 'Creative Soundblaster Live 5.1 Digitaal PCI oem', 30.43, 35.00, 21.00, 5, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (161, 23, 'Creative Soundblaster Audigy-II ZS retail', 121.74, 140.00, 21.00, 6, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (162, 24, 'Creative Inspire 2.1 P380 2x speaker met subwoofer', 39.13, 45.00, 21.00, 4, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (163, 24, 'Creative Inspire 5.1 P580 5x speaker met subwoofer', 65.22, 75.00, 21.00, 4, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (164, 24, 'Creative Inspire 5500 5x speaker met subw. Incl. dec.', 156.52, 180.00, 21.00, 0, 0, 0, 0,
        '2016-08-10');
INSERT INTO HnS.Product
VALUES (165, 24, 'Creative Inspire T7700 7x speaker met subw. Dolby surr.', 113.04, 130.00, 21.00, 0, 0, 0, 0,
        '2016-08-10');
INSERT INTO HnS.Product
VALUES (166, 24, 'Standaard subwooferset 750W zilver/blauw', 34.78, 40.00, 21.00, 1, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (167, 24, 'Labtec Spin 75 zwart', 26.09, 30.00, 21.00, 3, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (168, 24, 'Labtec Spin 45 wit', 21.74, 25.00, 21.00, 2, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (169, 25, 'Lite-On/MSI 52xW/24xRW/52xR IdE', 34.78, 40.00, 21.00, 45, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (170, 25, 'Plextor 52xW/24xRW/52xR IdE retail wit of zwart front', 47.83, 55.00, 21.00, 4, 3, 0, 0,
        '2016-08-10');
INSERT INTO HnS.Product
VALUES (171, 25, 'Asus DRW0804P DVD +/- 8/4/8/4 IdE Retail wit of zwart', 95.65, 110.00, 21.00, 4, 0, 0, 0,
        '2016-08-10');
INSERT INTO HnS.Product
VALUES (172, 25, 'Plextor 708A 40xW/24xRW/40xR/4x+RW-R/8xDVD+R', 121.74, 140.00, 21.00, 1, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (173, 25, 'Plextor 712A 40xW/24xRW/40xR/4x+RW-R/12xDVD+R', 164.35, 189.00, 21.00, 2, 0, 0, -1, '2016-08-10');
INSERT INTO HnS.Product
VALUES (174, 25, 'Sony DRU700A DVD +/- DUAL 8x/2, 4x Retail eind mei', 140.87, 162.00, 21.00, 2, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (175, 3, 'Samsung 710N 17"TFT Zilver 12ms', 386.96, 445.00, 21.00, 3, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (176, 3, 'Samsung 710T 17"TFT Zilver 12ms', 456.52, 525.00, 21.00, 0, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (177, 3, 'Samsung 172X 17"TFT Zilver 12ms', 517.39, 595.00, 21.00, 0, 0, 0, 0, '2016-08-10');
INSERT INTO HnS.Product
VALUES (178, 3, 'Samsung 910N 19"TFT Zilver', 604.35, 695.00, 21.00, 0, 0, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (179, 3, 'Philips Monitor CRT 17" Model 107E5', 143.48, 165.00, 21.00, 12, 0, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (180, 3, 'Philips Monitor CRT 17" Model 107E56 - Black', 143.48, 165.00, 21.00, 7, 0, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (181, 3, 'Philips Monitor CRT 17" Model 107T51 FLAT CRT', 160.87, 185.00, 21.00, 3, 12, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (182, 3, 'Philips Monitor CRT 17" Model 107P50 - New', 226.09, 260.00, 21.00, 0, 0, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (183, 3, 'Philips Monitor CRT 19" Model 109E', 195.65, 225.00, 21.00, 1, 0, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (184, 3, 'Philips Monitor LCD 17" Model 170S5FS', 443.48, 510.00, 21.00, 2, 0, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (185, 3, 'Philips Monitor LCD 17" Model 170B5//CB//CG//cs', 521.74, 600.00, 21.00, 0, 0, 0, 0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (186, 3, 'Philips Monitor LCD 17" Model 170X4FS Consumer Line - Special Silver', 513.04, 590.00, 21.00, 1, 0, 0,
        0, '2016-08-11');
INSERT INTO HnS.Product
VALUES (187, 3, 'Philips TFT 18" Model 180p2B ivory', 739.13, 850.00, 21.00, 2, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (188, 5, 'Chaintech ZNF-150 Zenith', 200.00, 230.00, 21.00, 2, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (189, 5, 'Asus K8V Deluxe', 130.43, 150.00, 21.00, 1, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (190, 3, 'Philips Monitor LCD 17" Model 170C4FS Consumer Line', 486.96, 560.00, 21.00, 0, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (191, 25, 'MSI 8x +/- Retail', 95.65, 110.00, 21.00, 3, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (192, 25, 'NEC 2510 8x DVD +/- IdE oem wit/zwart', 86.96, 100.00, 21.00, 2, 0, 0, -1, '2016-08-12');
INSERT INTO HnS.Product
VALUES (193, 23, 'Creative Soundblaster Audigy LS retail', 65.22, 75.00, 21.00, 5, 0, 0, -1, '2016-08-12');
INSERT INTO HnS.Product
VALUES (194, 22, 'Maxtor/WD 80gb 7200rpm 2 MB cache', 64.35, 74.00, 21.00, 13, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (195, 22, 'Maxtor/WD 120gb 7200rpm 2 MB cache', 82.61, 95.00, 21.00, 14, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (196, 18, 'Logitech Cordless Desktop Navigator wit/zilver', 73.91, 85.00, 21.00, 2, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (197, 18, 'Logitech Cordless Desktop MX zwart/zilver', 100.00, 115.00, 21.00, 1, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (198, 18, 'Cherry G83 Lanus keyboard', 18.26, 21.00, 21.00, 5, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (199, 19, 'Logitech Pilotmouse Ps/2 scroll oem', 10.43, 12.00, 21.00, 4, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (200, 5, 'Asus A7V600  6xP u133 A8x sound lan ser.ata DDR400', 67.83, 78.00, 21.00, 0, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (201, 5, 'Asus A7N8X-X Nforce2 5xP u133 A8x snd/lan DDR400', 65.22, 75.00, 21.00, 0, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (202, 7, 'GLeadtek Winfast A350TDH LX', 247.83, 285.00, 21.00, 0, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (203, 7, 'Point of View Geforce FX 5900XT TV/DVI', 182.61, 210.00, 21.00, 0, 0, 0, 0, '2016-08-12');
INSERT INTO HnS.Product
VALUES (204, 7, 'Gainward Silent FX Ultra 980 XP Pro', 200.00, 230.00, 21.00, 0, 0, 0, 0, '2016-08-13');
INSERT INTO HnS.Product
VALUES (205, 11, 'US Robotics USR 808054/5410', 113.04, 130.00, 21.00, 0, 0, 0, 0, '2016-08-13');
INSERT INTO HnS.Product
VALUES (206, 11, 'D-Link DWL-905+', 130.43, 150.00, 21.00, 0, 0, 0, 0, '2016-08-13');
INSERT INTO HnS.Product
VALUES (207, 13, 'AMD Duron 1600MHz socket A 200MHz FSB 128k tray', 43.48, 50.00, 21.00, 0, 0, 0, 0, '2016-08-13');
INSERT INTO HnS.Product
VALUES (208, 13, 'AMD Athlon XP2400+ 2,00GHz 266MHz FSB 256k box', 73.91, 85.00, 21.00, 10, 0, 0, 0, '2016-08-15');
INSERT INTO HnS.Product
VALUES (209, 13, 'Intel Prescott P4 2, 8GHz 478 800MHz FSB 1 MB HT box', 182.61, 215.00, 21.00, 0, 0, 0, 0,
        '2016-08-15');
INSERT INTO HnS.Product
VALUES (210, 13, 'Intel Prescott P4 3, 0GHz 478 800MHz FSB 1 MB HT box', 221.74, 260.00, 21.00, 0, 0, 0, 0,
        '2016-08-15');
INSERT INTO HnS.Product
VALUES (211, 13, 'Intel Prescott P4 3, 2GHz 478 800MHz FSB 1 MB HT box', 280.00, 322.00, 21.00, 0, 0, 0, 0,
        '2016-08-15');
INSERT INTO HnS.Product
VALUES (212, 13, 'Intel Prescott P4 3, 4GHz 478 800MHz FSB 1 MB HT box', 421.74, 485.00, 21.00, 0, 0, 0, 0,
        '2016-08-15');
INSERT INTO HnS.Product
VALUES (213, 13, 'Intel P4 3, 20GHz EE 478 800MHz FSB 2 MB HT box', 908.70, 1045.00, 21.00, 0, 0, 0, 0, '2016-08-15');
INSERT INTO HnS.Product
VALUES (214, 13, 'Intel P4 3, 40GHz EE 478 800MHz FSB 2 MB HT box', 995.65, 1145.00, 21.00, 0, 0, 0, 0, '2016-08-15');
INSERT INTO HnS.Product
VALUES (215, 1, 'Touch Privacyfilter voor 12,5" breedbeeldlaptop', 995.65, 1045.00, 21.00, 0, 0, 0, 0, '2019-06-19');
INSERT INTO HnS.Product
VALUES (216, 1, 'RJ45/RJ45 Patchcord Category 6', 795.65, 1045.00, 21.00, 0, 0, 0, 0, '2019-06-19');

-- Opvullen Klant
INSERT INTO HnS.Klant
VALUES (1, 'Vervoort', 'Jos', 'Nieuwstraat 31', '2440', 'Geel', '014 58 58 58', NULL, NULL);
INSERT INTO HnS.Klant
VALUES (2, 'Wilmaers', 'Louisa', 'Leuvensestwg 1', '1000', 'Brussel', '02 123 54 69', NULL, NULL);
INSERT INTO HnS.Klant
VALUES (3, 'De Brabander', 'Jean', 'Markt 5', '2440', 'Geel', NULL, NULL, NULL);
INSERT INTO HnS.Klant
VALUES (4, 'Stevens', 'Louis', 'Zwartwaterweg 34', '9000', 'Gent', '09 123 67 47', NULL, NULL);
INSERT INTO HnS.Klant
VALUES (5, 'Van Meensel', 'An', 'GerheIde 51', '2440', 'Geel', NULL, '0475 33 44 55', NULL);
INSERT INTO HnS.Klant
VALUES (6, 'Van Hout', 'Linda', 'Spoorwegstraat 190', '2490', 'Balen', '014 31 31 31', NULL, NULL);
INSERT INTO HnS.Klant
VALUES (7, 'Van Hout', 'Linda', 'Demaretak 1', '2440', 'Geel', NULL, NULL, NULL);
INSERT INTO HnS.Klant
VALUES (8, 'Smeyers', 'Gustaaf', 'In ''t Eegdeken 12', '2440', 'Geel', '014 58 96 33', NULL, NULL);
INSERT INTO HnS.Klant
VALUES (9, 'Sterckx', 'Jos', 'In ''t Eegdeken 13', '2440', 'Geel', '014 58 96 34', '0476 22 33 44', NULL);
INSERT INTO HnS.Klant
VALUES (10, 'De Prater', 'Jules', 'Kievit 3', '2400', 'Mol', NULL, NULL, 'jules.de.prater@hs.be');
INSERT INTO HnS.Klant
VALUES (11, 'De Waele', 'Erna', 'Locomotiefstraat 4', '2440', 'Geel', '014 12 13 14', '014 12 13 15',
        'erna.de.waele@hs.be');
INSERT INTO HnS.Klant
VALUES (12, 'De Vries', 'Anna', 'Vreesstraat 2', '2400', 'Mol', NULL, NULL, NULL);
INSERT INTO HnS.Klant
VALUES (13, 'Vos', N'José', 'Vesderstraat 5', '2440', 'Geel', '014 88 99 77', NULL, N'josé.vos@prietpraat.com');
INSERT INTO HnS.Klant
VALUES (14, 'Klaassen', 'Eric', 'Wispelturigestraat 5', '1000', 'Brussel', NULL, NULL, NULL);
INSERT INTO HnS.Klant
VALUES (15, 'Vandoninck', 'Greet', 'Kiezelweg 3', '2440', 'Geel', '014 58 56 54', NULL, NULL);
INSERT INTO HnS.Klant
VALUES (16, 'Cuyvers', 'An', 'Mermansstraat', '2440', 'Geel', '014 88 99 77', '0444 55 66 77', NULL);

-- Opvullen Nieuwsbrief
INSERT INTO HnS.Nieuwsbrief
VALUES (1, 'Hardware & software');
INSERT INTO HnS.Nieuwsbrief
VALUES (2, 'Microsoft Windows');
INSERT INTO HnS.Nieuwsbrief
VALUES (3, 'Games');

-- Opvullen NieuwsbriefKlant
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (1, 1);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (1, 2);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (1, 3);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (1, 4);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (1, 7);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (1, 8);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (1, 9);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (2, 1);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (2, 2);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (2, 6);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (2, 7);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (2, 8);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (3, 1);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (3, 2);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (3, 10);
INSERT INTO HnS.NieuwsbriefKlant (nieuwsbriefId, klantId)
VALUES (3, 11);

-- Opvullen Order
INSERT INTO HnS.[Order]
VALUES (1, 1, '2016-08-05', '2016-08-06');
INSERT INTO HnS.[Order]
VALUES (2, 2, '2016-08-06', '2016-08-06');
INSERT INTO HnS.[Order]
VALUES (3, 3, '2016-08-06', '2016-08-07');
INSERT INTO HnS.[Order]
VALUES (4, 1, '2016-08-08', '2016-08-09');
INSERT INTO HnS.[Order]
VALUES (5, 4, '2016-08-16', '2016-08-18');
INSERT INTO HnS.[Order]
VALUES (6, 8, '2016-08-16', '2016-08-18');
INSERT INTO HnS.[Order]
VALUES (7, 6, '2016-08-18', '2016-08-18');
INSERT INTO HnS.[Order]
VALUES (8, 9, '2016-08-18', '2016-08-18');
INSERT INTO HnS.[Order]
VALUES (10, 1, '2016-08-22', '2016-08-22');
INSERT INTO HnS.[Order]
VALUES (11, 14, '2016-08-23', '2016-08-25');
INSERT INTO HnS.[Order]
VALUES (12, 14, '2016-08-23', '2016-08-25');
INSERT INTO HnS.[Order]
VALUES (13, 15, '2016-08-25', NULL);
INSERT INTO HnS.[Order]
VALUES (14, 4, '2016-08-26', NULL);
INSERT INTO HnS.[Order]
VALUES (15, 16, '2016-08-27', NULL);
INSERT INTO HnS.[Order]
VALUES (16, 13, '2016-08-27', NULL);
INSERT INTO HnS.[Order]
VALUES (17, 1, '2016-08-30', NULL);
INSERT INTO HnS.[Order]
VALUES (18, 3, '2016-09-02', NULL);

-- Opvullen Orderlijn
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (1, 11, 175.00, 21.00, 1, 10);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (1, 68, 195.00, 21.00, 1, 10);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (1, 111, 45.00, 21.00, 2, 10);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (2, 1, 969.99, 21.00, 2, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (3, 111, 45.00, 21.00, 1, 10);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (3, 117, 15.00, 21.00, 5, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (3, 144, 117.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (3, 213, 1000.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (4, 4, 109.95, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (5, 21, 430.00, 21.00, 2, 5);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (5, 96, 40.00, 21.00, 3, 5);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (6, 205, 130.00, 21.00, 2, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (7, 9, 205.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (7, 14, 75.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (7, 91, 345.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (7, 137, 73.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (7, 145, 140.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (7, 175, 445.00, 21.00, 2, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (8, 4, 109.95, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (10, 112, 14.00, 21.00, 2, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (11, 69, 252.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (11, 142, 83.00, 21.00, 3, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (11, 179, 165.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (11, 211, 322.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (12, 181, 185.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (13, 35, 400.00, 21.00, 10, 10);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (14, 5, 4500.00, 21.00, 2, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (14, 115, 55.00, 21.00, 3, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (14, 195, 95.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (15, 11, 175.00, 21.00, 7, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (15, 24, 220.00, 21.00, 4, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (15, 83, 195.00, 21.00, 2, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (15, 99, 55.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (15, 169, 40.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (15, 183, 225.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (15, 195, 95.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (17, 147, 84.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 25, 170.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 46, 195.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 71, 255.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 75, 135.00, 21.00, 2, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 87, 100.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 101, 55.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 116, 75.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 145, 141.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 159, 10.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 174, 162.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 178, 695.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 188, 230.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 189, 150.00, 21.00, 1, 0);
INSERT INTO HnS.Orderlijn (orderId, productId, verkoopprijs, btwPercentage, hoeveelheid, korting)
VALUES (18, 199, 12.00, 21.00, 1, 0);
GO

-- extra klanten
INSERT INTO [HnS].Klant VALUES (17, 'Klabas', 'Jef', 'Peperstraat', '2440', 'Geel', '014 98 78 77', NULL, NULL);
INSERT INTO [HnS].Klant VALUES (18, 'Driesen', 'Antoinette', 'Nieuwstraat 15', '2400', 'Mol', '014 78 11 77', NULL, NULL);

INSERT INTO [HnS].[Klant] VALUES (27,'Peeters','Jef','Peperstraat 15','2440','Geel',NULL,NULL,'jef.peeters@hns.be');
INSERT INTO [HnS].[Klant] VALUES (28,'Klabas','Jef','Nieuwstraat 45A','2440','Geel',NULL,NULL,'jef.klabas@hns.be');
INSERT INTO [HnS].[Klant] VALUES (29,'Peeters','Karla','Peperstraat 15','2440','Geel',NULL,NULL,NULL);
INSERT INTO [HnS].[Klant] VALUES (30,'Klabas','Marjan','Nieuwstraat 45A','2440','GEEL',NULL,NULL,NULL);
GO

-- extra producten
INSERT INTO [HnS].[Product] VALUES (217, 1, 'V82D krachtig audiosysteem met BLUETOOTH-technologie', 1795.65, 2045.00, 21.00, 0, 0, 0, 0, '2019-06-20');
INSERT INTO [HnS].[Product] VALUES (218, 1, 'V82E krachtig audiosysteem met BLUETOOTH-technologie', 1795.65, 2145.00, 21.00, 10, 50, 0, 0, '2019-06-20');
GO
