-- Actividad 6.1
-- Tema 6 Lenguaje SQL - DML
-- Base de datos 25/26
-- Alumno: Adrian Campos

-- Descripcion: mina de datos de la BBDD futbol

USE futbol;

/* =========================================================
   INSERCIÓN DE NUEVOS EQUIPOS DE LALIGA (TEMPORADA ACTUAL)
   ========================================================= */
INSERT INTO equipos VALUES
(6, 'Athletic Club', 'San Mamés', 53289, 1898, 'Bilbao'),
(7, 'Real Sociedad', 'Reale Arena', 39500, 1909, 'San Sebastián'),
(8, 'Valencia CF', 'Mestalla', 49430, 1919, 'Valencia'),
(9, 'Villarreal CF', 'Estadio de la Cerámica', 23500, 1923, 'Villarreal'),
(10, 'Girona FC', 'Montilivi', 14624, 1930, 'Girona');


/* =========================================================
   INSERCIÓN DE JUGADORES
   (2 JUGADORES POR CADA NUEVO EQUIPO)
   ========================================================= */
INSERT INTO jugadores VALUES
-- Athletic Club
(16, 'Iñaki Williams', '1994-06-15', 6),
(17, 'Nico Williams', '2002-07-12', 6),

-- Real Sociedad
(18, 'Mikel Oyarzabal', '1997-04-21', 7),
(19, 'Takefusa Kubo', '2001-06-04', 7),

-- Valencia CF
(20, 'José Gayà', '1995-05-25', 8),
(21, 'Hugo Duro', '1999-11-10', 8),

-- Villarreal CF
(22, 'Gerard Moreno', '1992-04-07', 9),
(23, 'Álex Baena', '2001-07-20', 9),

-- Girona FC
(24, 'Artem Dovbyk', '1997-06-21', 10),
(25, 'Aleix García', '1997-06-28', 10);


/* =========================================================
   INSERCIÓN DE PARTIDOS DE LALIGA
   ========================================================= */
INSERT INTO partidos VALUES
-- Derbi vasco
(7, 6, 7, '2024-09-14 18:30:00', 2, 1, 'Derbi vasco muy intenso'),

-- Valencia vs Villarreal
(8, 8, 9, '2024-09-15 21:00:00', 1, 1, 'Empate con dominio alterno'),

-- Girona vs Barcelona
(9, 10, 2, '2024-09-21 18:30:00', 2, 2, 'El Girona vuelve a sorprender'),

-- Real Madrid vs Athletic
(10, 1, 6, '2024-09-22 21:00:00', 3, 1, 'El Madrid se impone en el Bernabéu'),

-- Real Sociedad vs Betis
(11, 7, 5, '2024-09-28 18:30:00', 2, 0, 'Gran partido de la Real'),

-- Villarreal vs Atlético
(12, 9, 3, '2024-09-29 21:00:00', 1, 2, 'El Atlético remonta'),

-- Sevilla vs Valencia
(13, 4, 8, '2024-10-05 18:30:00', 1, 0, 'Sevilla gana por la mínima'),

-- Barcelona vs Athletic
(14, 2, 6, '2024-10-06 21:00:00', 2, 1, 'Partido muy disputado'),

-- Girona vs Atlético
(15, 10, 3, '2024-10-19 18:30:00', 1, 3, 'El Atlético impone su experiencia'),

-- Real Sociedad vs Real Madrid
(16, 7, 1, '2024-10-20 21:00:00', 1, 2, 'Victoria sufrida del Madrid');


/* =========================================================
   INSERCIÓN DE GOLES
   CADA GOL ASOCIADO A SU PARTIDO Y JUGADOR
   ========================================================= */
INSERT INTO goles VALUES
-- Partido 7: Athletic vs Real Sociedad
(NULL, 7, 15, 'Iñaki Williams define con potencia', 16),
(NULL, 7, 40, 'Oyarzabal empata de penalti', 18),
(NULL, 7, 75, 'Nico Williams marca tras una contra', 17),

-- Partido 8: Valencia vs Villarreal
(NULL, 8, 30, 'Hugo Duro remata de cabeza', 21),
(NULL, 8, 70, 'Gerard Moreno empata desde el punto de penalti', 22),

-- Partido 9: Girona vs Barcelona
(NULL, 9, 10, 'Dovbyk abre el marcador', 24),
(NULL, 9, 35, 'Lewandowski empata tras centro lateral', 4),
(NULL, 9, 55, 'Aleix García marca desde fuera del área', 25),
(NULL, 9, 80, 'Pedri empata con un disparo colocado', 5),

-- Partido 10: Real Madrid vs Athletic
(NULL, 10, 20, 'Bellingham marca de volea', 2),
(NULL, 10, 50, 'Vinícius amplía la ventaja', 1),
(NULL, 10, 65, 'Iñaki Williams recorta distancias', 16),
(NULL, 10, 88, 'Rodrygo sentencia el partido', 3),

-- Partido 11: Real Sociedad vs Betis
(NULL, 11, 25, 'Kubo marca tras una jugada individual', 19),
(NULL, 11, 60, 'Oyarzabal anota el segundo', 18),

-- Partido 12: Villarreal vs Atlético
(NULL, 12, 15, 'Baena adelanta al Villarreal', 23),
(NULL, 12, 55, 'Griezmann empata de falta directa', 7),
(NULL, 12, 78, 'Morata marca el gol de la victoria', 8),

-- Partido 13: Sevilla vs Valencia
(NULL, 13, 40, 'En-Nesyri marca de cabeza', 11),

-- Partido 14: Barcelona vs Athletic
(NULL, 14, 30, 'Lewandowski abre el marcador', 4),
(NULL, 14, 70, 'Iñaki Williams empata', 16),
(NULL, 14, 85, 'Pedri decide el partido', 5),

-- Partido 15: Girona vs Atlético
(NULL, 15, 22, 'Dovbyk marca para el Girona', 24),
(NULL, 15, 50, 'Morata empata', 8),
(NULL, 15, 68, 'Griezmann pone el 1-2', 7),
(NULL, 15, 82, 'De Paul sentencia desde fuera del área', 9),

-- Partido 16: Real Sociedad vs Real Madrid
(NULL, 16, 35, 'Oyarzabal marca para la Real', 18),
(NULL, 16, 60, 'Vinícius empata', 1),
(NULL, 16, 88, 'Bellingham marca el gol decisivo', 2);
