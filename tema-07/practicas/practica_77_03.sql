-- Actividad 7.7 - Funciones Cadena Caracteres
-- Adrian Campos Espejo

USE empresa;

-- 1. Añadir apellidos
-- Añadir segundo apellido dentro de la  tabla apellidos
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Pérez') WHERE id = 1;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' García') WHERE id = 2;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' López') WHERE id = 3;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Sánchez') WHERE id = 4;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Torres') WHERE id = 5;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Ruiz') WHERE id = 6;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Díaz') WHERE id = 7;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Moreno') WHERE id = 8;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Navarro') WHERE id = 9;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Romero') WHERE id = 10;
UPDATE empleados SET apellidos = CONCAT(apellidos, ' Gil') WHERE id = 11;

-- 2. Consulta
-- Mostrar columna nombre completo con 2 apellidos, nombre
SELECT id, nss, CONCAT(apellidos, ', ', nombre) AS nombre_completo FROM empleados;

-- 3. Consulta
-- Mostrar cada apellido en columnas independientes
SELECT id, nss, nombre, SUBSTRING_INDEX(apellidos, '', 1) AS apellido1, SUBSTRING_INDEX(apellidos, ' ', -1) AS apellido2 FROM empleados;

-- 4. Consulta
-- Mostrar orden invertido (estado, provincia, ciudad, codigo postal)
SELECT id, nombre, apellidos, nss, SUBSTRING_INDEX(direccion, ',', -1) AS estado, SUBSTRING_INDEX(SUBSTRING_INDEX(direccion, ',', -2), ',', 1) AS ciudad, SUBSTRING_INDEX(direccion, ',', 1) AS codpostal FROM empleados;

-- 5. Crear codigo
SELECT 
    id,
    apellidos,
    nombre,
    nss,
    CONCAT(RIGHT(nss, 3),
            '/',
            UPPER(LEFT(nombre, 2)),
            UPPER(LEFT(SUBSTRING_INDEX(apellidos, ' ', 1),
                        2)),
            UPPER(LEFT(SUBSTRING_INDEX(apellidos, ' ', - 1),
                        2))) AS codigo_generado
FROM
    empleados;