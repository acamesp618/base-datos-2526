-- Actividad 7.5 - Bloqueos de tablas
-- arcos01.sql
-- Adrian Campos Espejo

-- 2.
USE geslibros;

-- 4
SELECT * FROM clientes WHERE poblacion = 'Guadalajara';
-- Puede hacer busquedas en la tabla clientes aunque esté bloqueada 

INSERT INTO clientes (nombre, direccion, poblacion, c_postal, provincia_id, nif) 
VALUES ('Carlos Romero Jimenez','Calle Lopera 4','Guadalajara','19001',19,'30652195Z');
-- No puede insertar porque ubrique01 tiene la tabla clientes bloqueada

-- 6
SELECT * FROM clientes;
-- Permite insertar el cliente porque la tabla ha sido desbloqueada.

LOCK TABLE libros WRITE;

INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES ('5589635927412','Libro Generico',1,1,10,20,5);
-- Permite insertar un nuevo libro porque la tabla la tengo bloqueada para escribir con este usuario

-- 8
UNLOCK TABLES;

-- 9 
START TRANSACTION;

SELECT * FROM editoriales LOCK IN SHARE MODE;
SELECT * FROM autores LOCK IN SHARE MODE;

INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES 
('6963258942156','Libro T1',1,1,10,20,5),
('7965878521267','Libro T2',2,2,12,22,5);

COMMIT;

