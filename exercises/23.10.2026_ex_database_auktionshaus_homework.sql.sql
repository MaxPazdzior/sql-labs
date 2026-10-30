-- ==============================================================================

DROP DATABASE IF EXISTS Auktionshaus;
CREATE DATABASE Auktionshaus;
USE Auktionshaus;

-- ==============================================================================

CREATE TABLE Auktion (
    Auktions_ID INT PRIMARY KEY,
    Auktionator_ID INT NOT NULL,
    Datum DATE NOT NULL,
    Ort VARCHAR(100) NOT NULL,
    Auktionsgebühr DECIMAL(12,2) NOT NULL CHECK (Auktionsgebühr >0)
);

CREATE TABLE Auktionator (
    Auktionator_ID INT PRIMARY KEY,
    Vorname VARCHAR(100) NOT NULL,
    Nachname VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Straße VARCHAR(100) NOT NULL,
    Hausnummer VARCHAR(100) NOT NULL,
    PLZ VARCHAR(100) NOT NULL,
    Stadt VARCHAR(100) NOT NULL
);

CREATE TABLE Kunstobjekte (
    Kunstobjekte_ID INT PRIMARY KEY,
    Einlieferer_ID INT NOT NULL,
    Auktions_ID INT NOT NULL,
    Kategorie_ID INT NOT NULL,
    Titel VARCHAR(100) NOT NULL,
    Künstler VARCHAR(100) NOT NULL,
    Entstehungsjahr DATE NOT NULL,
    Beschreibung TEXT NOT NULL,
    Startpreis DECIMAL(12,2) NOT NULL CHECK (Startpreis >0)
);

CREATE TABLE Kunstkategorie (
    Kategorie_ID INT PRIMARY KEY,
    Kategorie VARCHAR(100) NOT NULL
);

CREATE TABLE Einlieferer (
    Einlieferer_ID INT PRIMARY KEY,
    Vorname VARCHAR(100) NOT NULL,
    Nachname VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Straße VARCHAR(100) NOT NULL,
    Hausnummer VARCHAR(100) NOT NULL,
    PLZ VARCHAR(100) NOT NULL,
    Stadt VARCHAR(100) NOT NULL
);

CREATE TABLE Gebot (
    Gebot_ID INT PRIMARY KEY,
    Bieter_ID INT NOT NULL,
    Kunstobjekte_ID INT NOT NULL,
    Zeitstempel TIMESTAMP NOT NULL,
    Betrag DECIMAL(12,2) NOT NULL CHECK (Betrag >0)
);

CREATE TABLE Bieter (
    Bieter_ID INT PRIMARY KEY,
    Vorname VARCHAR(100) NOT NULL,
    Nachname VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Straße VARCHAR(100) NOT NULL,
    Hausnummer VARCHAR(100) NOT NULL,
    PLZ VARCHAR(100) NOT NULL,
    Stadt VARCHAR(100) NOT NULL,
    Registriert_Am DATE NOT NULL
);

CREATE TABLE Rechnung (
    Rechnungs_ID INT PRIMARY KEY,
    Gebot_ID INT NOT NULL,
    Betrag DECIMAL(12,2) NOT NULL CHECK (Betrag >0)
);

CREATE TABLE Zahlung (
    Zahlungs_ID INT PRIMARY KEY,
    Rechnungs_ID INT NOT NULL,
    Datum DATE NOT NULL,
    Betrag DECIMAL(12,2) NOT NULL CHECK (Betrag >0)
);

CREATE TABLE Versand (
    Versand_ID INT PRIMARY KEY,
    Rechnungs_ID INT NOT NULL,
    Carrier_ID INT NOT NULL,
    Versand_Datum DATE NOT NULL,
    Trackingnummer VARCHAR(100) NOT NULL
);

CREATE TABLE Carrier (
    Carrier_ID INT PRIMARY KEY,
    Carrier VARCHAR(100) NOT NULL
);

-- ==============================================================================

ALTER TABLE Auktion
ADD FOREIGN KEY (Auktionator_ID) REFERENCES Auktionator(Auktionator_ID);

ALTER TABLE Kunstobjekte
ADD FOREIGN KEY (Einlieferer_ID) REFERENCES Einlieferer(Einlieferer_ID);

ALTER TABLE Kunstobjekte
ADD FOREIGN KEY (Auktions_ID) REFERENCES Auktion(Auktions_ID);

ALTER TABLE Kunstobjekte
ADD FOREIGN KEY (Kategorie_ID) REFERENCES Kunstkategorie(Kategorie_ID);

ALTER TABLE Gebot
ADD FOREIGN KEY (Bieter_ID) REFERENCES Bieter(Bieter_ID);

ALTER TABLE Gebot
ADD FOREIGN KEY (Kunstobjekte_ID) REFERENCES Kunstobjekte(Kunstobjekte_ID);

ALTER TABLE Rechnung
ADD FOREIGN KEY (Gebot_ID) REFERENCES Gebot(Gebot_ID);

ALTER TABLE Zahlung
ADD FOREIGN KEY (Rechnungs_ID) REFERENCES Rechnung(Rechnungs_ID);

ALTER TABLE Versand
ADD FOREIGN KEY (Rechnungs_ID) REFERENCES Rechnung(Rechnungs_ID);

ALTER TABLE Versand
ADD FOREIGN KEY (Carrier_ID) REFERENCES Carrier(Carrier_ID);

-- ==============================================================================