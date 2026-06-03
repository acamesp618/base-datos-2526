-- Examen UD6
-- Adrian Campos
-- Curso 2025/2026

-- Usamos base de datos geslibros
USE geslibros;

-- 1. Insertar libro
INSERT INTO libros 
(isbn, ean, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion)
VALUES 
(
 '9788408096528',
 '9788888199587',
 'El Retrato de Dorian Gray',
 (SELECT id FROM autores WHERE nombre = 'Oscar Wilde'),
 (SELECT id FROM editoriales WHERE nombre LIKE '%Planeta%'),
 18.00,
 24.00,
 12,
 5,
 25,
 '2015-03-15'
);
-- 2. Insertar - Libros_temas
INSERT INTO libros_temas (libro_id, tema_id)
VALUES
(
 (SELECT id FROM libros WHERE isbn = '9788408096528'),
 (SELECT id FROM temas WHERE tema = 'Novela')
),
(
 (SELECT id FROM libros WHERE isbn = '9788408096528'),
 (SELECT id FROM temas WHERE tema = 'Ciencia')
);

-- 3. Insertar -Ventas
INSERT INTO ventas (cliente_id, fecha, importe_bruto, importe_iva, importe_total) 
VALUES 
(
(SELECT id FROM clientes WHERE nombre= 'CP Rio Tajo'), 
'2014-05-10', 
122.32, 
4.89, 
127.21);

-- 4. Insertar lineas ventas
INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe)
VALUES
(
 (SELECT MAX(id) FROM ventas),
 1,
 1,
 0.21,
 2,
 (SELECT precio_venta FROM libros WHERE id = 1),
 2 * (SELECT precio_venta FROM libros WHERE id = 1)
),
(
 (SELECT MAX(id) FROM ventas),
 2,
 2,
 0.21,
 1,
 (SELECT precio_venta FROM libros WHERE id = 2),
 1 * (SELECT precio_venta FROM libros WHERE id = 2)
);

-- 5. Update - Libros
UPDATE libros 
SET 
    precio_venta = precio_venta * 1.15
WHERE
    editorial_id = (SELECT 
            id
        FROM
            editoriales
        WHERE
            nombre LIKE '%Planeta%');

-- 6. Update - Libros
UPDATE libros 
SET 
    stock = stock * 0.8
WHERE
    stock > 15;

-- 7. Delete -Libros
DELETE FROM libros 
WHERE
    id IN (SELECT 
        libro_id
    FROM
        libros_temas
            JOIN
        temas ON libros_temas.tema_id = temas.id
    
    WHERE
        temas.tema = 'Viajes');

-- 8. Script - clientes
SELECT 
    clientes.id,
    clientes.nombre,
    clientes.direccion,
    clientes.c_postal,
    clientes.nif,
    clientes.telefono,
    clientes.email
FROM
    clientes
        JOIN
    provincias ON clientes.provincia_id = provincias.id
WHERE
    clientes.email LIKE '%@gmail.com'
        AND provincias.provincia = 'Guadalajara'
ORDER BY clientes.nombre;

-- 9. Script - ventas
SELECT 
    ventas.id,
    clientes.nombre,
    ventas.fecha,
    ventas.importe_bruto,
    ventas.importe_iva,
    ventas.importe_total
FROM
    ventas
        JOIN
    clientes ON ventas.cliente_id = clientes.id
WHERE
    YEAR(ventas.fecha) = 2013
ORDER BY ventas.importe_total ASC
LIMIT 5;

-- 10. Script - libros
SELECT 
    libros.id,
    libros.titulo,
    autores.nombre,
    editoriales.nombre,
    libros.stock,
    libros.precio_coste,
    libros.precio_venta
FROM
    libros
        JOIN
    autores ON libros.autor_id = autores.id
        JOIN
    editoriales ON libros.editorial_id = editoriales.id
WHERE
    libros.stock < 20
        AND YEAR(libros.fecha_edicion) = 2014
ORDER BY libros.titulo;

-- 11. Script - libros
SELECT 
    libros.id,
    libros.titulo,
    autores.nombre,
    editoriales.nombre,
    temas.tema,
    libros.precio_coste,
    libros.precio_venta
FROM
    libros
        JOIN
    autores ON libros.autor_id = autores.id
        JOIN
    editoriales ON libros.editorial_id = editoriales.id
        JOIN
    libros_temas ON libros.id = libros_temas.libro_id
        JOIN
    temas ON libros_temas.tema_id = temas.id
WHERE
    temas.tema = 'Novela'
        AND libros.precio_venta > 20
ORDER BY libros.titulo;

-- 12. Script - libros
SELECT 
    libros.id,
    libros.titulo,
    autores.nombre,
    editoriales.nombre,
    libros.precio_venta
FROM
    libros
        JOIN
    autores ON libros.autor_id = autores.id
        JOIN
    editoriales ON libros.editorial_id = editoriales.id
WHERE
    libros.precio_venta > (SELECT 
            AVG(precio_venta)
        FROM
            libros)
ORDER BY libros.precio_venta DESC;

-- 13. Script - ventas
SELECT 
    clientes.id,
    clientes.nombre,
    COUNT(ventas.id) AS num_ventas,
    SUM(ventas.importe_total) AS total_facturado
FROM
    clientes
        JOIN
    ventas ON clientes.id = ventas.cliente_id
GROUP BY clientes.id , clientes.nombre
ORDER BY num_ventas DESC;

-- 14. Script - estadisticas de ventas por libro
SELECT 
    libros.id,
    libros.titulo,
    SUM(lineasventas.cantidad) AS unidades_vendidas,
    SUM(lineasventas.importe) AS importe_total,
    AVG(lineasventas.precio) AS precio_medio
FROM
    libros
        JOIN
    lineasventas ON libros.id = lineasventas.libro_id
GROUP BY libros.id , libros.titulo
ORDER BY importe_total DESC;