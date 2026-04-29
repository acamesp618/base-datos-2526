DROP DATABASE IF EXISTS gimnasio;
CREATE DATABASE gimnasio;
USE gimnasio;

-- Tabla Socios
DROP TABLE IF EXISTS socios;
CREATE TABLE IF NOT EXISTS socios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni CHAR(9) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(15),
    tipo_suscripcion ENUM('mensual','trimestral','anual') NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

-- Tabla Entrenadores
DROP TABLE IF EXISTS entrenadores;
CREATE TABLE IF NOT EXISTS entrenadores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(15),
    especialidad VARCHAR(100)
);

-- Tabla Salas
DROP TABLE IF EXISTS salas;
CREATE TABLE IF NOT EXISTS salas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    capacidad INT UNSIGNED NOT NULL
);

-- Tabla Clases
DROP TABLE IF EXISTS clases;
CREATE TABLE IF NOT EXISTS clases (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    horario VARCHAR(50),
    aforo_max INT UNSIGNED,
    entrenador_id INT UNSIGNED NOT NULL,
    sala_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (entrenador_id) REFERENCES entrenadores(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (sala_id) REFERENCES salas(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Tabla Maquinas
DROP TABLE IF EXISTS maquinas;
CREATE TABLE IF NOT EXISTS maquinas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion TEXT,
    sala_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (sala_id) REFERENCES salas(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Tabla Pagos
DROP TABLE IF EXISTS pagos;
CREATE TABLE IF NOT EXISTS pagos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_pago DATE NOT NULL,
    importe DECIMAL(8,2) NOT NULL,
    metodo_pago ENUM('efectivo','tarjeta','transferencia') NOT NULL,
    estado ENUM('pendiente','pagado','cancelado') NOT NULL DEFAULT 'pendiente',
    socio_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (socio_id) REFERENCES socios(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Tabla Inscripciones
DROP TABLE IF EXISTS inscripciones;
CREATE TABLE IF NOT EXISTS inscripciones (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE,
    descripcion TEXT,
    socio_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (socio_id) REFERENCES socios(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Tabla Socios_Clase
DROP TABLE IF EXISTS socios_clases;
CREATE TABLE IF NOT EXISTS socios_clases (
    socios_id INT UNSIGNED NOT NULL,
    clases_id INT UNSIGNED NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    asistencia ENUM('asistio','no_asistio') DEFAULT NULL,
    fecha_finalizacion DATE,
    activo BOOLEAN NOT NULL,
    PRIMARY KEY (socios_id, clases_id),
    FOREIGN KEY (socios_id) REFERENCES socios(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (clases_id) REFERENCES clases(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);
