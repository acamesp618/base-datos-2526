-- Crear usuarios
SELECT PASSWORD ('juan_01');
CREATE USER juan@localhost identified by password '*DBEA713660EAA6053C71DCAD75AFBC96A73ECA0F';

SELECT PASSWORD ('pedro_01');
CREATE USER pedro@localhost identified by password '*63058EE0D2496A67E1B947A59809A732758516FF';

SELECT PASSWORD ('maria_03');
CREATE USER maria@localhost identified by password '*610163669DEF78BB9ABD9FF46C482F1235C7B03D';

SELECT PASSWORD ('miguel_04');
CREATE USER miguel@localhost identified by password '*FD1C9AE91857DAED605342CF3B9B1EBA5B1E4A46';

SELECT PASSWORD ('rocio_05');
CREATE USER rocio@localhost identified by password '*8D4F0AFD37706EF85EE95411E70503B0C33027DF';

-- CREAR USUARIO TABLA mysql.user
SELECT PASSWORD ('roberto_79');
INSERT mysql.user (host, user, password) values
('localhost', 'roberto', '*BDED085F21F711E7B0673C5ABC5AEFE6F342FAF5');

-- Este comando da error por mala práctica
-- Motivos: Insertar directamente en mysql.user es inseguro y no recomendado

-- Eliminar usuarios
DROP USER miguel@localhost;
DROP USER rocio@localholst;