-- Actividad 7.5 - Bloqueos de tablas
-- ubrique01.sql
-- Adrian Campos Espejo

-- 2.
USE geslibros;

-- 3 
LOCK TABLE clientes READ;
SELECT * FROM libros;
-- No puede acceder a otra tabla mientras tiene la tabla clientes bloqueada

-- 5
UNLOCK TABLES;

-- 7
SELECT * FROM libros;
-- No puede acceder a la tabla libros porque otro usuario la tiene bloqueada.

LOCK TABLE libros READ;
-- No podemos bloquear otra tabla que está blqueada con WRITE

-- 9

START TRANSACTION;

SELECT precio_venta FROM libros FOR UPDATE;

UPDATE libros
SET precio_venta = precio_venta * 0.7;

COMMIT;