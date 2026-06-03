-- Actividad 6.6

-- 1. ORDER BY, LIMIT, ALL DISTINCT

-- Obtener los 3 empleados con mayor salario
SELECT * FROM empleados ORDER BY salario DESC LIMIT 3; 

-- Obtener los 5 empleados con menor salario
SELECT * FROM empleados ORDER BY salario LIMIT 5; 

-- Obtener los empleados ordenados alfabéticamente
SELECT * FROM empleados ORDER BY nombre;

-- Obtener los 3 primeros departamentos
SELECT * FROM departamentos LIMIT 3;

-- Obtener los 3 empleados con mayores salarios del departamento 3
SELECT * FROM empleados WHERE departamento_id = 3 ORDER BY salario DESC LIMIT 3;

-- 2. FUNCION COUNT()

-- Obtener el número total de departamentos
SELECT COUNT(*) AS total_departamentos FROM departamentos;

-- Obtener el número total de beneficiarios     de sexo ‘M’ mujer
SELECT COUNT(*) AS total_mujeres FROM beneficiarios WHERE genero = 'M';

-- Obtener el número total de empleados cuyo salario esté comprendido entre 20000 y 50000.
SELECT COUNT(*) AS total_empleados FROM beneficiarios BETWEEN 20000 AND 50000;

-- Obtener el número total de empleados nacidos después del 1970, no inclusive.
SELECT COUNT(*) AS total_empleados FROM empleados WHERE fecha_nacimiento > '1970-01-01';

-- Obtener el número total de proyectos asignados al departamento 3.
SELECT COUNT(*) AS total_proyectos FROM proyectos WHERE departamento_id = 3;

-- Obtener el número de departamentos que están realizando un proyecto.
SELECT COUNT(*) AS num_departamentos FROM proyectos;

-- Obtener el número de empleados que están trabajando en algún proyecto.
SELECT COUNT(*) AS num_empleados

-- 3. FUNCION SUM()

-- Obtener el total de horas trabajadas en los distintos proyectos.
SELECT 

-- Obtener el total de horas trabajadas en el proyecto 2.

-- Obtener la suma total de los salarios de los empleados.

-- Obtener la suma total de los salarios de los empleados del departamento 5

-- Obtener la suma total de los salarios de los empleados cuyo número de supervisor es 3

-- Obtener el número de empleados y la suma total de sus salarios del departamento 4