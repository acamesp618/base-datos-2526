-- Actividad 5.15
-- Tema Lenguaje SQL - DDL
-- Modulo Base de Datos
-- Curso 25/26
-- Nombre: Adrian Campos Espejo

-- Creacion de la base de datos
DROP DATABASE IF EXISTS proyectos;
CREATE DATABASE IF NOT EXISTS proyectos;

-- Usar base de datos proyectos
USE proyectos;

-- Crear tabla clientes
DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    nif CHAR(9) UNIQUE NOT NULL
);

-- Crear la tabla Telefonos de clientes
DROP TABLE IF EXISTS telefonos_clientes;
CREATE TABLE IF NOT EXISTS telefonos_clientes(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED NOT NULL,
    telefono CHAR(9) NOT NULL,
    UNIQUE(cliente_id, telefono),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear la tabla empleados
DROP TABLE IF EXISTS empleados;
CREATE TABLE IF NOT EXISTS empleados (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    dni CHAR(9) UNIQUE NOT NULL,
    proyecto_id INT UNSIGNED,
    supervisor_id INT UNSIGNED
    -- las restricciones FOREIGN KEY se añaden al final
    -- mediante ALTER TABLE
);

-- Crear la tabla Telefonos empleados
DROP TABLE IF EXISTS telefonos_empleados;
CREATE TABLE IF NOT EXISTS telefonos_empleados(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT UNSIGNED NOT NULL,
    telefono CHAR(9) NOT NULL,
    UNIQUE(empleado_id, telefono),
    FOREIGN KEY (empleado_id) REFERENCES empleados(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear la tabla Beneficiarios
DROP TABLE IF EXISTS beneficiarios;
CREATE TABLE IF NOT EXISTS beneficiarios(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    empleado_id INT UNSIGNED,
    FOREIGN KEY (empleado_id) REFERENCES empleados(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear la tabla proyectos
DROP TABLE IF EXISTS proyectos;
CREATE TABLE IF NOT EXISTS proyectos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proyecto VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    presupuesto DECIMAL(10,2),
    cliente_id INT UNSIGNED,
    jefe_id INT UNSIGNED,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY(jefe_id) REFERENCES empleados(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Crear la tabla proyectos_empleados
DROP TABLE IF EXISTS proyectos_empleados;
CREATE TABLE IF NOT EXISTS proyectos_empleados(
	empleado_id INT UNSIGNED NOT NULL,
    proyecto_id INT UNSIGNED NOT NULL,
    horas SMALLINT UNSIGNED,
    valoracion VARCHAR(255),
    f_inicio DATE,
    f_fin DATE,
    PRIMARY KEY(empleado_id, proyecto_id),
    FOREIGN KEY(empleado_id) REFERENCES empleados(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY(proyecto_id) REFERENCES proyectos(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla empleados restricciones FOREIGN KEY
ALTER TABLE empleados
ADD CONSTRAINT FK_proyecto_id_empleados FOREIGN KEY(proyecto_id) REFERENCES proyectos(id)
ON DELETE RESTRICT ON UPDATE CASCADE,
ADD CONSTRAINT FK_supervisor_id_empleados FOREIGN KEY(supervisor_id) REFERENCES empleados(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Añadir columnas con tipo de datos y restricciones a vuestro criterio:
ALTER TABLE clientes
ADD COLUMN apellidos VARCHAR(60),
ADD COLUMN poblacion VARCHAR(30),
ADD COLUMN nacionalidad VARCHAR(30) DEFAULT 'Española',
ADD COLUMN email VARCHAR(60) UNIQUE NOT NULL,
ADD COLUMN direccion VARCHAR(60),
ADD COLUMN cod_cliente CHAR(7) DEFAULT 'ES/001',
ADD COLUMN tipo_cliente TINYINT UNSIGNED CHECK (tipo_cliente BETWEEN 0 AND 10);

-- Realizar las siguientes modificaciones sobre columnas:
ALTER TABLE clientes
MODIFY COLUMN nombre VARCHAR(25) NOT NULL,
MODIFY COLUMN apellidos VARCHAR(45) NOT NULL,
MODIFY COLUMN direccion VARCHAR(100),
MODIFY COLUMN nacionalidad VARCHAR(30) DEFAULT 'España',
CHANGE COLUMN email correo_electronico_clientes VARCHAR(60) UNIQUE,

-- Añadir las siguientes restricciones:
ADD CONSTRAINT ch_correo_electronico_clientes CHECK (correo_electronico LIKE '%@%');

-- Añadir indice sobre las columnas apellidos, nombre
CREATE INDEX In_ApellidoNombre_clientes ON clientes (apellidos, nombre);

-- Mostrar todos los indices creados para la tabla clientes
SHOW INDEX IN clientes;


