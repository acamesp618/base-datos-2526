-- Examen Tema 7
-- Adrian Campos Espejo

-- 1. Crear usuarios
-- 1.1. Password encriptado
SELECT PASSWORD('RUIgt_123');

CREATE USER 'munozperez_jj'@'localhost'
IDENTIFIED BY PASSWORD '*A94069CAA8868F8A29786BB0814982DD10D0A8BF';

-- 1.2. Usuario sin encriptar
CREATE USER 'usuario2'@'localhost'
IDENTIFIED BY 'abc123';

-- 1.3. Usuario con password encriptado
SELECT PASSWORD('1234567');

CREATE USER 'examen_rec_final'@'localhost'
IDENTIFIED BY PASSWORD '*6A7A490FB9DC8C33C2B025A91737077A7E9CC5E5';

-- 1.4. Eliminar usuario
DROP USER 'examen_rec_final'@'localhost';

-- 2. Asignación de privilegios

GRANT ALL PRIVILEGES
ON *.*
TO 'munozperez_jj'@'localhost'
WITH GRANT OPTION;

