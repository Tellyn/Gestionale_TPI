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
CREATE TABLE Presenza (
                          ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT UNIQUE,
                          id_Utente INT unsigned,
                          inizio_turno TIME,
                          fine_turno TIME,
                          entrata TIME,
                          uscita TIME,
                          giorno DATE,
                          descrizione text,
                          FOREIGN KEY (Id_Utente) REFERENCES Utente(ID)
);

