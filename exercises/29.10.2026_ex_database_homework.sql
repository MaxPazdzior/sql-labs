-- ==============================================================================

-- Aufgaben zum Auktionshaus (Aggregationen, GROUP BY, HAVING & JOIN)


-- 1. Wie viele Bieter sind insgesamt registriert? 
-- Gebt die Anzahl der registrierten Bieter aus.
SELECT 
    COUNT(bieter.bieter_ID) AS anzahl_bieter 
FROM bieter;

-- ==============================================================================

-- 2. Wie hoch sind der niedrigste und der höchste Startpreis eines Kunstwerks? 
-- Gebt den niedrigsten und den höchsten Startpreis aus.
SELECT 
    MIN(kunstwerk.startpreis) AS niedrigster_startpreis, 
    MAX(kunstwerk.startpreis) AS hoechster_startpreis 
FROM kunstwerk;

-- ==============================================================================

-- 3. Wie hoch ist der durchschnittliche Betrag aller abgegebenen Gebote? 
-- Gebt den durchschnittlichen Gebotsbetrag aus.
SELECT 
    AVG(gebot.betrag) AS durchschnittlicher_gebotsbetrag 
FROM gebot;

-- ==============================================================================

-- 4. Wie viele unterschiedliche Bieter haben mindestens ein Gebot abgegeben? 
-- Gebt die Anzahl der unterschiedlichen Bieter aus, die in der Tabelle "gebot" vorkommen.
SELECT 
    COUNT(DISTINCT gebot.bieter_ID) AS unterschiedliche_bieter 
FROM gebot;

-- ==============================================================================

-- 5. Wie hoch ist die Summe aller Zahlungen mit einem Teilbetrag von mindestens 2.000€? 
-- Gebt sowohl die Anzahl der berücksichtigten Zahlungen als auch die Summe ihrer Teilbeträge aus.
SELECT 
    COUNT(zahlung.teilbetrag) AS anzahl_zahlungen,
    SUM(zahlung.teilbetrag) AS summe_zahlungen
FROM zahlung 
WHERE zahlung.teilbetrag >= 2000;

-- ==============================================================================

-- 6. Wie viele Kunstwerke gibt es in jeder Kategorie? 
-- Gebt die Kategorie und die Anzahl der Kunstwerke aus. Gruppiert die Kunstwerke nach ihrer Kategorie.
SELECT 
    kunstwerk.kategorie,
    COUNT(kunstwerk.kunstwerk_ID) AS anzahl_kunstwerke
FROM kunstwerk 
GROUP BY kunstwerk.kategorie;

-- ==============================================================================

-- 7. Wie hoch ist der durchschnittliche Startpreis der Kunstwerke in jeder Kategorie? 
-- Gebt die Kategorie und den durchschnittlichen Startpreis aus. 
-- Sortiert die Kategorien nach dem durchschnittlichen Startpreis absteigend.
SELECT 
    kunstwerk.kategorie,
    AVG(kunstwerk.startpreis) AS durchschnittlicher_startpreis
FROM kunstwerk 
GROUP BY kunstwerk.kategorie 
ORDER BY durchschnittlicher_startpreis DESC;

-- ==============================================================================

-- 8. Wie viele Gebote wurden für jedes Kunstwerk abgegeben und wie hoch waren jeweils 
-- das niedrigste und das höchste Gebot? Gebt die Kunstwerk-ID, die Anzahl der Gebote 
-- sowie den niedrigsten und höchsten Gebotsbetrag aus. Gruppiert die Ergebnisse nach 
-- Kunstwerk-ID und sortiert sie nach der Anzahl der Gebote absteigend.
SELECT 
    gebot.kunstwerk_ID, 
    COUNT(gebot.betrag) AS gebote_insgesamt, 
    MIN(gebot.betrag) AS niedrigstes_gebot, 
    MAX(gebot.betrag) AS hoechstes_gebot 
FROM gebot 
GROUP BY gebot.kunstwerk_ID 
ORDER BY gebote_insgesamt DESC;

-- ==============================================================================

-- 9. Für welche Kunstwerke wurden mehr als fünf Gebote abgegeben? 
-- Gebt die Kunstwerk-ID und die Anzahl der abgegebenen Gebote aus. 
-- Berücksichtigt nur Kunstwerke, für die mehr als fünf Gebote abgegeben wurden. 
-- Sortiert die Ergebnisse nach der Anzahl der Gebote absteigend.
SELECT 
    gebot.kunstwerk_ID, 
    COUNT(gebot.gebot_ID) AS anzahl_gebote 
FROM gebot 
GROUP BY gebot.kunstwerk_ID 
HAVING anzahl_gebote > 5 
ORDER BY anzahl_gebote DESC;

-- ==============================================================================

-- 10. Welche Bieter haben insgesamt Gebote im Wert von mehr als 50.000€ abgegeben? 
-- Gebt die Bieter-ID, die Anzahl ihrer Gebote und die Summe ihrer Gebotsbeträge aus. 
-- Berücksichtigt nur Bieter, deren Gebote zusammen einen Wert von mehr als 50.000€ erreichen. 
-- Sortiert die Ergebnisse nach der Gesamtsumme absteigend.
SELECT 
    gebot.bieter_ID, 
    COUNT(gebot.betrag) AS anzahl_gebote, 
    SUM(gebot.betrag) AS summe_gebote 
FROM gebot 
GROUP BY gebot.bieter_ID 
HAVING summe_gebote > 50000 
ORDER BY summe_gebote DESC;

-- ==============================================================================

-- 11. Welche Bieter haben mindestens drei Gebote über 5.000€ abgegeben? 
-- Berücksichtigt nur Gebote mit einem Betrag von mehr als 5.000€. 
-- Gebt anschließend nur die Bieter aus, die mindestens drei solcher Gebote abgegeben haben. 
-- Gebt die Bieter-ID, die Anzahl der berücksichtigten Gebote und deren durchschnittlichen Betrag aus. 
-- Sortiert danach nach der Anzahl der Gebote absteigend.
SELECT 
    gebot.bieter_ID, 
    COUNT(gebot.gebot_ID) AS anzahl_gebote, 
    AVG(gebot.betrag) AS durchschnittlicher_betrag 
FROM gebot 
WHERE gebot.betrag > 5000 
GROUP BY gebot.bieter_ID 
HAVING anzahl_gebote >= 3 
ORDER BY anzahl_gebote DESC;

-- ==============================================================================

-- 12. Welche Bieter haben insgesamt Gebote im Wert von mehr als 50.000€ abgegeben? 
-- Gebt Bieter-ID, Vorname, Nachname, Anzahl der abgegebenen Gebote und die Summe der Gebotsbeträge aus. 
-- Berücksichtigt nur Bieter, deren Gebote zusammen einen Wert von mehr als 50.000€ erreichen. 
-- Sortiert die Ergebnisse nach der Gesamtsumme der Gebote absteigend.
SELECT 
    gebot.bieter_ID, 
    bieter.vorname, 
    bieter.nachname, 
    COUNT(gebot.gebot_ID) AS anzahl_gebote, 
    SUM(gebot.betrag) AS summe_gebote 
FROM gebot 
INNER JOIN bieter ON gebot.bieter_ID = bieter.bieter_ID 
GROUP BY 
    gebot.bieter_ID, 
    bieter.vorname, 
    bieter.nachname 
HAVING summe_gebote > 50000 
ORDER BY summe_gebote DESC;

-- ==============================================================================