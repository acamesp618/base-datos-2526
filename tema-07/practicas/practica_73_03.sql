-- Actividad 7.3 - Revocar privilegios
-- Adrian Campos Espejo

-- 1. Revocar a juan todos los privilegios globales
REVOKE ALL PRIVILEGES ON *.* FROM juan@localhost;

-- 2. Revocar a pedro SELECT sobre geslibros
REVOKE SELECT ON geslibros.* FROM pedro@localhost;

-- 3. Revocar a maria ALTER, CREATE y UPDATE en ambas BD
REVOKE ALTER, CREATE, UPDATE ON gestlibros.* FROM maria@ocalhost;
REVOKE ALTER, CREATE, UPDATE ON maratoon.* FROM maria@localhost;

-- 4. Revocar a roberto GRANT OPTION
REVOKE GRANT OPTION ON *.* FROM roberto@localhost;

-- 5. Revocar a rocio INSERT sobre geslibros
REVOKE INSERT ON geslibros.* FROM rocio@localhost;

-- 6. Revocar a carlos privilegios sobre editoriales y clientes + UPDATE
REVOKE SELECT, UPDATE ON geslibros.editoriales FROM carlos@localhost;
REVOKE SELECT, UPDATE ON geslibros.clientes FROM carlos@localhost;

-- (Opcional, por si el profesor lo quiere explícito)
REVOKE UPDATE ON geslibros.libros FROM carlos@localhost;

-- 7. Revocar a anamari SELECT sobre columnas de libros
REVOKE SELECT (titulo, ean, isbn, precio_venta)
ON geslibros.libros
FROM anamari@localhost;

-- 8. Revocar a anamari SELECT sobre columnas de clientes
REVOKE SELECT (nombre, telefono, email)
ON geslibros.clientes
FROM anamari@localhost;

FLUSH PRIVILEGES;