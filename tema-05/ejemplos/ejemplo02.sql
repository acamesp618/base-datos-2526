-- Muestra los juegos de caracteres disponibles mysql
SHOW CHARACTER SET;

-- Muestra los cotejamientoso disponibles de mysql
SHOW COLLATION;

-- Crear la Base de Datos EJEMPLO con el cotejamiento establecido por defecto en MySQL
CREATE DATABASE ejemplo;

-- Crear la Base de Datos EJEMPLO sólo si no existe
CREATE DATABASE IF NOT EXISTS ejemplo;

-- Crear la Base de Datos BANCO Multilingüe con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Crear la Base de Datos BANCO para Español con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8 COLLATE utf8_spanish_ci;

-- Crear la Base de Datos BANCO para Español con UTF8MB4
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

-- Crear la Base de Datos BANCO para Español con LATIN1
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET latin1 COLLATE latin1_spanish_ci;

-- Crear la Base de Datos BANCO Multilingüe con LATIN1
CREATE DATABASE IF NOT EXISTS banco
characTER SET latin1 COLLATE latin1_general_ci;

-- Crear la base de datos geslibros español muntilingüe con juego de caracter utf8mb4
-- Opciones por defecto
CREATE DATABASE IF NOT EXISTS geslibros
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

DROP DATABASE IF EXISTS gesslibros;