-- Actividad 7. - Bloqueos de tablas
-- Adrian Campos Espejo

USE maratoon;
-- 1. Añadir tres corredores
INSERT INTO Corredores (Nombre, Apellidos, Ciudad, FechaNacimiento, Sexo, Club_id) VALUES
('Luis', 'Martínez López', 'Jerez', '2005-03-12', 'H', 5),
('Ana', 'Gómez Ruiz', 'Jerez', '1998-11-20', 'M', 5),
('Carlos', 'Sánchez Pérez', 'Jerez', '2010-06-05', 'H', 5);

-- 2. Actualizar Edad
UPDATE Corredores
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, NOW());

-- 3. Actualizar Categoría
UPDATE Corredores
SET categoria_id = 
    CASE
        WHEN Edad < 12 THEN 1 -- infantil
        WHEN Edad < 15 THEN 2 -- junior
        WHEN Edad < 18 THEN 3 -- juvenil
        WHEN Edad < 30 THEN 4 -- Senior A
        WHEN Edad < 40 THEN 5 -- Senior B
        WHEN Edad < 50 THEN 6 -- Veterano A
        WHEN Edad < 60 THEN 7 -- Veterano B
        ELSE 8 -- Veterano C
    END;

-- 3. Mostrar corredores
-- Mostrar todos los corredores
SELECT 
    corredores.id,
    corredores.Nombre,
    corredores.Apellidos,
    corredores.FechaNacimiento,
    corredores.Edad,
    categoria.Nombrecorto AS Categoria,
    clubs.NombreCorto AS Club
FROM Corredores
JOIN Categorias ON corredores.categoria_id = categoria.id
JOIN Clubs ON club.club_id = clubs.id;

-- Cumplen años el mes que viene
SELECT 
    corredores.id,
    corredores.Nombre,
    corredores.Apellidos,
    corredores.FechaNacimiento,
    corredores.Edad,
    categoria.Nombrecorto AS Categoria,
    clubs.NombreCorto AS Club
FROM
    Corredores
        JOIN
    Categorias ON corredores.categoria_id = categoria.id
        JOIN
    Clubs ON corredores.club_id = clubs.id
WHERE
    MONTH(corredores.FechaNacimiento) = MONTH(DATE_ADD(NOW(), INTERVAL 1 MONTH));

-- Cumplen años la semana que viene
SELECT 
    corredores.id,
    corredores.Nombre,
    corredores.Apellidos,
    corredores.FechaNacimiento,
    corredores.Edad,
    categoria.Nombrecorto AS Categoria,
    clubs.NombreCorto AS Club
FROM
    Corredores
        JOIN
    Categorias ON corredores.categoria_id = categoria.id
        JOIN
    Clubs ON corredores.club_id = clubs.id
WHERE
    WEEK(corredores.FechaNacimiento) = WEEK(DATE_ADD(NOW(), INTERVAL 1 WEEK));

-- Nacidos en el segundo cuatrimestre (mayo-agosto)
SELECT 
    corredores.id,
    corredores.Nombre,
    corredores.Apellidos,
    corredores.FechaNacimiento,
    corredores.Edad,
    categoria.Nombrecorto AS Categoria,
    clubs.NombreCorto AS Club
FROM
    Corredores c
        JOIN
    Categorias ON corredores.categoria_id = categoria.id
        JOIN
    Clubs ON corredores.club_id = clubs.id
WHERE
    MONTH(corredores.FechaNacimiento) BETWEEN 5 AND 8;

-- 4. Maratón de Sevilla
INSERT INTO Registros VALUES
(NULL, 2, 2, '2019-12-02 09:00:00', '2019-12-02 11:20:00', NULL),
(NULL, 2, 3, '2019-12-02 09:00:00', '2019-12-02 11:25:00', NULL),
(NULL, 2, 4, '2019-12-02 09:00:00', '2019-12-02 11:30:00', NULL),
(NULL, 2, 5, '2019-12-02 09:00:00', '2019-12-02 11:40:00', NULL),
(NULL, 2, 6, '2019-12-02 09:00:00', '2019-12-02 11:50:00', NULL);

-- 5. Actualizar Tiempo de Llegada
UPDATE Registros
SET TiempoInvertido = TIMEDIFF(Llegada, Salida)
WHERE carrera_id = 2;

-- 6. Mostrar clasificacion

SELECT 
    corredores.id,
    corredores.Nombre,
    corredores.Apellidos,
    clubs.Nombre AS Club,
    categorias.Nombre AS Categoria,
    registros.TiempoInvertido
FROM Registros
JOIN Corredores ON registros.corredor_id = corredores.id
JOIN Clubs ON corredores.club_id = clubs.id
JOIN Categorias ON corredores.categoria_id = categorias.id
WHERE registros.carrera_id = 2
ORDER BY registros.TiempoInvertido;

-- Clasificacion con segundos
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Clubs.Nombre AS Club,
    Categorias.Nombre AS Categoria,
    Registros.TiempoInvertido,
    TIME_TO_SEC(Registros.TiempoInvertido) AS Segundos
FROM Registros
JOIN Corredores ON Registros.corredor_id = Corredores.id
JOIN Clubs ON Corredores.club_id = Clubs.id
JOIN Categorias ON Corredores.categoria_id = Categorias.id
WHERE Registros.carrera_id = 2
ORDER BY Registros.TiempoInvertido;

-- Clasificacioon con record
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Clubs.Nombre AS Club,
    Categorias.Nombre AS Categoria,
    Registros.TiempoInvertido,
    SEC_TO_TIME(
        TIME_TO_SEC(Registros.TiempoInvertido) - TIME_TO_SEC('02:01:39')
    ) AS DiferenciaRecord
FROM Registros
JOIN Corredores ON Registros.corredor_id = Corredores.id
JOIN Clubs ON Corredores.club_id = Clubs.id
JOIN Categorias ON Corredores.categoria_id = Categorias.id
WHERE Registros.carrera_id = 2
ORDER BY Registros.TiempoInvertido;

-- Clasificacion se la categoría SNA
SELECT 
    Corredores.id,
    Corredores.Nombre,
    Corredores.Apellidos,
    Clubs.Nombre AS Club,
    Categorias.Nombre AS Categoria,
    Registros.TiempoInvertido
FROM Registros
JOIN Corredores ON Registros.corredor_id = Corredores.id
JOIN Clubs ON Corredores.club_id = Clubs.id
JOIN Categorias ON Corredores.categoria_id = Categorias.id
WHERE Registros.carrera_id = 2
AND Categorias.Nombrecorto = 'SNA'
ORDER BY Registros.TiempoInvertido;
