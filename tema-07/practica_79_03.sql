-- Actividad 7.9 - Importarción, Exportación de Datos y Copias de Seguridad
-- Adrian Campos Espejo

-- 1. Crear corredores.csv
/*
-- Corredores.csv
-- generar un archivo con los datos de los Corredores
-- tabla: Corredores
-- columnas: Nombre,Apellidos,Ciudad,FechaNacimiento,Sexo,Club_id
Luis,Moreno Diaz,Sevilla,1995-03-12,H,1
Carmen,Lopez Ruiz,Cadiz,2002-07-25,M,2
Alberto,Sanchez Vega,Jerez,1988-11-03,H,3
Maria,Gomez Perez,Malaga,2005-01-18,M,4
Javier,Ruiz Torres,Cordoba,1975-09-30,H,5
*/
 
-- 2. Importar corredores.csv

LOAD DATA INFILE 'C:/Users/07_1DAW_Alum/Desktop/BBDD/UD7/corredores.csv'
IGNORE INTO TABLE maratoon.corredores
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 4 LINES
(Nombre, Apellidos, Ciudad, FechaNacimiento, Sexo, Club_id);

-- 3. Actualizar Edad y Categoría

UPDATE Corredores 
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, NOW());

UPDATE Corredores SET categoria_id = 1 WHERE Edad<12;
UPDATE Corredores SET categoria_id = 2 WHERE Edad BETWEEN 12 AND 14;
UPDATE Corredores SET categoria_id = 3 WHERE Edad BETWEEN 15 AND 17;
UPDATE Corredores SET categoria_id = 4 WHERE Edad BETWEEN 18 AND 29;
UPDATE Corredores SET categoria_id = 5 WHERE Edad BETWEEN 30 AND 39;
UPDATE Corredores SET categoria_id = 6 WHERE Edad BETWEEN 40 AND 49;
UPDATE Corredores SET categoria_id = 7 WHERE Edad BETWEEN 50 AND 60;
UPDATE Corredores SET categoria_id = 8 WHERE Edad>=60;

-- 4. Crear registros.csv (para carrera_id = 3)

/*
-- Registros.csv
-- generar un archivo con los datos de los Registros
-- tabla: Registros
-- carrera_id,corredor_id,Salida,Llegada,TiempoInvertido
3,17,2026-05-10 10:00:00,2026-05-10 11:35:20,NULL
3,18,2026-05-10 10:00:00,2026-05-10 11:42:10,NULL
3,19,2026-05-10 10:00:00,2026-05-10 11:50:00,NULL
3,20,2026-05-10 10:00:00,2026-05-10 11:28:45,NULL
3,21,2026-05-10 10:00:00,2026-05-10 12:05:00,NULL
*/

-- 5. Importar registros.csv

LOAD DATA INFILE 'C:/Users/07_1DAW_Alum/Desktop/BBDD/UD7/registros.csv'
IGNORE INTO TABLE maratoon.registros
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 4 LINES
(carrera_id, corredor_id, Salida, Llegada, TiempoInvertido);

-- 6. Actualizar TiempoInvertido

UPDATE Registros 
SET TiempoInvertido = TIMEDIFF(Llegada, Salida)
WHERE TiempoInvertido IS NULL;

-- 7. Crear clubs.xml

/*
<?xml version="1.0" encoding="UTF-8"?>
<clubs>
  <club>
    <NombreCorto>RUN</NombreCorto>
    <Nombre>Runners Sevilla</Nombre>
    <Ciudad>Sevilla</Ciudad>
    <FecFundacion>2000-05-10</FecFundacion>
    <NumSocios>120</NumSocios>
  </club>
  <club>
    <NombreCorto>ATL</NombreCorto>
    <Nombre>Atletismo Cádiz</Nombre>
    <Ciudad>Cadiz</Ciudad>
    <FecFundacion>1995-03-15</FecFundacion>
    <NumSocios>95</NumSocios>
  </club>
</clubs>
*/

-- 8. Crear carreras.xml

/*
<?xml version="1.0" encoding="UTF-8"?>
<carreras>
  <carrera>
    <Nombre>Carrera Popular Sevilla</Nombre>
    <Ciudad>Sevilla</Ciudad>
    <Distancia>10000</Distancia>
    <MesCelebracion>4</MesCelebracion>
  </carrera>
  <carrera>
    <Nombre>Media Maratón Cádiz</Nombre>
    <Ciudad>Cadiz</Ciudad>
    <Distancia>21000</Distancia>
    <MesCelebracion>9</MesCelebracion>
  </carrera>
</carreras>
*/

-- 9. Importar XML

LOAD XML LOCAL INFILE 'C:/Users/07_1DAW_Alum/Desktop/BBDD/UD7/clubs.xml'
INTO TABLE Clubs
ROWS IDENTIFIED BY '<club>';

LOAD XML LOCAL INFILE 'C:/Users/07_1DAW_Alum/Desktop/BBDD/UD7/carreras.xml'
INTO TABLE Carreras
ROWS IDENTIFIED BY '<carrera>';

-- 10. Exportar corredores
SELECT *
INTO OUTFILE 'C:/Users/07_1DAW_Alum/Desktop/BBDD/UD7/copiacorredores.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM Corredores;

-- 11. Exportar registros
SELECT *
INTO OUTFILE 'C:/Users/07_1DAW_Alum/Desktop/BBDD/UD7/copiaregistros.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM Registros;

-- 12. Clasificacion carrera 1

SELECT 
  c.id,
  c.Apellidos,
  c.Nombre,
  cl.Nombre,
  cat.Nombre,
  r.TiempoInvertido
INTO OUTFILE 'C:/clasificacion.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM Registros r
JOIN Corredores c ON r.corredor_id = c.id
JOIN Clubs cl ON c.club_id = cl.id
JOIN Categorias cat ON c.categoria_id = cat.id
WHERE r.carrera_id = 1
ORDER BY r.TiempoInvertido;

-- COPIAS DE SEGURIDAD
-- Base de datos completa
mysqldump -u root -p maratoon > maratoon.sql

-- Tablas carreras y registros
mysqldump -u root -p maratoon Carreras Registros > parcial.sql

-- Copia seguridad XML
mysqldump -u root -p --xml maratoon > maratoon.xml

-- XML solo datos
mysqldump -u root -p -t --xml maratoon > maratoondatos.xml