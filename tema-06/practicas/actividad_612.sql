-- Actividad 6.12
-- Tema 6. Lenguaje SQL - DML
-- Base de datos
-- Curso 23/24
-- Alumno: Adrian Campos Espejo


-- 1. CONSULTA MULTITABLA MOVIMIENTOS

SELECT 
    movimientos.id,
    movimientos.id_cuenta,
    cuentas.num_cuenta,
    CONCAT(clientes.apellidos, ', ', clientes.nombre) AS cliente,
    DATE(movimientos.fecha_hora) AS fecha,
    movimientos.concepto,
    movimientos.tipo,
    movimientos.cantidad,
    movimientos.saldo
FROM movimientos
JOIN cuentas ON movimientos.id_cuenta = cuentas.id
JOIN clientes ON cuentas.id_cliente = clientes.id
ORDER BY movimientos.id;


-- 2. CREAR VISTA mov_clientes
CREATE VIEW mov_clientes AS
SELECT 
    movimientos.id,
    movimientos.id_cuenta,
    cuentas.num_cuenta,
    CONCAT(clientes.apellidos, ', ', clientes.nombre) AS cliente,
    DATE(movimientos.fecha_hora) AS fecha,
    movimientos.concepto,
    movimientos.tipo,
    movimientos.cantidad,
    movimientos.saldo
FROM movimientos
JOIN cuentas ON movimientos.id_cuenta = cuentas.id
JOIN clientes ON cuentas.id_cliente = clientes.id;


-- 3. CONSULTAS SOBRE LA VISTA

-- Movimientos del año 2021
SELECT *
FROM mov_clientes
WHERE YEAR(fecha) = 2021;


-- Movimientos de tipo Ingreso
SELECT *
FROM mov_clientes
WHERE tipo = 'I';


-- Movimientos de tipo Reintegro inferiores a 10 euros
SELECT *
FROM mov_clientes
WHERE tipo = 'R'
AND cantidad < 10;


-- Saldo total de cada cuenta (agrupación)
SELECT 
    id_cuenta,
    num_cuenta,
    SUM(cantidad) AS total_movimientos
FROM mov_clientes
GROUP BY id_cuenta, num_cuenta;