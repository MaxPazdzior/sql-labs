-- ==============================================================================

-- Haus-- Aufgaben zu „Arbeiten mit Datenbanken“
-- Aufgabe1)
-- Gib alle Vornamen und Nachnamen aus der Tabelle „Person“ aus.

-- Lösung:
-- Befehl: 
SELECT vorname, nachname FROM person;
 
-- ==============================================================================

-- Aufgabe 2)
-- Zeige alle Personen, deren Telefonnummer mit „030“ beginnt.


-- Lösung:
-- Befehl: 
SELECT person.* From person
WHERE person.Telefonnummer LIKE '030%';

-- ==============================================================================

-- Aufgabe 3)
-- Finde alle Personen mit dem Nachnamen „Müller“.

-- Lösung:
-- Befehl:
SELECT person.nachname FROM person
WHERE person.nachname = ‚Müller‘;
 
-- ==============================================================================

-- Aufgabe 4)
-- Liste alle E-Mails auf, die zu „@example.de“ gehören.

-- Lösung:
-- Befehl:
SELECT person.Email FROM person
WHERE person.Email LIKE ‚%@example.de‘; 

-- ==============================================================================

-- Aufgabe 5)
-- Zeige alle Teilnehmer, die nach dem 01.01.2009 geboren wurden.

-- Lösung:
-- Befehl:
SELECT * FROM teilnehmer
WHERE teilnehmer.Geburtsdatum >= ‚2009-01-01‘;
 
-- ==============================================================================

-- Aufgabe 6)
-- Gib alle Räume mit einer Kapazität größer als 10 aus.

-- Lösung:
-- Befehl:
SELECT * FROM raum
WHERE raum.Kapazität >10;
 
-- ==============================================================================
-- Aufgabe 7)
-- Liste alle Personen alphabetisch nach Nachnamen.

-- Lösung:
-- Befehl:
SELECT person.Nachname FROM person
ORDER BY person.Nachname ASC;

-- ==============================================================================

-- Aufgabe 8)
-- Zeige alle Personen, deren Nachname entweder „Müller“, „Schmidt“ oder „Weber“ ist.

-- Lösung:
-- Befehl:
SELECT * FROM person
WHERE person.Nachname IN (‚Müller‘, ‚Schmidt‘, ‚Weber‘);
 
-- ==============================================================================

-- Aufgabe 9)
-- Zeige alle Kurse, die mit „G“ beginnen

-- Lösung
---- Befehl:
SELECT kurs.Titel FROM kurs
WHERE kurs.Titel LIKE 'G%';

-- ==============================================================================

-- Aufgabe 10)
-- Liste alle Teilnehmer, deren Geburtsdatum zwischen 2008 und 2010 liegt.

-- Lösung:
-- Befehl:
SELECT * FROM teilnehmer
WHERE teilnehmer.Geburtsdatum BETWEEN '2008-01-01' AND '2010-12-31';
 
-- ==============================================================================

-- Aufgabe 11)
-- Zeige alle Kurse mit einer festen Spaltenüberschrift: Titel als Kursname

-- Lösung:
-- Befehl:
SELECT kurs.Titel AS Kursname FROM kurs;
 
-- ==============================================================================

-- Aufgabe 12)
-- Gib die ersten 5 Personen aus der Tabelle Person alphabetisch sortiert nach Vornamen aus.

-- Lösung:
-- Befehl:
SELECT person.Vorname FROM person ORDER BY person.Vorname ASC LIMIT 5;
 
-- ==============================================================================

-- Aufgabe 13)
-- Zeige alle Fachgebiete, sortiert nach Bezeichnung absteigend.

-- Lösung:
-- Befehl:
SELECT fachgebiet.Bezeichnung FROM fachgebiet ORDER BY fachgebiet.Bezeichnung DESC;

-- ==============================================================================

-- Aufgabe 14)
-- Liste alle Personen mit dem Vornamen „Anna“

-- Lösung:
-- Befehl:
SELECT * FROM person
WHERE person.Vorname = 'Anna';
 
-- ==============================================================================

-- Aufgabe 15)
-- Gib alle Datensätze aus Raum zurück, bei denen die Raumbezeichnung genau 2 Zeichen lang ist.

-- Lösung
-- Befehl:
SELECT * FROM raum
WHERE raum.Nummer LIKE '__';
 
-- ============================================================================== 

-- Aufgabe 16)
-- Zeige alle E-Mail-Adressen, die mit „Gina“ beginnen.

-- Lösung:
-- Befehl:
SELECT person.Email FROM person
WHERE person.Email LIKE 'gina%';

-- ==============================================================================

-- Aufgabe 17)
-- Gib alle Personen mit einer Telefonnummer aus Wiesbaden (Die Telefonnummern sind aus Wiesbaden, nicht zwingend die Leute) (Vorwahl „0611“) zurück.

-- Lösung:
-- Befehl:
SELECT * FROM person
WHERE person.Telefonnummer LIKE '0611%';
 
-- ==============================================================================

-- Aufgabe 18)
-- Liste alle Personen mit dem Nachnamen, der ein „a“ enthält.

-- Lösung:
-- Befehl:
SELECT * from person 
WHERE person.Nachname LIKE ('%a%');
 
-- ==============================================================================

-- Aufgabe 19)
-- Gib alle Kursnummern aus, die mit „MTH“ oder „KLV“ beginnen.

-- Lösung:
-- Befehl:
SELECT * FROM kurs
WHERE kurs.Nummer LIKE ('MTH%') OR 
kurs.Nummer LIKE ('KLV%');
 
-- ==============================================================================

-- Aufgabe 20)
-- Zeige die Kurse, die in einem Raum mit einer Kapazität unter 10 stattfinden.

-- Lösung:
-- Befehl:
SELECT kurs.* FROM kurs, raum 
WHERE kurs.ID = raum.ID AND raum.Kapazität <10;

-- ==============================================================================