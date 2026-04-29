-- Actividad 5.9
-- Tema 5: Lenguaje SQL - DDL
-- Descripción: tipos de datos numéricos
-- Adrian Campos Espejo

-- Borro y creo la base de tados si existe y no existe respectivamente
DROP DATABASE IF EXISTS RestriccionesDefault;
CREATE DATABASE IF NOT EXISTS RestriccionesDefault;
CHARACTER SET = "utf8" COLLATE "utf8_general_ci";

-- Poner base de datos activa RestriccionesDefault
USE RestriccionesDefault;

-- Creamos la tabla resdefault
DROP TABLE IF EXISTS resdefault;
CREATE TABLE IF NOT EXISTS resdefault (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    poblacion VARCHAR(20) DEFAULT 'Ubrique',
    provincia VARCHAR(20) DEFAULT 'Cádiz',
    nacionalidad VARCHAR(20) DEFAULT 'España',
    precio DECIMAL(10,2) DEFAULT 10.20,
    sueldo DECIMAL (10,2) DEFAULT 1500.00,
    fecha_hora_llegada DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_llegada DATE DEFAULT CURRENT_TIMESTAMP,
    hora_llegada TIME DEFAULT CURRENT_TIMESTAMP,
    casado BOOLEAN DEFAULT 1,
    carnet_conducir BOOLEAN DEFAULT 1
);

INSERT INTO resdefault () VALUES ();

INSERT INTO resdefault VALUES 
	(null, 'Sevilla', 'Sevilla', default, 20.50, default, default, default, default, 0, default);

INSERT INTO resdefault VALUES
	(null, 'Málaga', 'Málaga', 'España', 15.00, 1800.00, default, default, default, 1, 0); 
