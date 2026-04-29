-- Actividad 5.7
-- Tema 5: Lenguaje SQL - DDL
-- Descripción: tipos de datos numéricos
-- Adrian Campos Espejo

-- Uso la base de datos de testeo
USE test;

DROP TABLE IF EXISTS pacientes;
CREATE TABLE IF NOT EXISTS pacientes(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    nss CHAR(9) UNIQUE NOT NULL,
    email VARCHAR(60) UNIQUE,
    telefono VARCHAR(13) UNIQUE,
    poblacion VARCHAR(20) NOT NULL,
    expediente
    dni CHAR(9) UNIQUE NOT NULL,
    historial_clinico TEXT NOT NULL,
    fecha_nac DATE NOT NULL,
    edad TINYINT UNSIGNED NOT NULL
)