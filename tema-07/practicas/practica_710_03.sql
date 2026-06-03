-- Actividad 7.10 - Importarción, Exportación de Datos y Copias de Seguridad
-- Adrian Campos Espejo

-- 1. Accede usuario root a modo consola

mysql -h localhost  -u root

-- 2. Comandos sql
show databases;
use geslibros;
show tables;
select host, user, password from mysql.user;
show grants for root@localhost;
show grants for current_user();
show privileges;

-- 3. Crear usuario
CREATE USER lopez@localhost identified by '123456';
GRANT CREATE, ALTER, UPDATE ON maratoon.corredores TO lopez@localhost;

-- 4. Cambiar password usuario anterior
SET PASSWORD FOR lopez@localhost = PASSWORD('654321');

-- 5. Transacción sobre la base de datos geslibros
START TRANSACTION;
UPDATE libros SET precio_venta = precio_venta * 1.10;
SELECT * FROM libros;
ROLLBACK;

-- 6. Operaciones de bloqueto de tablas sobre geslibros
LOCK TABLE libros READ;
-- SELECT * FROM autores;  (NO se ejecuta)
UNLOCK TABLES;
SELECT * FROM autores;

-- 7. Operaciones
START TRANSACTION;
SELECT * FROM clientes WHERE provincia_id = 11 LOCK IN SHARE MODE;
SELECT * FROM clientes WHERE provincia_id <> 11;
COMMIT;

-- 8. Operaciones en Maratoon
USE maratoon;
UPDATE Corredores SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, NOW());
-- Mostrar corredores
SELECT 
    c.id,
    c.Apellidos,
    c.Nombre,
    c.Edad,
    cl.Nombre AS Club,
    cat.Nombre AS Categoria
FROM
Corredores c
JOIN Clubs cl ON c.club_id = cl.id
JOIN Categorias cat ON c.categoria_id = cat.id;

-- 9. Exportar csv (Villamartin)
SELECT * FROM corredores
WHERE ciudad = 'Villamartín'
INTO OUTFILE 'C:/villamartin.csv' 
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 10. Salir
exit;

-- 11. Copia de seguridad base de datos maratoon
mysqldump -u root -p maratoon > maratoon.sql

-- 12. Copia de seguridad de todas las base de datos
mysqldump -u root -p --all-databases > alldatabases.sql

-- 13. Exportar base de datos empresa en formato xml
mysqldump -u root -p --xml empresa > empresa.xml