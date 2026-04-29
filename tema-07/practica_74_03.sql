-- Actividad 7.4 - Uso transacciones
-- Adrian Campos Espejo

-- 1. Incluye en una transacción un proceso que realice las siguientes actualizaciones:

-- Todos los libros de tema Novela se ponen en oferta y se decrementa el precio en un 10%
-- Los libros de la editorial Anaya se incrementa el precio en un 6% mientras que el resto de editoriales se reduce en un 4,5%.

START TRANSACTION;
USE geslibros;
UPDATE libros SET precio_venta = precio_venta * 0.9 WHERE id IN (SELECT libro_id FROM libros_temas WHERE tema_id= (SELECT id FROM temas WHERE tema = 'Novela'));
UPDATE libros SET precio_venta = precio_venta * 1.06 WHERE editorial_id = (SELECT id FROM editoriales WHERE nombre = 'Anaya');
UPDATE libros SET precio_venta = precio_venta * 0.955 WHERE editorial_id != (SELECT id FROM editoriales WHERE nombre = 'Anaya');

-- 2. Finalizar la transacción deshaciendo las operaciones anteriores. Comprobar
ROLLBACK;
SELECT titulo, precio_venta FROM libros;

-- 3. Inicia una nueva transacción que contenga las siguientes operaciones:

-- Añadir dos nuevos libros
INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock) VALUES ('125884965215', 'Bibliografía', 5, 2, 15.90, 21.50, 7), ('18968896115', 'Bibliografía Completa', 2, 5, 15.90, 21.50, 10);

-- Añadir una venta y 3 líneas de detalle sobre esa venta
INSERT INTO ventas (cliente_id, fecha, importe_bruto, importe_iva, importe_total) VALUES (1, CURDATE(), 100, 21, 121);
SET @id_venta = last_insert_id();
INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe) VALUES (@id_venta, 1, 1, 0.21, 2, 30, 60), (@id_venta, 2, 2, 0.21, 1, 34, 34), (@id_venta, 3, 3, 0.21, 1, 38, 38);

-- 4. Finalizar la transacción confirmando las operaciones anteriores.
COMMIT;
SELECT * FROM ventas ORDER BY id DESC;

-- 5. Incluye en una transacción las siguientes operaciones sobre la base de datos geslibros:

-- Insertar dos libros
START TRANSACTION;
INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock) VALUES ('3333333333333','Libro A',1,1,10,15,5), ('4444444444444','Libro B',2,2,12,18,5);

-- Insertar dos clientes
INSERT INTO clientes (nombre, direccion, poblacion, c_postal, provincia_id, nif) VALUES ('Roberto Fernandez Lopez','Calle Santiago 72','Ubrique','28001',28,'50632698A'), ('Lucia Gonzalez Perez','Calle Tentaciones 1','Villamartín','28002',28,'30598862B');

-- Crear SAVEPOINT a
SAVEPOINT a;

-- Actualizar los precios de todos los libros en 10% de incremento
UPDATE libros SET precio_venta = precio_venta * 1.10;

-- Crear SAVEPOINT b
SAVEPOINT b;

-- Eliminar los libros no vendidos
DELETE FROM libros WHERE id NOT IN (SELECT DISTINCT libro_id FROM lineasventas);

-- Deshacer a partir del SAVEPOINT a
ROLLBACK TO a;

-- Comprobar 
SELECT * FROM libros;
SELECT * FROM clientes;