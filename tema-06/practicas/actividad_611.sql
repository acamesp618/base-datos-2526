-- Actividad 6.11
-- GROUP BY - HAVING

-- Base de datos empresa
USE empresa;

-- 1. Numero de empleados en cada departamento
-- columnas: id, departamento, num_empleados
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        LEFT JOIN
    departamentos ON empleados.departamento_id = departamentos.id
GROUP BY empleados.departamento_id;

-- 2. Obtener el número de empleados que hay en cada departamento cuyo sueldo esté por encima de los 30000 anuales. 
-- columnas: id, departamento, num_empleados
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        LEFT JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    salario > 30000
GROUP BY empleados.departamento_id;

-- 3. Obtener el número total de empleados que hay en cada departamento cuyo salario esté comprendido entre 20000 y 50000.
-- columnas: id, departamento, num_empleados
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        LEFT JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    salario BETWEEN 20000 AND 500000
GROUP BY empleados.departamento_id;

-- 4. Obtener el número de empleados que nacieron en cada año.
-- Mostrar las columnas con el alias Año y Nempleados.
SELECT YEAR(fecha_nac) Año, COUNT(*) Nempleados FROM empleados GROUP BY YEAR(fecha_nac);

-- 5. Sobre la tabla Empleados_proyectos, obtener la suma total de horas trabajadas en cada proyecto. 
-- Mostrar id, Proyecto y HorasAcumuladas. 
SELECT id, proyecto_id, SUM(horas) HorasAcumuladas FROM empleados_proyectos GROUP BY horas;


