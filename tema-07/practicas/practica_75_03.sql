-- Actividad 7.5 - Bloqueos de tablas
-- Adrian Campos Espejo

-- 1. Crear Usuarios
CREATE USER ubrique01@localhost IDENTIFIED BY 'ubrique01';
CREATE USER arcos01@localhost IDENTIFIED BY 'arcos01';

GRANT ALL PRIVILEGES ON *.* TO ubrique01@localhost, arcos01@localhost;



