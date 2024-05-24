CREATE TABLE Utente (
                ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT UNIQUE ,
                username VARCHAR(50) UNIQUE,
                password VARCHAR(250),
                cognome VARCHAR(50),
                nome VARCHAR(50),
                data_nascita DATE,
                numero_telefono VARCHAR(20),
                ruolo VARCHAR(20)
);

CREATE TABLE Giorno (
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT UNIQUE,
    giorno DATE,
    inizio_turno TIME,
    fine_turno TIME,
    id_utente INT UNSIGNED,
    FOREIGN KEY (id_utente) REFERENCES Utente(ID)
);
CREATE TABLE Entrata (
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT UNIQUE,
    orario_entrata TIME
);
CREATE TABLE Uscita (
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT UNIQUE,
    orario_uscita TIME,
    motivo VARCHAR(50),
    id_giorno INT UNSIGNED,
    id_entrata INT UNSIGNED,
    FOREIGN KEY (id_giorno) REFERENCES Giorno(ID),
    FOREIGN KEY (id_entrata) REFERENCES Entrata(ID)
);


INSERT INTO Utente (username, password, cognome, nome, data_nascita, numero_telefono, ruolo) VALUES ('admin@admin.com', '$2y$10$3WD4ej5c/312OdZZvFEusOb64OvrqYULAvEULROZeFYeShI7cR9iu', 'Mantelli', 'Nicolas', '2005-02-17','00000000','admin');
