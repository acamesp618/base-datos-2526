-- Actividad 7.11 - Examen años anteriores
-- Adrian Campos Espejo

-- 1. Crear usuario
SELECT PASSWORD('1234567');
CREATE USER 'adriancampos'@'localhost'
IDENTIFIED BY PASSWORD '*6A7A490FB9DC8C33C2B025A91737077A7E9CC5E5';

GRANT USAGE ON *.* TO 'adriancampos'@'localhost';

-- 2. Asignacion de privilegios
-- 2.1. superadministrador
GRANT ALL PRIVILEGES ON *.* TO 'adriancampos'@'localhost' WITH GRANT OPTION;

-- 2.2. Todos los privilegios sobre geslibros
GRANT ALL PRIVILEGES ON geslibros.* TO 'adriancampos'@'localhost';

-- 2.3. Todos los privilegios sobre tablas libros, editoriales y clientes de la bbdd geslibros
GRANT ALL PRIVILEGES ON geslibros.libros TO 'adriancampos'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.editoriales TO 'adriancampos'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.clientes TO 'adriancampos'@'localhost';

-- 2.4. Asignar para que solo se pueda consultar en la tabla libros, editoriales y clientes de la bbdd geslibros
GRANT SELECT ON geslibros.libros TO 'adriancampos'@'localhost';
GRANT SELECT ON geslibros.editoriales TO 'adriancampos'@'localhost';
GRANT SELECT ON geslibros.clientes TO 'adriancampos'@'localhost';

-- 2.5. Asignar privilegios acceder a consultar y actualizar columnas nombre, direccion, población, codpostal, telefono y email
-- de la tabla clientes de bbdd geslibros
GRANT SELECT, UPDATE (nombre, direccion, poblacion, c_postal, telefono, email)
ON geslibros.clientes TO 'adriancampos'@'localhost';

-- 2.6. Asignar privilegios solo consultar columnas id, titulo, precio_venta, fechaedicion
-- actualizar la columna precio_venta y titulo de la tabla libros
GRANT SELECT (id, titulo, precio_venta, fecha_edicion),
UPDATE (precio_venta, titulo)
ON geslibros.libros TO 'adriancampos'@'localhost';

-- 2.7. Asignar todos los privilegios para acceder a todas las tablas de bbdd geslibros
-- excepto ventas y lineasventas
GRANT SELECT ON geslibros.* TO 'adriancampos'@'localhost';

REVOKE SELECT ON geslibros.ventas FROM 'adriancampos'@'localhost';
REVOKE SELECT ON geslibros.lineasventas FROM 'adriancampos'@'localhost';

-- 3. Eliminar privilegios
-- 3.1. Quitar privilegio GRANT
REVOKE GRANT OPTION ON *.* FROM 'adriancampos'@'localhost';

-- 3.2. Quitar todos los privilegios sobre todas las bases de datos
REVOKE ALL PRIVILEGES ON *.* FROM 'adriancampos'@'localhost';

-- 3.3. Quitar todos los privilegios sobre la base de datos geslibros
REVOKE ALL PRIVILEGES ON geslibros.* FROM 'adriancampos'@'localhost';

-- 3.4. Quitar el privilegio UPDATE sobre tabla libros de bbdd geslibros
REVOKE UPDATE ON geslibros.libros FROM 'adriancampos'@'localhost';

-- 3.5. Quitar el privilegio de consulta sobre las columnas id, titulo, precio_venta de la tabla libros
REVOKE SELECT (id, titulo, precio_venta)
ON geslibros.libros FROM 'adriancampos'@'localhost';

-- 3.6. Solo acceso a libros y clientes
REVOKE ALL PRIVILEGES ON geslibros.* FROM 'adriancampos'@'localhost';

GRANT SELECT ON geslibros.libros TO 'adriancampos'@'localhost';
GRANT SELECT ON geslibros.clientes TO 'adriancampos'@'localhost';

-- 3.7. Quitar SELECT, UPDATE, DELETE
REVOKE SELECT, UPDATE, DELETE ON geslibros.libros FROM 'adriancampos'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.clientes FROM 'adriancampos'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.editoriales FROM 'adriancampos'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.autores FROM 'adriancampos'@'localhost';

-- 4. Cambiar password
SELECT PASSWORD('21436587');
ALTER USER 'adriancampos'@'localhost'
IDENTIFIED BY PASSWORD '*1DEB27DD74919473A2C69FDFA8E46B08E9F16547';

-- 5. Sorteo lotería primitiva
START TRANSACTION;

INSERT INTO loteriaprimitiva.sorteos
(fecha, num1, num2, num3, num4, num5, num6, complementario, reintegro)
VALUES
(NOW(),
FLOOR(1+RAND()*49), FLOOR(1+RAND()*49), FLOOR(1+RAND()*49),
FLOOR(1+RAND()*49), FLOOR(1+RAND()*49), FLOOR(1+RAND()*49),
FLOOR(1+RAND()*49), FLOOR(RAND()*10)
),

(NOW(),
FLOOR(1+RAND()*49), FLOOR(1+RAND()*49), FLOOR(1+RAND()*49),
FLOOR(1+RAND()*49), FLOOR(1+RAND()*49), FLOOR(1+RAND()*49),
FLOOR(1+RAND()*49), FLOOR(RAND()*10)
);

COMMIT;

-- 6. Base de datos maratoon
-- 6.1. Añadir a la tabla corredores las siguientes columnas
ALTER TABLE corredores
ADD apellido1 VARCHAR(40),
ADD apellido2 VARCHAR(40),
ADD codigo CHAR(11);

-- 6.2. Separar apellidos a partir de la columna apellidos
UPDATE corredores
SET apellido1 = SUBSTRING_INDEX(apellidos, ' ', 1),
    apellido2 = SUBSTRING_INDEX(apellidos, ' ', -1);
    
-- 6.3. Actualizar columna código con criterios
-- Todo en mayuscula, año nacimiento (4 digitos), /, iniciales nombre (2), iniciales apellido1 (2), iniciales apellido2 (2)
UPDATE corredores
SET codigo = UPPER(CONCAT(
YEAR(fechanacimiento), '/',
LEFT(nombre,2),
LEFT(apellido1,2),
LEFT(apellido2,2)
));

-- 6.4. Actualizar columna edad a partir de la fecha de naciemiento
UPDATE corredores
SET edad = TIMESTAMPDIFF(YEAR, fechanacimiento, CURDATE());

-- 6.5. Categoría
UPDATE corredores SET categoria_id = 1 WHERE edad < 12;
UPDATE corredores SET categoria_id = 2 WHERE edad BETWEEN 12 AND 14;
UPDATE corredores SET categoria_id = 3 WHERE edad BETWEEN 15 AND 17;
UPDATE corredores SET categoria_id = 4 WHERE edad BETWEEN 18 AND 29;
UPDATE corredores SET categoria_id = 5 WHERE edad BETWEEN 30 AND 39;
UPDATE corredores SET categoria_id = 6 WHERE edad BETWEEN 40 AND 49;
UPDATE corredores SET categoria_id = 7 WHERE edad BETWEEN 50 AND 60;
UPDATE corredores SET categoria_id = 8 WHERE edad >= 60;

-- 6.6. Transaccion con bloqueo
START TRANSACTION;

SELECT * FROM categorias FOR UPDATE;

UPDATE corredores
SET edad = TIMESTAMPDIFF(YEAR, fechanacimiento, CURDATE());

UPDATE corredores SET categoria_id = 1 WHERE edad < 12;
UPDATE corredores SET categoria_id = 2 WHERE edad BETWEEN 12 AND 14;
UPDATE corredores SET categoria_id = 3 WHERE edad BETWEEN 15 AND 17;
UPDATE corredores SET categoria_id = 4 WHERE edad BETWEEN 18 AND 29;
UPDATE corredores SET categoria_id = 5 WHERE edad BETWEEN 30 AND 39;
UPDATE corredores SET categoria_id = 6 WHERE edad BETWEEN 40 AND 49;
UPDATE corredores SET categoria_id = 7 WHERE edad BETWEEN 50 AND 60;
UPDATE corredores SET categoria_id = 8 WHERE edad >= 60;

COMMIT;

-- 7. Exportar/Importar datos
-- 7.1. Exportar el fichero clientesUbrique.csv
SELECT * FROM clientes
WHERE poblacion = 'Ubrique'
INTO OUTFILE '/tmp/clientesUbrique.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 7.2. Exportar todos autores en el fichero autores.xml
mysqldump -h localhost -u root --xml geslibros autores>c:autores.xml


-- 7.3. Copia seguridad geslibros (datos y estructura)
mysqldump -h localhost -u root geslibros>c:geslibros.sql

-- 7.4. Crear fichero libros.csv con datos de al menos 4 libros
/*
(id, isbn,  ean, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion)
20;9780000000001;9780000000001;Libro Prueba 1;1;1;10.00;15.00;5;1;10;2024-01-01
21;9780000000002;9780000000002;Libro Prueba 2;2;2;12.00;18.00;6;1;10;2023-05-10
22;9780000000003;9780000000003;Libro Prueba 3;3;3;15.00;22.00;7;1;10;2022-03-15
23;9780000000004;9780000000004;Libro Prueba 4;4;1;20.00;30.00;8;1;10;2021-07-20
*/

-- 7.5. Importar los datos del archivo libros.csv a la tabla libros
LOAD DATA INFILE '/tmp/libros.csv'
INTO TABLE libros
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(id, isbn, ean, titulo, autor_id, editorial_id,
 precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion);