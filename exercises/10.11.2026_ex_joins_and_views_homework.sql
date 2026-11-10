-- ==============================================================================

-- 1. Welche Bieter haben welche Gebote abgegeben?
-- Gebt für alle abgegebenen Gebote die Gebots-ID, die Bieter-ID, den Vornamen und Nachnamen des jeweiligen Bieters sowie den Gebotsbetrag aus. 
-- Es sollen nur Bieter berücksichtigt werden, die tatsächlich ein Gebot abgegeben haben. Sortiert die Ergebnisse nach der Gebots-ID aufsteigend.
-- Hinweis: Benutzen Sie einen einfachen JOIN.

-- Lösung:
SELECT
    gebot.gebot_ID,
    gebot.bieter_ID,
    bieter.vorname,
    bieter.nachname,
    gebot.betrag
FROM gebot
JOIN bieter ON gebot.bieter_ID = bieter.bieter_ID
GROUP BY gebot.gebot_ID, gebot.bieter_ID, bieter.vorname, bieter.nachname, gebot.betrag
ORDER BY gebot.gebot_ID ASC;

-- ==============================================================================

-- 2. Welche Rechnungen wurden bereits versandt und welche nicht?
-- Gebt alle Rechnungen mit Rechnungs-ID, Gebots-ID und Status aus. Ergänzt, sofern vorhanden, die Warenversandt-ID, den Versandzeitpunkt und den Dienstleister. 
-- Auch Rechnungen, für die noch kein Warenversand vorhanden ist, sollen im Ergebnis erscheinen. Sortiert die Ergebnisse nach der Rechnungs-ID aufsteigend.
-- Hinweis: Benutzen Sie einen LEFT JOIN oder RIGHT JOIN.

-- Lösung:
SELECT
    rechnung.rechnung_ID,
    rechnung.gebot_ID,
    rechnung.status,
    warenversand.warenversand_ID,
    warenversand.zeitstempel,
    warenversand.dienstleister
FROM rechnung
LEFT JOIN warenversand ON warenversand.rechnung_ID = rechnung.rechnung_ID
GROUP BY rechnung.rechnung_ID, rechnung.gebot_ID, rechnung.status, warenversand.warenversand_ID, warenversand.zeitstempel, warenversand.dienstleister
ORDER BY rechnung.rechnung_ID ASC;

-- ==============================================================================

-- 3. Erstellt eine View mit einer Gebotsübersicht für jedes Kunstwerk.
-- Sie sollen für jedes Kunstwerk, auf das mindestens einmal geboten wurde, die Kunstwerk-ID, die Anzahl der abgegebenen Gebote, 
-- das höchste Gebot und den durchschnittlichen Gebotsbetrag enthalten.

-- Lösung:
CREATE VIEW gebotsuebersicht AS
SELECT 
    gebot.kunstwerk_ID,
    COUNT(gebot.gebot_ID) AS anzahl_gebote,
    MAX(gebot.betrag) AS hoechstes_gebot,
    AVG(gebot.betrag) AS durchschnittliches_gebot
FROM gebot
GROUP BY gebot.kunstwerk_ID;

-- ==============================================================================

-- 4. Welche Kunstwerke haben, besonders viele Gebote erhalten?
-- Verwendet die zuvor erstellte View und verknüpft sie mit den Kunstwerken. Gebt die Kunstwerk-ID, den Titel, den Künstlernamen, 
-- die Anzahl der Gebote und das höchste Gebot aus. Berücksichtigt nur Kunstwerke, auf die mindestens sechs Gebote abgegeben wurden. 
-- Sortiert die Ergebnisse nach der Anzahl der Gebote absteigend.
-- Hinweis: Benutzen Sie einen einfachen JOIN mit der von Ihnen erstellten View.

-- Lösung:
SELECT
    kunstwerk.kunstwerk_ID,
    kunstwerk.titel,
    kunstwerk.kuenstlername,
    gebotsuebersicht.anzahl_gebote,
    gebotsuebersicht.hoechstes_gebot
FROM gebotsuebersicht
JOIN kunstwerk ON gebotsuebersicht.kunstwerk_ID = kunstwerk.kunstwerk_ID
WHERE gebotsuebersicht.anzahl_gebote >=6
GROUP BY kunstwerk_ID
ORDER BY gebotsuebersicht.anzahl_gebote DESC;

-- ==============================================================================
