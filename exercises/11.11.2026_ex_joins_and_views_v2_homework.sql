-- ==============================================================================

-- 1. Welche Bieter haben welche Gebote abgegeben?
-- Gebt für alle abgegebenen Gebote die Gebots-ID, die Bieter-ID, den Vornamen und Nachnamen des jeweiligen Bieters sowie den Gebotsbetrag aus. Es sollen nur Bieter berücksichtigt werden, die tatsächlich ein Gebot abgegeben haben. Sortiert die Ergebnisse nach der Gebots-ID aufsteigend.
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
ORDER BY gebot.gebot_ID ASC;

-- ==============================================================================

-- 2. Welche Rechnungen wurden bereits versandt und welche nicht?
-- Gebt alle Rechnungen mit Rechnungs-ID, Gebots-ID und Status aus. Ergänzt, sofern vorhanden, die Warenversandt-ID, den Versandzeitpunkt und den Dienstleister. Auch Rechnungen, für die noch kein Warenversand vorhanden ist, sollen im Ergebnis erscheinen. Sortiert die Ergebnisse nach der Rechnungs-ID aufsteigend.
-- Hinweis: Benutzen Sie einen LEFT JOIN oder RIGHT JOIN.

-- Lösung

SELECT
    rechnung.rechnung_ID,
    rechnung.gebot_ID,
    rechnung.status,
    warenversand.warenversand_ID,
    warenversand.zeitstempel,
    warenversand.dienstleister
FROM rechnung
LEFT JOIN warenversand ON warenversand.rechnung_ID = rechnung.rechnung_ID
ORDER BY rechnung.rechnung_ID ASC;

-- ==============================================================================

-- 3. Erstellt eine View mit einer Gebotsübersicht für jedes Kunstwerk.
-- Sie sollen für jedes Kunstwerk, auf das mindestens einmal geboten wurde, die Kunstwerk-ID, die Anzahl der abgegebenen Gebote, 
-- das höchste Gebot und den durchschnittlichen Gebotsbetrag enthalten.

-- Lösung

CREATE VIEW gebotsuebersicht AS
SELECT
    gebot.kunstwerk_ID,
    COUNT(gebot.gebot_ID) as anzahl_gebote,
    MAX(gebot.betrag) as hoechstes_gebot,
    AVG(gebot.betrag) as durchscnittliches_gebot
FROM gebot
GROUP BY gebot.kunstwerk_ID;

-- ==============================================================================

-- 4. Welche Kunstwerke haben, besonders viele Gebote erhalten?
-- Verwendet die zuvor erstellte View und verknüpft sie mit den Kunstwerken. Gebt die Kunstwerk-ID, den Titel, den Künstlernamen, 
-- die Anzahl der Gebote und das höchste Gebot aus. Berücksichtigt nur Kunstwerke, auf die mindestens sechs Gebote abgegeben wurden. 
-- Sortiert die Ergebnisse nach der Anzahl der Gebote absteigend.
-- Hinweis: Benutzen Sie einen einfachen JOIN mit der von Ihnen erstellten View.

-- Lösung

SELECT
    gebotsuebersicht.kunstwerk_ID,
    kunstwerk.titel,
    kunstwerk.kuenstlername,
    gebotsuebersicht.anzahl_gebote,
    gebotsuebersicht.hoechstes_gebot
FROM
	gebotsuebersicht
JOIN kunstwerk ON gebotsuebersicht.kunstwerk_ID = kunstwerk.kunstwerk_ID
	WHERE gebotsuebersicht.anzahl_gebote >=6
ORDER BY anzahl_gebote DESC;

-- ==============================================================================

-- 5. Welche Kunstwerke haben, bisher keine Gebote erhalten?
-- Gebt die Kunstwerk-ID, den Titel, den Startpreis und die Kategorie aller Kunstwerke aus, für die noch kein Gebot abgegeben wurde. 
-- Sortiert die Ergebnisse nach dem Startpreis absteigend.
-- Hinweis: Verwendet einen LEFT JOIN und prüft auf NULL.

-- Lösung

SELECT
    kunstwerk.kunstwerk_ID,
    kunstwerk.titel,
    kunstwerk.startpreis,
    kunstwerk.kategorie
FROM kunstwerk
LEFT JOIN gebot ON gebot.kunstwerk_ID = kunstwerk.kunstwerk_ID
WHERE gebot.gebot_ID IS NULL
ORDER BY kunstwerk.startpreis DESC;

-- ==============================================================================

-- 6. Welche Kunstwerke gehören zu welchen Auktionen?
-- Gebt für jedes Kunstwerk die Kunstwerk-ID, den Titel, den Startpreis sowie die zugehörige Auktions-ID und deren Start- und Endzeitpunkt aus. 
-- Sortiert die Ergebnisse nach dem Startzeitpunkt und anschließend dem Endzeitpunkt absteigend.
-- Erstellen Sie für diese Tabelle eine View mit dem Namen "Katalog".

-- Lösung

CREATE VIEW katalog AS
SELECT
    kunstwerk.kunstwerk_ID,
    kunstwerk.titel,
    kunstwerk.startpreis,
    kunstwerk.auktion_ID,
    auktion.startzeitpunkt,
    auktion.endzeitpunkt
FROM kunstwerk
JOIN auktion ON kunstwerk.auktion_ID = auktion.auktion_ID
ORDER BY auktion.endzeitpunkt DESC;

-- ==============================================================================

-- 7. Welche Kunstwerke wurden in welcher Stadt eingeliefert und versteigert?
-- Gebt die Kunstwerk-ID, den Titel, die Stadt des Einlieferers sowie die Auktions-ID und den Namen des zuständigen Auktionators aus. 
-- Berücksichtigt nur Kunstwerke der Kategorie „Gemälde“. Sortiert die Ergebnisse nach der Stadt und anschließend der Kunstwerk_ID aufsteigend.

-- Lösung

SELECT
    kunstwerk.kunstwerk_ID,
    kunstwerk.titel,
    einlieferer.stadt,
    auktion.auktion_ID,
    auktionator.vorname,
    auktionator.nachname
FROM kunstwerk
JOIN einlieferer ON kunstwerk.einlieferer_ID = einlieferer.einlieferer_ID
JOIN auktion ON kunstwerk.auktion_ID = auktion.auktion_ID
JOIN auktionator ON auktion.auktionator_ID = auktionator.auktionator_ID
WHERE kunstwerk.kategorie = "Gemälde"
ORDER BY kunstwerk.kunstwerk_ID ASC;

-- ==============================================================================

-- 8. Welche Bieter haben bisher keine Gebote abgegeben?
-- Gebt die Bieter-ID, den Vornamen, Nachnamen und die Stadt aller registrierten Bieter aus, die bisher kein Gebot abgegeben haben. 
-- Sortiert die Ergebnisse nach Nachnamen und Vorname aufsteigend.

-- Lösung

SELECT
    bieter.bieter_ID,
    bieter.vorname,
    bieter.nachname,
    bieter.stadt
FROM bieter
LEFT JOIN gebot ON gebot.bieter_ID = bieter.bieter_ID
WHERE gebot.gebot_ID IS NULL
ORDER BY bieter.vorname, bieter.nachname ASC;

-- ==============================================================================

-- 9. Welche Auktionen enthalten wie viele Kunstwerke?
-- Gebt für jede Auktion die Auktions-ID, den Startzeitpunkt und die Anzahl der zugeordneten Kunstwerke aus. 
-- Auch Auktionen ohne Kunstwerke sollen im Ergebnis erscheinen und mit einer Anzahl von 0 dargestellt werden. 
-- Sortiert die Ergebnisse nach der Anzahl der Kunstwerke aufsteigend.

-- Lösung

SELECT
    auktion.auktion_ID,
    auktion.startzeitpunkt,
    COUNT(kunstwerk.kunstwerk_ID) as anzahl_kunstwerke
FROM 
	auktion
LEFT JOIN kunstwerk ON kunstwerk.auktion_ID = auktion.auktion_ID
GROUP BY auktion.auktion_ID
ORDER BY anzahl_kunstwerke ASC;

-- ==============================================================================

-- 10. Welche Rechnungen haben, bisher keine Zahlung erhalten?
-- Gebt die Rechnungs-ID, die Zahlungsfrist, den Status und die Gebots-ID aller Rechnungen aus, zu denen noch keine Zahlung erfasst wurde. 
-- Sortiert die Ergebnisse nach der Zahlungsfrist aufsteigend.

-- Lösung

SELECT
    rechnung.rechnung_ID,
    rechnung.zahlungsfrist,
    rechnung.status,
    rechnung.gebot_ID
FROM
	rechnung
WHERE rechnung.status = "offen"
ORDER BY rechnung.zahlungsfrist ASC;

-- ==============================================================================

-- 11. Welche Einlieferer haben die meisten Kunstwerke eingeliefert?
-- Gebt die Einlieferer-ID, den Vornamen, Nachnamen und die Anzahl der eingelieferten Kunstwerke aus. 
-- Berücksichtigt auch Einlieferer ohne Kunstwerke. Sortiert die Ergebnisse nach der Anzahl der Kunstwerke absteigend.

-- Lösung

SELECT
    einlieferer.einlieferer_ID,
    einlieferer.vorname,
    einlieferer.nachname,
    COUNT(kunstwerk.kunstwerk_ID) as anzahl_kunstwerke
FROM
	einlieferer
LEFT JOIN kunstwerk ON kunstwerk.einlieferer_ID = einlieferer.einlieferer_ID
GROUP BY einlieferer.einlieferer_ID
ORDER BY anzahl_kunstwerke DESC;

-- ==============================================================================

-- 12. Welche Kunstwerke haben einen durchschnittlichen Gebotsbetrag von mehr als 5.000 €?
-- Gebt die Kunstwerk-ID, den Titel, den Startpreis, die Anzahl der Gebote und den durchschnittlichen Gebotsbetrag aus. 
-- Berücksichtigt ausschließlich Kunstwerke mit mindestens drei Geboten und einem durchschnittlichen Gebotsbetrag über 5.000 €. 
-- Sortiert die Ergebnisse nach dem durchschnittlichen Gebotsbetrag absteigend.

-- Lösung

SELECT
    kunstwerk.kunstwerk_ID,
    kunstwerk.titel,
    kunstwerk.startpreis,
    COUNT(gebot.gebot_ID) as anzahl_gebote,
    AVG(gebot.betrag) as durchschnittlicher_gebotsbetrag
FROM kunstwerk
JOIN gebot ON gebot.kunstwerk_ID = kunstwerk.kunstwerk_ID
GROUP BY kunstwerk.kunstwerk_ID
HAVING anzahl_gebote >=3 AND durchschnittlicher_gebotsbetrag >5000
ORDER BY durchschnittlicher_gebotsbetrag DESC;

-- ==============================================================================

-- 13. Welche Bieter haben auf besonders viele unterschiedliche Kunstwerke geboten?
-- Gebt die Bieter-ID, den Vornamen, Nachnamen, die Anzahl aller abgegebenen Gebote und die Anzahl der unterschiedlichen Kunstwerke aus, auf die geboten wurde. 
-- Berücksichtigt nur Bieter, die auf mindestens fünf unterschiedliche Kunstwerke geboten haben. 
-- Sortiert die Ergebnisse nach der Anzahl der unterschiedlichen Kunstwerke absteigend.
-- Hinweis: Verwendet COUNT(DISTINCT ...)

-- Lösung

SELECT
    bieter.bieter_ID,
    bieter.vorname,
    bieter.nachname,
    COUNT(DISTINCT gebot.gebot_ID) as anzahl_gebote,
    COUNT(DISTINCT kunstwerk.kunstwerk_ID) AS anzahl_kunstwerke
FROM
	bieter
JOIN gebot ON gebot.bieter_ID = bieter.bieter_ID
JOIN kunstwerk ON gebot.kunstwerk_ID = kunstwerk.kunstwerk_ID
GROUP BY bieter.bieter_ID
HAVING anzahl_gebote >=5
ORDER BY anzahl_kunstwerke DESC;

-- ==============================================================================

-- 14. Welche Kombinationen aus Kunstwerkkategorien und
-- Versanddienstleistern sind möglich?
-- Erstellt eine Übersicht aller möglichen Kombinationen der drei Kunstwerkkategorien „Gemälde“, „Skulptur“ und „Fotografie“ 
-- mit den drei Versanddienstleistern „DHL“, „Hermes“ und „DPD“. Gebt jeweils die Kategorie und den Dienstleister aus. 
-- Jede Kombination soll genau einmal vorkommen, unabhängig davon, ob bereits ein entsprechender Versand stattgefunden hat.
-- Hinweis: Hier ist ein Cross-Join gefragt.

-- Lösung

SELECT DISTINCT
    kunstwerk.kategorie,
    warenversand.dienstleister
FROM
	kunstwerk
CROSS JOIN warenversand;

-- ==============================================================================

-- 15. Welche Bieter könnten ein Paar sein?
-- Ermittelt alle Paare unterschiedlicher Bieter, die unter derselben Adresse wohnen. Gebt die Bieter-ID, den Vornamen und Nachnamen 
-- beider Personen sowie die gemeinsame Adresse aus. Jedes Bieterpaar soll nur einmal erscheinen. Ein Bieter darf nicht mit sich selbst kombiniert werden. 
-- Sortiert die Ergebnisse nach der Stadt aufsteigend. Ein Bieter darf in der gesamten Tabelle nur 2-mal vorkommen.
-- Hinweis: Hier ist ein Self-Join gefragt. Benutzt keine Unterabfragen! Es gibt keinen passenden Fremdschlüssel.

-- Lösung

SELECT 
    bieter1.bieter_ID AS bieter1_ID,
    bieter1.vorname AS bieter1_vorname,
    bieter1.nachname AS bieter1_nachname,
    bieter2.bieter_ID AS bieter2_ID,
    bieter2.vorname AS bieter2_vorname,
    bieter2.nachname AS bieter2_nachname,
    bieter1.stadt,
    bieter1.strasse,
    bieter1.hausnummer,
    bieter1.plz
FROM bieter AS bieter1
INNER JOIN bieter AS bieter2 
    ON bieter1.stadt = bieter2.stadt
    AND bieter1.strasse = bieter2.strasse
    AND bieter1.hausnummer = bieter2.hausnummer
    AND bieter1.plz = bieter2.plz
    AND bieter1.bieter_ID < bieter2.bieter_ID
ORDER BY bieter1.stadt ASC;

-- ==============================================================================

-- 16. Wie viel wurde für jede Rechnung bereits bezahlt?
-- Gebt für jede Rechnung die Rechnungs-ID, den Status, den zugehörigen Gebotsbetrag, die Anzahl der erfassten Zahlungen und die Summe aller Teilzahlungen aus. 
-- Rechnungen ohne Zahlungen sollen ebenfalls erscheinen und eine Zahlungssumme von 0 aufweisen. Sortiert die Ergebnisse nach der Summe aller Teilzahlungen absteigend.
-- Hinweis: Verwendet COALESCE.

-- Lösung

SELECT
    rechnung.rechnung_ID,
    rechnung.status,
    gebot.betrag,
    COUNT(zahlung.zahlung_ID) AS anzahl_zahlungen,
    COALESCE(SUM(zahlung.teilbetrag)) AS summe_zahlungen
FROM rechnung
LEFT JOIN gebot ON rechnung.gebot_ID = gebot.gebot_ID
LEFT JOIN zahlung ON zahlung.rechnung_ID = rechnung.rechnung_ID
GROUP BY rechnung.rechnung_ID
ORDER BY summe_zahlungen DESC;

-- ==============================================================================

-- 17. Welche Personen sind sowohl als Bieter als auch als Einlieferer registriert?
-- Erstellt eine vollständige Übersicht aller registrierten Bieter und Einlieferer. Gebt die Bieter-ID, den Vornamen und Nachnamen des 
-- Bieters sowie die Einlieferer-ID, den Vornamen und Nachnamen des Einlieferers aus. Personen, die sowohl als Bieter 
-- als auch als Einlieferer registriert sind, sollen in einer gemeinsamen Zeile erscheinen. Personen, die nur eine der beiden Rollen 
-- besitzen, sollen ebenfalls berücksichtigt werden. Sortiert die Ergebnisse nach dem Nachnamen aufsteigend.
-- Hinweis: Hier ist ein Full-Outer-Join gefragt. Verwendet UNION.

-- Lösung

SELECT 
    bieter.bieter_ID,
    bieter.vorname AS bieter_vorname,
    bieter.nachname AS bieter_nachname,
    einlieferer.einlieferer_ID,
    einlieferer.vorname AS einlieferer_vorname,
    einlieferer.nachname AS einlieferer_nachname
FROM bieter
LEFT JOIN einlieferer 
    ON bieter.vorname = einlieferer.vorname 
    AND bieter.nachname = einlieferer.nachname

UNION

SELECT 
    bieter.bieter_ID,
    bieter.vorname AS bieter_vorname,
    bieter.nachname AS bieter_nachname,
    einlieferer.einlieferer_ID,
    einlieferer.vorname AS einlieferer_vorname,
    einlieferer.nachname AS einlieferer_nachname
FROM bieter
RIGHT JOIN einlieferer 
    ON bieter.vorname = einlieferer.vorname 
    AND bieter.nachname = einlieferer.nachname

ORDER BY COALESCE(bieter_nachname, einlieferer_nachname) ASC;

-- ==============================================================================
