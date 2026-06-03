-- Actividad 5.3
-- Tema 5: Lenguaje SQL - DDL
-- Descripción: tipos de datos numéricos
-- Adrian Campos Espejo

-- Borro y creo la base de tados si existe y no existe respectivamente
DROP DATABASE IF EXISTS tipo_datos;
CREATE DATABASE IF NOT EXISTS tipo_datos;

-- Poner base de datos activa tipo_datos
USE tipo_datos;

-- Borro y creo la tabla tipo_datos_num
DROP TABLE IF EXISTS tipo_datos_num;
CREATE TABLE IF NOT EXISTS tipo_datos_num (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    num_camiseta TINYINT UNSIGNED,
    diferencia_goles SMALLINT,
    goles_afavor SMALLINT UNSIGNED,
    goles_encontra SMALLINT UNSIGNED,
    num_habitantes INT UNSIGNED,
    humedad FLOAT(3,2) UNSIGNED,
    precipitaciones TINYINT UNSIGNED,
    temperatura_maxima FLOAT(4,2),
    temperatura_minima FLOAT(4,2),
    velocidad_viento SMALLINT UNSIGNED,
    altura SMALLINT UNSIGNED,
    precio DECIMAL(10,2),
    sueldo DECIMAL(10,2),
    seno DOUBLE(30,29),
    coseno DOUBLE(30,29),
    tangente SMALLINT UNSIGNED
) CHARACTER SET = 'UTF8MB4' COLLATE = 'UTF8MB4_GENERAL_CI';

-- Añadir tres registros validos a la tabla anterior
INSERT INTO tipo_datos_num VALUES
(
	NULL,
    34,
    -5,
    56,
    45,
    345000,
    0.90,
    300,
    45.56,
    -12.78,
    500,
    10000,
    45.67,
    45000,
    0.5678,
    0.785,
    34
),
(
	NULL,
    23,
    -7,
    12,
    35,
    15200,
    0.72,
    175,
    42.18,
    -3.50,
    462,
    8325,
    69.99,
    12000,
    0.4698,
    0.125,
    22
),
(
	NULL,
    10,
    -7,
    26,
    75,
    189999,
    0.37,
    25,
    36.00,
    5.78,
    300,
    5362,
    29.99,
    20500,
    0.854,
    0.632,
    44
);