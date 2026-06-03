-- Actividad 6.4

-- Insertar en la tabla ventas el registro
INSERT INTO ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_toal) VALUES
(11, 6, now(), 289.50, 60.80, 350.30);

-- Insertar en la tabla lineasventas los registros
INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe) VALUES
(11, 1, 11, 0.21, 5, 30, 150),
(11, 2, 12, 0.21, 10, 13, 130),
(11, 3, 15, 0.21, 1, 9.5, 9.50);

-- Actualizar la direccion del cliente
-- id cliente = 5
UPDATE clientes 
SET 
    direccion = 'Pollígono Ansu Fati, Calle Messi, Nave 20'
WHERE
    nif = '23124234G';
    
-- Añadirle a Oscar Wilde el premio planeta
SELECT id from autores where nombre = 'Oscar Wilde';

UPDATE autores 
SET 
    premios = CONCAT(premios, ', Planeta')
WHERE
    id = 2;
    
-- Decrementa el precio de venta de todos los libros en un 10%
UPDATE libros 
SET 
    precio_venta = precio_venta * 0.9;

-- Incrementar el precio de costo de todos los libros de Alfaguara y Anaya en un 10%
SELECT id FROm editoriales WHERE nombre = 'Alfaguara';
SELECT id FROm editoriales WHERE nombre = 'Anaya';

UPDATE libros 
SET 
    precio_coste = precio_coste * 1.10
WHERE
    editorial_id IN (5, 6);

-- Todos los libros editados antes del año 2000 se les descuenta 2€ del precio de venta
UPDATE libros 
SET 
    precio_venta = precio_venta - 2
WHERE
    YEAR(fecha_edicion) < 2000;
    
-- Se desea eliminar la editorial Alfaguara, pero antes es necesario eliminar todos los libros de dicha editorial 
-- y a continuación eliminar la editorial Alfaguara.
SELECT id FROM editoriales WHERE nombre = 'Alfaguara';

-- Elimino todos los libros de la editorial Alfaguara
DELETE FROM libros WHERE editorial_id = 5;

-- Elimino la editorial alfaguara
DELETE FROM libros WHERE id = 5;

