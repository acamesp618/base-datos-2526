-- Actividad 5.4
-- Tema 5: Lenguaje SQL - DDL
-- Descripción: tipos de datos numéricos
-- Adrian Campos Espejo

-- Borro y creo la base de tados si existe y no existe respectivamente
DROP DATABASE IF EXISTS tipo_datos_string;
CREATE DATABASE IF NOT EXISTS tipo_datos_string;

-- Poner base de datos activa tipo_datos_string
USE tipo_datos_string;

-- Borro y creo la tabla tipo_datos_string
DROP TABLE IF EXISTS tipo_datos_string;
CREATE TABLE IF NOT EXISTS tipo_datos_string (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo_postal CHAR(5),
    telefono VARCHAR(20),
    apellidos VARCHAR(100),
    nombre VARCHAR(100),
    nombre_acronimo CHAR(3),
    historial TEXT,
    direccion VARCHAR(255),
    provincia VARCHAR(100),
    observaciones TEXT,
    contenido_libro LONGTEXT,
    categoria ENUM('Primera','Segunda','Tercera','Regional'),
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Añadir tres registros validos a la tabla anterior
INSERT INTO tipo_datos_num VALUES
( 
	NULL,
    '11984',
    '+34 600123456',
    'García Alcaide',
    'Luis',
    'LGA',
    'Paciente con historial sin incidencias',
    'C/ Mayor 10',
    'Madrid',
    'Alumno responsable.',
    'Contenido de ejemplo del libro 1...',
    'Primera'
),
( 
	NULL,
    '15202',
    '+34 698526458',
    'López Pérez',
    'Antonio',
    'ALP',
    'Paciente con historial con incidencias',
    'Avd España 45',
    'Segovia',
    'Alumno no responsable.',
    'Contenido de ejemplo del libro 2...',
    'Tercera'
),
( 
	NULL,
    '14550',
    '+34 648612305',
    'Campos Espejo',
    'Adrian',
    'ACE',
    'Paciente con historial sin incidencias',
    'C/ Cañitos 10',
    'Ubrique',
    'Alumno responsable.',
    'Contenido de ejemplo del libro 22...',
    'Regional'
);
    