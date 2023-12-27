-- Scalaire Functies: Type 'strings'--  
    -- Upper
    select upper(naam), naam
    FROM Tennis.Speler


    -- Lower
    select lower(naam)
    from Tennis.Speler

    -- Nested Functions 
    SELECT upper(lower(upper(naam)))
    FROM Tennis.Speler


    -- Concat
    SELECT concat('''', naam, ''''),
        CONCAT('''', plaats, '''')
    from Tennis.Speler

    select naam + voornaam
    from Tennis.Speler


    -- Concat_WS
    SELECT CONCAT_WS(',', naam, plaats, voornaam)
    FROM Tennis.Speler


    --TRIM, LTRIM, RTRIM
    select LTRIM(naam) + voornaam
    from Tennis.Speler

    SELECT RTRIM(naam) + voornaam
    from Tennis.Speler

    select trim(naam) + voornaam
    from Tennis.Speler


    -- SPACE
    select trim(naam) + SPACE(1) + voornaam
    from Tennis.Speler


    -- LEFT / RIGHT
    select left(voornaam, 1) + '. ' + naam
    from Tennis.Speler

    select right(TRIM(voornaam), 3) + '. ' + naam
    from Tennis.Speler


    -- Substring
    select SUBSTRING(plaats, 2, 4), plaats  -- deel v/e string weergeven
    FROM Tennis.Speler


    -- CharIndex
    select CHARINDEX('a', plaats), plaats
    from Tennis.Speler

    SELECT substring ('Van den Vonder', CHARINDEX('','Van den Vonder'), 4)
    select CHARINDEX('o', 'r0985432@student.thomasmore.be', 3);


    -- Len
    SELECT LEN(plaats), plaats
    from Tennis.Speler


    -- Replace
    select replace(naam, 'wij', 'Jij'), naam
    from Tennis.Speler



-- Scalaire Functies: Type 'integers'--
    -- Round
    SELECT ROUND(bedrag, 2, 2), bedrag
    FROM Tennis.Boete

    -- FLOOR / CEILING
    select FLOOR(bedrag), bedrag
    from Tennis.Boete

    select ceiling(bedrag), bedrag
    from Tennis.Boete

    -- rand() ==> Random
    select (RAND() * 10) + 5


-- Scalaire Functies: Type 'Datums'--
    -- YEAR, MONTH, DAY
    SELECT geboortedatum,
           YEAR(geboortedatum) as 'Year of birth',
           MONTH(geboortedatum) as 'Month of birth',
           day(geboortedatum) as 'Day of birth'
    from Tennis.Speler

    -- datefromparts
    select DATEFROMPARTS(2024, 2, 29)

    -- DATENAME // DATEPART
    SELECT datepart(WEEKDAY, geboortedatum),
           DATENAME(WEEKDAY, geboortedatum)
    from Tennis.Speler

    -- DATEDIFF
    select datediff(HOUR, '2005-11-16', GETDATE())

    -- getUTCDate
    SELECT GETUTCDATE()

    -- dateAdd
    SELECT DATEADD(day, 20, geboortedatum), geboortedatum
    from Tennis.Speler

    --isDate
    select isDate('2020-2-29')


-- Scalaire Functies: Type ''--
    -- Cast
    SELECT 'Speler moet: ' + cast(bedrag as varchar) + ' betalen'
    from Tennis.Boete

    SELECT cast(bedrag as varchar)
    from Tennis.Boete

    -- Convert
    SELECT CONVERT(int, bedrag, 3)
    FROM Tennis.Boete

    SELECT geboortedatum, CONVERT(varchar, geboortedatum, 3)
    FROM Tennis.Speler

    -- IsNULL
    select naam, voornaam, ISNULL(bondsnummer, '')
    from Tennis.Speler

    -- NULLIf
    select naam, voornaam, NULLIF(plaats, 'Den Haag')
    FROM Tennis.Speler

    -- IsNumeric
    select huisnummer, ISNUMERIC(huisnummer)
    from Tennis.Speler

    -- OrderBy
    select *
    from Tennis.Speler
    ORDER by len(naam)