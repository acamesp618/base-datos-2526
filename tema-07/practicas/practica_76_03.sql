-- Actividad 7.6 
-- Adrian Campos Espejo

-- 1. Crear base datos fmatematicas
DROP DATABASE IF EXISTS fmatematicas;
CREATE DATABASE IF NOT EXISTS fmatematicas;

USE fmatematicas;

-- 2. Crear la tabla angulos los valores con maxima precision
-- id, grados, radianes, seno, coseno, tangente
DROP TABLE IF EXISTS angulos;
CREATE TABLE IF NOT EXISTS angulos(
		id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        grados SMALLINT UNSIGNED, -- [0, 360]
        radianes DOUBLE(31, 30),
        seno DOUBLE(31, 30), -- [-1, 1]
        coseno DOUBLE(31, 30), -- [-1, 1]
        tangente DOUBLE  -- cualquier valor real
);

-- 3. Insertar en la tabla angulos los valores de 5 angulos (0 a 360)
-- actualizar solo la columna grados
INSERT INTO angulos (grados) VALUES (0), (30), (60), (180), (270);
INSERT INTO angulos (grados) VALUES (358), (195), (48), (205), (302);

-- 4. Actualizar la columna radianes a partir de la columna grados añadida en el apartado anterior
UPDATE angulos SET radianes = RADIANS(grados);

-- 5. Actualizar las columnas seno, coseno y tangente a partir de la columna radianes actualizada en el apartado anterior
UPDATE angulos SET seno = SIN(grados), coseno = COS(grados), tangente = TAN(grados);

-- 6. Obtener un valor entre [1, 10]
SELECT CEILING(RAND() * 10);

-- 7. Obtener un valor entre [0, 9]
SELECT FLOOR(RAND() * 10);

-- 8.  Obtener un valor entre [0, 4]
SELECT FLOOR(RAND() * 5);

-- 9. Obtener un valor entre [0, 100000]
SELECT FLOOR(RAND() * 1000001);