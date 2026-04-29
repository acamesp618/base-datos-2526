-- Actividad 5.5
-- Tema Lenguaje SQL - DDL
-- Modulo Base de Datos
-- Curso 25/26
-- Nombre: Adrian Campos Espejo

-- Crear tabla tipo_datos_fechas
DROP TABLE IF EXISTS tipos_datos_fechas;
CREATE TABLE IF NOT EXISTS tipo_datos_fechas (
    id INT AUTO_INCREMENT PRIMARY KEY,

    fecha_nacimiento DATE,
    fecha_hora_nacimiento DATETIME,
    hora_llegada TIME,
    hora_salida TIME,
    anno_nacimiento YEAR,
    anno_fundacion YEAR,
    fecha_hora_salida DATETIME(3),
    fecha_hora_llegada DATETIME(3),
    fecha_hora_actual DATETIME(1),
    edad INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

-- Insertar al menos 3 registros
INSERT INTO tipo_datos_fechas
(
    fecha_nacimiento,
    fecha_hora_nacimiento,
    hora_llegada,
    hora_salida,
    anno_nacimiento,
    anno_fundacion,
    fecha_hora_salida,
    fecha_hora_llegada,
    fecha_hora_actual,
    edad
)
VALUES
(
    '1990-05-12',
    '1990-05-12 08:30:15',
    '08:00:00',
    '16:00:00',
    1990,
    1985,
    '2026-01-16 16:00:00.123',
    '2026-01-16 08:00:00.456',
    '2026-01-16 10:15:30.5',
    35
),
(
    '1985-11-03',
    '1985-11-03 22:45:00',
    '09:15:00',
    '17:30:00',
    1985,
    1970,
    '2026-01-16 17:30:10.789',
    '2026-01-16 09:15:05.321',
    '2026-01-16 10:15:31.2',
    40
),
(
    '2000-01-20',
    '2000-01-20 06:10:00',
    '07:45:00',
    '15:15:00',
    2000,
    1999,
    '2026-01-16 15:15:59.999',
    '2026-01-16 07:45:10.111',
    '2026-01-16 10:15:32.8',
    25
);
