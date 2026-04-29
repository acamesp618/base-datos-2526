-- Eliminar un jugador concreto
SELECT id, nombre
FROM jugadores
WHERE nombre = 'Aleix García';

DELETE FROM jugadores
WHERE id = (SELECT id FROM jugadores WHERE nombre = 'Aleix García');

-- Borrar goles de un partido
SELECT *
FROM goles
WHERE partido_id = 7;

DELETE FROM goles
WHERE partido_id = 7;

-- Eliminar goles tardíos
SELECT *
FROM goles
WHERE minuto > 85;

DELETE FROM goles
WHERE minuto > 85;

-- Eliminar partidos sin goles
SELECT *
FROM partidos
WHERE goles_casa = 0 AND goles_fuera = 0;

DELETE FROM partidos
WHERE goles_casa = 0
AND goles_fuera = 0;

-- Borrar jugadores sin equipo
SELECT *
FROM jugadores
WHERE equipo_id IS NULL;

DELETE FROM jugadores
WHERE equipo_id IS NULL;

-- Eliminar goles de un jugador
SELECT id
FROM jugadores
WHERE nombre = 'Gerard Moreno';

SELECT *
FROM goles
WHERE jugador_id = (
    SELECT id
    FROM jugadores
    WHERE nombre = 'Gerard Moreno'
);

DELETE FROM goles
WHERE jugador_id = (
    SELECT id
    FROM jugadores
    WHERE nombre = 'Gerard Moreno'
);

-- Eliminar los últimos goles registrados
SELECT *
FROM goles
ORDER BY id DESC
LIMIT 2;

DELETE FROM goles
ORDER BY id DESC
LIMIT 2;

-- Borrar partidos antiguos
SELECT *
FROM partidos
WHERE fecha < '2024-04-01';

DELETE FROM partidos
WHERE fecha < '2024-04-01';

-- Eliminar goles de un partido concreto (con condicion)
SELECT *
FROM goles
WHERE partido_id = 11
AND minuto < 30;

DELETE FROM goles
WHERE partido_id = 11
AND minuto < 30;

-- Eliminar un equipo sin jugadores
SELECT *
FROM jugadores
WHERE equipo_id = (
    SELECT id
    FROM equipos
    WHERE nombre = 'Girona Futbol Club'
);

SELECT *
FROM equipos
WHERE nombre = 'Girona Futbol Club';

DELETE FROM equipos
WHERE nombre = 'Girona Futbol Club'
AND id NOT IN (
    SELECT equipo_id
    FROM jugadores
    WHERE equipo_id IS NOT NULL
);