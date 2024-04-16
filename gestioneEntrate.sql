CREATE TABLE Utente (
    ID INT PRIMARY KEY AUTOINCREMENT UNIQUE,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(250),
    Cognome VARCHAR(50),
    Nome VARCHAR(50),
    Data_nascita DATE,
    Email VARCHAR(100) UNIQUE,
    Numero_telefono VARCHAR(20)
);

CREATE TABLE Presenza (
    ID INT PRIMARY KEY AUTOINCREMENT UNIQUE,
    Id_Utente INT,
    Inizio_turno DATETIME,
    Fine_turno DATETIME,
    Entrata DATETIME,
    Uscita DATETIME,
    FOREIGN KEY (Id_Utente) REFERENCES Utente(ID)
);