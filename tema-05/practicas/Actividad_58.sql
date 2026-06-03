-- Actividad 5.8
-- Tema 5: Lenguaje SQL - DDL
-- Descripción: tipos de datos numéricos
-- Adrian Campos Espejo

-- Borro y creo la base de tados si existe y no existe respectivamente
DROP DATABASE IF EXISTS horarios;
CREATE DATABASE IF NOT EXISTS horarios;

-- Poner base de datos activa tipo_datos_string
USE horarios;

-- Creamos la tabla departamentos
DROP TABLE IF EXISTS departamentos;

CREATE TABLE departamentos (
    id INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    cod_departamento CHAR(3) NOT NULL,

    -- Claves
    CONSTRAINT pk_departamentos PRIMARY KEY (id),
    CONSTRAINT uk_cod_departamento UNIQUE (cod_departamento)
);


-- Creamos la tabla profesor
DROP TABLE IF EXISTS profesor;

CREATE TABLE profesor (
    id INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    email VARCHAR(60),
    fecha_ingreso DATE NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    nrp VARCHAR(20) NOT NULL,
    departamento_id INT UNSIGNED NOT NULL,

    -- Claves
    CONSTRAINT pk_profesor PRIMARY KEY (id),
    CONSTRAINT uk_email UNIQUE (email),
    CONSTRAINT uk_nrp UNIQUE (nrp),
    CONSTRAINT fk_profesor_departamento 
        FOREIGN KEY (departamento_id) 
        REFERENCES departamentos(id)
);


-- Creamos la tabla asignatura
DROP TABLE IF EXISTS asignatura;

CREATE TABLE asignatura (
    id INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    nivel CHAR(4) NOT NULL,
    cod_asignatura CHAR(7) NOT NULL,
    horas SMALLINT UNSIGNED NOT NULL,
    departamento_id INT UNSIGNED NOT NULL,

    -- Claves
    CONSTRAINT pk_asignatura PRIMARY KEY (id),
    CONSTRAINT uk_cod_asignatura UNIQUE (cod_asignatura),
    CONSTRAINT fk_asignatura_departamento 
        FOREIGN KEY (departamento_id) 
        REFERENCES departamentos(id)
);


-- Creamos la tabla horario
DROP TABLE IF EXISTS horario;

CREATE TABLE horario (
    id INT UNSIGNED AUTO_INCREMENT,
    profesor_id INT UNSIGNED NOT NULL,
    dia TINYINT UNSIGNED NOT NULL,
    tramo TINYINT UNSIGNED NOT NULL,
    turno TINYINT UNSIGNED NOT NULL,
    asignatura_id INT UNSIGNED NOT NULL,
    horas TINYINT UNSIGNED NOT NULL,

    -- Claves
    CONSTRAINT pk_horario PRIMARY KEY (id),

    CONSTRAINT fk_horario_profesor 
        FOREIGN KEY (profesor_id) 
        REFERENCES profesor(id),

    CONSTRAINT fk_horario_asignatura 
        FOREIGN KEY (asignatura_id) 
        REFERENCES asignatura(id),

    -- Restricciones de dominio
    CONSTRAINT chk_dia CHECK (dia BETWEEN 1 AND 5),
    CONSTRAINT chk_tramo CHECK (tramo BETWEEN 1 AND 6),
    CONSTRAINT chk_turno CHECK (turno IN (1, 2))
);
