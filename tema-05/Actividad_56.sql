-- Actividad 5.6
-- Tema 5: Lenguaje SQL - DDL
-- Descripción: tipos de datos numéricos
-- Adrian Campos Espejo

-- Uso la base de datos de testeo
USE test;

DROP TABLE IF EXISTS alumnos;
CREATE TABLE IF NOT EXISTS alumnos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    dni CHAR(9) UNIQUE NOT NULL,
    fecha_nac DATE NOT NULL,
    edad TINYINT UNSIGNED NOT NULL,
    poblacion VARCHAR(20) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    cpostal SMALLINT(5) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    nacionalidad VARCHAR(20) NOT NULL,
    telefono VARCHAR(13) UNIQUE NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS articulos;
CREATE TABLE IF NOT EXISTS articulos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    referencia VARCHAR(20) NOT NULL,
    precio_coste DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    descuento TINYINT UNSIGNED DEFAULT 0,
    imagen VARCHAR(255),
    categoria VARCHAR(30),
    stock INT UNSIGNED DEFAULT 0,
    stock_min INT UNSIGNED DEFAULT 0,
    stock_max INT UNSIGNED DEFAULT 0
);

DROP TABLE IF EXISTS registro_llegadas;
CREATE TABLE IF NOT EXISTS registro_llegadas(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_hora_salida DATETIME NOT NULL,
    fecha_hora_llegada DATETIME NOT NULL,
    tiempo_realizado TIME NOT NULL,
    id_corredor INT UNSIGNED
);