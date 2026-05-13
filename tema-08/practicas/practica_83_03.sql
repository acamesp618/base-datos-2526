-- Actividad 8.3 - Estructuras de Control en MySQL
-- Adrian Campos Espejo

-- Actividad 1. Id de categoría
DELIMITER $$

DROP FUNCTION IF EXISTS maratoon.Categoria $$
CREATE FUNCTION maratoon.Categoria(Edad INT)
RETURNS INT UNSIGNED

BEGIN
    DECLARE categoria INT UNSIGNED;
    CASE
        WHEN Edad < 12 THEN SET categoria = 1;
        WHEN Edad < 15 THEN SET categoria = 2;
        WHEN Edad < 18 THEN SET categoria = 3;
        WHEN Edad < 30 THEN SET categoria = 4;
        WHEN Edad < 40 THEN SET categoria = 5;
        WHEN Edad < 50 THEN SET categoria = 6;
        WHEN Edad < 60 THEN SET categoria = 7;
        ELSE SET categoria = 8;
    END CASE;

    RETURN categoria;

END $$

DELIMITER ;
SELECT Categoria(25);

-- Actividad 2. Procedimiento ActualizarCategoria

DELIMITER $$
DROP PROCEDURE IF EXISTS maratoon.ActualizarCategoria $$
CREATE PROCEDURE maratoon.ActualizarCategoria()
BEGIN

    UPDATE Corredores
    SET categoria_id = Categoria(Edad);

END $$

DELIMITER ;
CALL ActualizarCategoria();

-- Actividad 3. Prodecimiento ProximosCumpleaños
DELIMITER $$

DROP PROCEDURE IF EXISTS maratoon.ProximosCumpleaños $$

CREATE PROCEDURE maratoon.ProximosCumpleaños()

BEGIN

    SELECT *
    FROM Corredores
    WHERE DAYOFYEAR(FechaNacimiento)
    BETWEEN DAYOFYEAR(CURDATE())
    AND DAYOFYEAR(DATE_ADD(CURDATE(), INTERVAL 7 DAY));

END $$

DELIMITER ;
CALL ProximosCumpleaños();


-- Actividad 4. Funcion NumerosPrimos
DELIMITER $$

DROP FUNCTION IF EXISTS test.NumerosPrimos $$

CREATE FUNCTION test.NumerosPrimos(limite INT)
RETURNS INT

BEGIN

    DECLARE numero INT;
    DECLARE divisor INT;
    DECLARE primo BOOLEAN;
    DECLARE suma INT;

    SET numero = 1;
    SET suma = 0;

    WHILE numero <= limite DO

        SET divisor = 2;
        SET primo = TRUE;

        IF numero = 1 THEN
            SET primo = TRUE;
        END IF;

        WHILE divisor < numero DO

            IF MOD(numero, divisor) = 0 THEN
                SET primo = FALSE;
            END IF;

            SET divisor = divisor + 1;

        END WHILE;

        IF primo = TRUE THEN
            SET suma = suma + numero;
        END IF;

        SET numero = numero + 1;

    END WHILE;

    RETURN suma;

END $$

DELIMITER ;
SELECT NumerosPrimos(7);

-- Actividad 5. Funcion factorial

DELIMITER $$

DROP FUNCTION IF EXISTS test.factorial $$

CREATE FUNCTION test.factorial(numero INT)
RETURNS BIGINT

BEGIN

    DECLARE i INT;
    DECLARE resultado BIGINT;

    SET i = 1;
    SET resultado = 1;

    WHILE i <= numero DO

        SET resultado = resultado * i;

        SET i = i + 1;

    END WHILE;

    RETURN resultado;

END $$

DELIMITER ;
SELECT factorial(5);