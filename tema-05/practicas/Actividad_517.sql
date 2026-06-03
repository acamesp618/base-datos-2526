-- Actividad 5.17
-- Tema Lenguaje SQL - DDL
-- Modulo Base de Datos
-- Curso 25/26
-- Nombre: Adrian Campos Espejo

-- Creacion de la base de datos
DROP DATABASE IF EXISTS gestion_comercial;
CREATE DATABASE IF NOT EXISTS gestion_comercial;

-- Usar base de datos proyectos
USE gestion_comercial;

-- Crear tabla clientes
DROP TABLE IF EXISTS Departamentos;
CREATE TABLE IF NOT EXISTS Departamentos (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    funcion VARCHAR(100)
);

-- Crear tabla categorias
DROP TABLE IF EXISTS Categorias;
CREATE TABLE IF NOT EXISTS Categorias (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    salarioBase DECIMAL(10.2) NOT NULL
);

-- Crear tabla empleados
DROP TABLE IF EXISTS Empleados;
CREATE TABLE IF NOT EXISTS Empleados (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    dir VARCHAR(100),
    poblacion VARCHAR(50),
    email VARCHAR(100),
    telefono VARCHAR(20),
    dni CHAR(9) UNIQUE NOT NULL,
    nss VARCHAR(12) UNIQUE NOT NULL,
    idDepartamento INT UNSIGNED,
    idCategoria INT UNSIGNED,
    FOREIGN KEY (idDepartamento) REFERENCES Departamentos(id),
    FOREIGN KEY (idCategoria) REFERENCES Categorias(id)
);

-- Crear tabla almacen
DROP TABLE IF EXISTS Almacen;
CREATE TABLE IF NOT EXISTS Almacen (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ubicacion VARCHAR(100),
    idEmpleado INT UNSIGNED,
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(id)
);

-- Crear tabla estante
DROP TABLE IF EXISTS Estante;
CREATE TABLE IF NOT EXISTS Estante (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idAlmacen INT UNSIGNED NOT NULL,
    descripcion VARCHAR(255),
    FOREIGN KEY (idAlmacen) REFERENCES Almacen(id)
);

-- Crear tabla familias
DROP TABLE IF EXISTS Familias;
CREATE TABLE IF NOT EXISTS Familias (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

-- Crear tabla articulos
DROP TABLE IF EXISTS Articulos;
CREATE TABLE IF NOT EXISTS Articulos (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigoInterno VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(255),
    precioCoste DECIMAL(10.2),
    unidades INT UNSIGNED,
    idAlmacen INT UNSIGNED,
    idEstante INT UNSIGNED,
    idFamilia INT UNSIGNED,
    FOREIGN KEY (idAlmacen) REFERENCES Almacen(id),
    FOREIGN KEY (idEstante) REFERENCES Estante(id),
    FOREIGN KEY (idFamilia) REFERENCES Familias(id)
);


