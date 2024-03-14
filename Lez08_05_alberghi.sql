DROP TABLE  IF EXISTS Albergo;
DROP TABLE IF EXISTS Prenotazione;
DROP TABLE IF EXISTS Facilities;
DROP TABLE IF EXISTS DipenDenti;
DROP TABLE IF EXISTS Camera;
DROP TABLE IF EXISTS Cliente;


CREATE TABLE Albergo(
albergoID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
indirizzo VARCHAR(250) NOT NULL,
valutazione INT NOT NULL CHECK (valutazione BETWEEN 1 AND 5)
);

CREATE TABLE Camera(
cameraID INT PRIMARY KEY IDENTITY(1,1),
numero INT NOT NULL,
tipo VARCHAR(100) NOT NULL CHECK (tipo IN ('singola','doppia','suite')),
capacità INT NOT NULL,
tariffa DECIMAL(10,2) NOT NULL CHECK (tariffa>0),
albergoRIF INT NOT NULL,
FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
UNIQUE(numero,albergoRIF)
);

CREATE TABLE Dipendenti(
dipentendiID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
cognome VARCHAR(250) NOT NULL,
posizione VARCHAR(250) NOT NULL CHECK (posizione IN ('receptionist','personale delle pulizie','manager')),
telefono VARCHAR(250) NOT NULL,
email VARCHAR(250),
albergoRIF INT NOT NULL,
FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE
);

CREATE TABLE Cliente(
clienteID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
cognome VARCHAR(250) NOT NULL,
telefono varchar(30) NOT NULL,
email VARCHAR(300) 
);

CREATE TABLE Facilities(
facilitiesID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL CHECK (nome IN ('palestra','piscina','spa')),
descrizione VARCHAR(300) NOT NULL,
orario_apertura TIME NOT NULL,
orario_chiusura TIME NOT NULL,
albergoRIF INT NOT NULL,
FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE
);

ALTER TABLE Facilities ADD CONSTRAINT CHK_orario_chiusura CHECK(orario_chiusura > orario_apertura);

CREATE TABLE Prenotazione(
prenotaID INT PRIMARY KEY IDENTITY (1,1),
check_in DATE NOT NULL,
check_out DATE NOT NULL,
cameraRIF INT NOT NULL,
clienteRIF INT NOT NULL,
FOREIGN KEY (cameraRIF) REFERENCES Camera(cameraID) ON DELETE CASCADE,
FOREIGN KEY (clienteRIF) REFERENCES Cliente(clienteID) ON DELETE CASCADE,
UNIQUE(clienteRIF, cameraRIF, check_in, check_out)
);

-- ALTER TABLE Prenotazione ADD CONSTRAINT CHK_date_range CHECK (check_in < check_out AND NOT('data_inserita' BETWEEN check_in AND check_out));

INSERT INTO Albergo(nome, indirizzo, valutazione) VALUES
('Albergo1','via del corso',4),
('Albergo2','via le mani dal naso',2),
('Albergo3','via delle vie',5),
('Albergo4','via roma',5);

INSERT INTO Camera(numero, tipo, capacità, tariffa, albergoRIF) VALUES
(109,'singola',1,30.50,1),
(1230,'doppia',2,80.50,1),
(1092,'suite',7,310,2),
(231,'doppia',2,60.50,3),
(563,'doppia',2,55,4),
(543,'suite',7,450,4);

INSERT INTO Camera(numero, tipo, capacità, tariffa, albergoRIF) VALUES (109,'singola',1,30.50,2);

INSERT INTO Cliente(nome, cognome, telefono, email) VALUES
('Giovanni','Pace','+3934918123',null),
('Mario','Rossi','+391238023','mar@ros.com'),
('Marika','Mariko','+3919827391',null),
('Valeria','Verdi','+3903401230','val@ver.com'),
('Giovanni','Pasqua','+2919829813',null),
('Lorenzo','Di Caterino','+449813312','lor@dic.com'),
('Marco','Cassano','+151241239',null);

INSERT INTO Dipendenti (nome, cognome, posizione, telefono, email, albergoRIF) VALUES 
    ('Marco', 'Rossi', 'receptionist', '333-1234567', 'marco.rossi@example.com', 1),
    ('Giulia', 'Bianchi', 'personale delle pulizie', '333-2345678', NULL, 2),
    ('Luca', 'Verdi', 'manager', '333-3456789', 'luca.verdi@example.com', 3),
    ('Anna', 'Neri', 'personale delle pulizie', '333-4567890', NULL, 4),
    ('Mario', 'Bianco', 'receptionist', '333-5678901', 'mario.bianco@example.com', 1),
    ('Giovanna', 'Gialli', 'manager', '333-6789012', NULL, 2),
    ('Francesco', 'Rosa', 'receptionist', '333-7890123', 'francesco.rosa@example.com', 3),
    ('Laura', 'Viola', 'receptionist', '333-8901234', NULL, 4);

INSERT INTO Facilities(nome,descrizione,orario_apertura,orario_chiusura,albergoRIF) VALUES
('piscina','bella','12:00:00','21:00:00',1),
('piscina','molto bella','08:00:00','19:00:00',1),
('spa','bellissima','13:00:00','23:00:00',2),
('palestra','incredibile','07:00:00','21:00:00',3),
('palestra','straordinaria','06:30:00','23:00:00',4);

INSERT INTO Prenotazione (check_in, check_out, cameraRIF, clienteRIF) 
VALUES 
    ('2024-03-15', '2024-03-20', 1, 1),
	('2024-03-15', '2024-03-20', 1, 1),
    ('2024-03-25', '2024-03-30', 2, 2),
    ('2024-04-05', '2024-04-10', 3, 3),
    ('2024-04-15', '2024-04-20', 4, 4);



INSERT INTO Prenotazione (check_in, check_out, cameraRIF, clienteRIF) VALUES     ('2025-03-15', '2025-03-20', 1, 1);

/*
-Prenotare la stessa stanza in date diverse dallo stesso cliente V
-Prenotare due stanze con lo stesso numero in alberghi diversi nella stessa data V
-Inserire due stanze con stesso numero in alberghi diversi con caratteristiche diverse V
-Prenotare la stessa stanza nelle stesse date X 
*/
--1
SELECT * FROM Cliente c INNER JOIN Prenotazione p ON c.clienteID=p.clienteRIF INNER JOIN Camera ca ON p.cameraRIF=ca.cameraID WHERE c.clienteID=1; 
--2
SELECT * FROM Cliente c INNER JOIN Prenotazione p ON c.clienteID=p.clienteRIF INNER JOIN Camera ca ON p.cameraRIF=ca.cameraID WHERE ca.numero=109;



