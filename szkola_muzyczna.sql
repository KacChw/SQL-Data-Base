CREATE TABLE Nauczyciele (
    ID_Nauczyciela INT PRIMARY KEY,
    Imie VARCHAR(255),
    Nazwisko VARCHAR(255),
    Specjalizacja VARCHAR(50)
);
CREATE TABLE Instrumenty (
    ID_Instrumentu INT PRIMARY KEY,
    Nazwa_instrumentu VARCHAR(50),
    Dostepnosc VARCHAR(20)
);
CREATE TABLE Uczniowie (
    ID_Ucznia INT PRIMARY KEY,
    Imie VARCHAR(255),
    Nazwisko VARCHAR(255),
    Data_urodzenia DATE,
    Klasa VARCHAR(10)
);
CREATE TABLE Lekcje (
    ID_Lekcji INT PRIMARY KEY,
    Nauczyciel_ID INT,
    Uczen_ID INT,
    Instrument_ID INT,
    Data_lekcji DATE,
    Przebieg_lekcji TEXT,
    FOREIGN KEY (Nauczyciel_ID) REFERENCES Nauczyciele(ID_Nauczyciela),
    FOREIGN KEY (Uczen_ID) REFERENCES Uczniowie(ID_Ucznia),
    FOREIGN KEY (Instrument_ID) REFERENCES Instrumenty(ID_Instrumentu)
);
CREATE VIEW Widok_Harmonogramu AS
SELECT L.ID_Lekcji, N.Imie AS Nauczyciel_Imie, N.Nazwisko AS Nauczyciel_Nazwisko,
       U.Imie AS Uczen_Imie, U.Nazwisko AS Uczen_Nazwisko,
       I.Nazwa_instrumentu, L.Data_lekcji, L.Przebieg_lekcji
FROM Lekcje L
JOIN Nauczyciele N ON L.Nauczyciel_ID = N.ID_Nauczyciela
JOIN Uczniowie U ON L.Uczen_ID = U.ID_Ucznia
JOIN Instrumenty I ON L.Instrument_ID = I.ID_Instrumentu;

 CREATE TRIGGER Aktualizuj_Dostepnosc_Instrumentu
AFTER INSERT ON Lekcje
FOR EACH ROW
BEGIN
    UPDATE Instrumenty
    SET Dostepnosc = 'w użyciu'
    WHERE ID_Instrumentu = NEW.Instrument_ID;
END;

