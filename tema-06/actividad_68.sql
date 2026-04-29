-- Actividad 6.8
-- Consultas multitablas

-- Activamos la base de datos futbol
USE futbol;

-- 1. Realiza un producto cartesiano entre las tablas jugadores y equipos.
SELECT 
    *
FROM
    jugadores,
    equipos;

-- 2. Realiza un producto cartesiano entre las tablas jugadores y goles.
SELECT 
    *
FROM
    jugadores,
    goles;

-- 3. Realiza un producto cartesiano entre las tablas jugadores y equipos eliminando los registros espurios (where).
SELECT 
    *
FROM
    jugadores,
    equipos
WHERE
    jugadores.equipo_id = equipos.id;

-- 4. Realiza un producto cartesiano entre las tablas jugadores y goles eliminando los registros espurios (where)
SELECT 
    *
FROM
    jugadores,
    goles
WHERE
    jugadores.id = goles.jugador_id;

-- 5. Realiza INNER JOIN correcto entre las tablas jugadores y equipos, devolver todas las columnas de jugadores y de equipos.
SELECT 
    *
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id;

-- 6. Realiza INNER JOIN correcto entre las tablas jugadores y equipos, devolver las columnas id, nombre, edad y equipo
SELECT 
    jugadores.id,
    jugadores.nombre,
    TIMESTAMPDIFF(YEAR,
        fecha_nac,
        CURDATE()) edad,
    equipos.nombre equipo
FROM
    jugadores
        INNER JOIN
    equipos
WHERE
    jugadores.equipo_id = equipos.id;

-- 7. Realizar INNER JOIN correcto entre las tablas jugadores y goles.
SELECT 
    *
FROM
    jugadores
        INNER JOIN
    goles
WHERE
    jugador_id = goles.id;

-- 8. Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, minuto, descripción
SELECT 
    jugadores.id,
    jugadores.nombre,
    goles.minuto,
    goles.descripcion
FROM
    jugadores
        INNER JOIN
    goles
WHERE
    jugadores.id = goles.jugador_id;

-- 9. Realizar INNER JOIN correcto entre las tablas jugadores, equipos y goles.
SELECT 
    *
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id;

-- 10. Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, equipo, minuto, descripción
SELECT 
    jugadores.id,
    jugadores.nombre,
    equipos.nombre equipo,
    goles.minuto,
    goles.descripcion
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipo.id
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id;

-- 11. Realizar INNER JOIN correcto entre las tablas jugadores, equipos, goles y partidos. Todas las columnas
SELECT 
    *
FROM
    ((goles
        INNER JOIN
    jugadores ON goles.jugador_id = jugadores.id)
        INNER JOIN
    partidos ON goles.partido_id = partidos.id)
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id;

-- 12. Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, equipo, minuto, descripción, observaciones
SELECT 
    jugadores.id,
    jugadores.nombre,
    equipos.nombre equipo,
    goles.minuto,
    goles.descripcion,
    partidos.observaciones
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id
        INNER JOIN
    partidos ON goles.partido_id = partidos.id;