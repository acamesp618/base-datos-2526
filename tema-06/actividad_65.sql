-- Actividad 6.5
USE futbol;

-- 1.CONSULTAS BASICAS

-- Listado de todos los jugadores
SELECT * FROM jugadores;

-- Listado de todos los equipos
SELECT * FROM equipos;

-- Listado de todos los partidos
SELECT * FROM partidos;

-- Listado de los tres últimos partidos disputados
SELECT * FROM partidos ORDER BY fecha DESC limit 3;

-- 2. CONSULTAS CON LIMIT

-- Listado de los 5 goles más tempranos
SELECT * FROM goles ORDER BY minuto LIMIT 5;

-- Listado de goles del 5 al 10
SELECT * FROM goles LIMIT 4, 6; 

-- Listado de los tres últimos partidos disputados
SELECT * FROM partidos ORDER BY fecha DESC LIMIT 3;

-- Listado de sólo 1 partido donde intervino el Betis como equipo de fuera
SELECT * FROM partidos WHERE equipo_fuera_id = 5 LIMIT 1;

-- Listado de 1 partido donde el equipo de fuera no marcó
SELECT * FROM partidos WHERE goles_fuera = 0 LIMIT 1;

-- Listar 5 goles a partir del gol 4
SELECT * FROM goles ORDER BY id LIMIT 5 OFFSET 4;