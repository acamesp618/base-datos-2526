-- Actividad 6.2
-- Tema Lenguaje SQL - DDL
-- Módulo Base de Datos
-- Curso 25/26
-- Nombre: Adrian Campos Espejo

USE futbol;

-- 1. Cambiar el nombre de un equipo
-- Girona id= 10
UPDATE equipos 
SET 
    nombre = 'Girona Futbol Club'
WHERE
    id = '10' LIMIT 1;

-- 2. Actualizar la ciudad de un equipo
UPDATE equipos 
SET 
    ciudad = 'Vila-real'
WHERE
    id = '7' LIMIT 1;

-- 3. Incrementar aforo de estadios grandes
UPDATE equipos 
SET 
    aforo = aforo + 1000
WHERE
    aforo > 50000;

-- 4. Cambiar el equipo de un juegador
UPDATE jugadores 
SET 
    equipo_id = 7
WHERE
    id = '17' LIMIT 1;

-- 5. Corregir fecha de nacimiento
UPDATE jugadores 
SET 
    fecha_nac = '2001-06-05'
WHERE
    id = '23' LIMIT 1;


-- 6. Ajustar goles de un partido
UPDATE partidos 
SET 
    goles_casa = 2,
    goles_fuera = 1
WHERE
    id = 7 LIMIT 1;

-- 7. Actualizar observaciones de partidos recientes
UPDATE partidos 
SET 
    observaciones = CONCAT_WS(' ', observaciones, ' (actualizado)')
ORDER BY fecha DESC LIMIT 3;

-- 8. Cambiar minutos de goles por penalti
UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    descripcion LIKE '%penalti%';

-- 9. Asignar jugadores de un partido
UPDATE goles 
SET 
    jugador_id = 18
WHERE
    id = 37 LIMIT 1;
    
SELECT 
    *
FROM
    goles
        INNER JOIN
    jugadores ON goles.jugador_id = jugadores.id
WHERE
    jugador_id = 18; 

-- 10. Incrementar goles de los jugadores estrella
UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    jugador_id = 20 ORDER BY id ASC LIMIT 2;

-- 11. Modificar estadio de un equipo
UPDATE equipos 
SET 
    estadio = 'Reale Arena Nuevo'
WHERE
    id = 9 LIMIT 1;

-- 12. Actualizar el equipo de varios jugadores
UPDATE jugadores 
SET 
    equipo_id = 8
WHERE
    equipo_id = 10;

-- 13. Incrementar goles de todos los partidos de un equipo
UPDATE partidos 
SET 
    goles_casa = goles_casa + 1
WHERE
    equipo_casa_id = 6;

-- 14. Corregir minutos de los goles antiguos
UPDATE goles 
SET 
    minuto = minuto - 2
WHERE
    minuto > 80;

-- 15. Renombrar un jugador
UPDATE jugadores 
SET 
    nombre = 'José Gayà'
WHERE
    id = '16';
