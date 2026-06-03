-- Actividad 7.2 - Privilegios
-- Adrian Campos Espejo

-- 1. Asignar al usuario juan todos los privilegios a nivel global.
GRANT ALL PRIVILEGES ON *.* TO juan@localhost;

-- 2. Asignar al usuario pedro el privilegio de poder acceder a todas las bases de datos pero sólo para consultar (SELECT)
GRANT SELECT ON *.* TO pedro@localhost;

-- 3. Asignar al usuario maria privilegios de acceso a las bases de datos gestlibros y maratoon sólo para ejecutar los comandos ALTER, CREATE, UPDATE Y SELECT.
GRANT ALTER, CREATE, UPDATE, SELECT ON gestlibros.* TO maria@localhost;
GRANT ALTER, CREATE, UPDATE, SELECT ON maratoon.* TO maria@localhost;

-- 4. Asignar  al nuevo usuario roberto/roberto_67 privilegios de super administrador.
SELECT PASSWORD('roberto_67');
GRANT ALL PRIVILEGES ON *.* TO roberto@localhost IDENTIFIED BY PASSWORD '*2CB6C49482DD8DF7E3E3AE449124FB204AED0B60' WITH GRANT OPTION;

-- 5. Asignar al nuevo usuario rocio/rocio_69 todos los privilegios sobre la base de datos geslibros
SELECT PASSWORD('rocio_69');
GRANT ALL PRIVILEGES ON geslibros.* TO rocio@localhost IDENTIFIED BY PASSWORD '*0A84C19C8F32CDA6CF277B04E6B9914A0CDB6861';


-- 6. Asignar al nuevo usuario carlos/carlos_90 privilegios sobre la tabla libros, editoriales y clientes de la base de datos geslibros, además sólo podrá realizar consultas y actualizaciones.
SELECT PASSWORD('carlos_90');
GRANT SELECT, UPDATE ON geslibros.libros TO carlos@localhost IDENTIFIED BY PASSWORD '*183FCBA8D467B44FC730C7E855D1E449173B7953';
GRANT SELECT, UPDATE ON geslibros.editoriales TO carlos@localhost; 
GRANT SELECT, UPDATE ON geslibros.clientes TO carlos@localhost;


-- 7. Asignar al nuevo usuario anamari/anamari_2000 privilegios para acceder a las columnas titulo, ean, isbn y precio_venta de la tabla libros de la base de datos geslibros sólo para consultar.
SELECT PASSWORD('anamari_2000');
GRANT SELECT(titulo, ean, isbn, precio_venta) ON geslibros.libros TO anamari@localhost IDENTIFIED BY PASSWORD '*0F1CAA38ACA63FC76B441DDD3C92DF6238817833';


-- 8. Asignar al usuario anamari privilegios para acceder a las columnas nombre, telefono, email de la tabla clientes de la base de datos geslibros sólo para consultar y actualizar.
GRANT SELECT(nombre, telefono, email), UPDATE(nombre, telefono, email) ON geslibros.clientes TO anamari@localhost;

FLUSH PRIVILEGES;