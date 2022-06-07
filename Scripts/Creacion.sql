DROP DATABASE IF EXISTS deporteValladolid;
CREATE DATABASE deporteValladolid;


CREATE TABLE Polideportivo (
	id INT PRIMARY KEY NOT NULL,
	nombre TEXT,
	direccion TEXT,
	telefonos TEXT [],
	extension INT	
);


CREATE TYPE deporte AS ENUM ('fútbol sala', 'baloncesto', 'tenis', 'pádel', 'balonmano');
CREATE TYPE pistaEstado AS ENUM ('disponible', 'en obras');


CREATE TABLE Pista (

	idPista INT NOT NULL,
	idPolideportivo INT NOT NULL,
	deporte deporte,
	pistaEstado pistaEstado,
	precio FLOAT NOT NULL,
	ultimaReserva DATE,
	PRIMARY KEY (idPista,idPolideportivo),
	FOREIGN KEY (idPolideportivo) REFERENCES Polideportivo(id)
	
);

CREATE TABLE usuario (

	dni TEXT UNIQUE NOT NULL,
	nombre TEXT,
	apellidos TEXT,
	email TEXT,
	telefono TEXT,
	fechaNacimiento DATE NOT NULL,
	edad INT,
	antiguedad INT,
	PRIMARY KEY (dni)
);

CREATE TABLE reserva (

	id INT NOT NULL,
	fechaReserva DATE NOT NULL,
	fechaCreacion DATE NOT NULL,
	duracion INT NOT NULL,
	precio FLOAT,
	idPista INT NOT NULL,
	idPolideportivo INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (idPista,idPolideportivo) REFERENCES Pista(idPista,idPolideportivo)

);

CREATE TABLE usuarioReserva (

	idReserva INT NOT NULL,
	dni TEXT NOT NULL,
	PRIMARY KEY (idReserva,dni),
	FOREIGN KEY (idReserva) REFERENCES Reserva(id),
	FOREIGN KEY (dni) REFERENCES Usuario(dni)

);





