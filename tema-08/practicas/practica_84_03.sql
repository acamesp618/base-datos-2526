-- Práctica 84 - Cursores PL/SQL
-- Adrian Campos Espejo

-- Actividad 1. actualizar_saldo()
-- Base de datos bancos
-- Verifica y actualiza el saldo de todas las cuentas

DELIMITER $$

DROP PROCEDURE IF EXISTS bancos.actualizar_saldo $$

CREATE PROCEDURE bancos.actualizar_saldo()

BEGIN

    DECLARE VIdCuenta INT;
    DECLARE VIban CHAR(24);
    DECLARE VSaldoTabla DECIMAL(10,2);
    DECLARE VSaldoFuncion DECIMAL(10,2);
    DECLARE VDescuadre DECIMAL(10,2);

    DECLARE lrf BOOLEAN;

    DECLARE Cursor01 CURSOR FOR
    SELECT id, iban, saldo
    FROM cuentas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

    SET lrf = 0;

    OPEN Cursor01;

    l_cursor: LOOP

        FETCH Cursor01
        INTO VIdCuenta, VIban, VSaldoTabla;

        IF lrf = 1 THEN
            LEAVE l_cursor;
        END IF;

        SET VSaldoFuncion = saldo_cuentas(VIdCuenta);

        IF VSaldoTabla <> VSaldoFuncion THEN

            SET VDescuadre = VSaldoFuncion - VSaldoTabla;

            SELECT CONCAT(
                'Cuenta ',
                VIdCuenta,
                ' | ',
                VIban,
                ' | saldo tabla: ',
                VSaldoTabla,
                ' | saldo función: ',
                VSaldoFuncion,
                ' | descuadre: ',
                VDescuadre
            ) AS Resultado;

            UPDATE cuentas
            SET saldo = VSaldoFuncion
            WHERE id = VIdCuenta;

        END IF;

    END LOOP;

    CLOSE Cursor01;

END $$

DELIMITER ;

CALL actualizar_saldo();


-- Actividad 2. mantenimiento(cuota)
-- Base de datos bancos
-- Aplica una cuota de mantenimiento a todas las cuentas

DELIMITER $$

DROP PROCEDURE IF EXISTS bancos.mantenimiento $$

CREATE PROCEDURE bancos.mantenimiento(IN cuota DECIMAL(10,2))

BEGIN

    DECLARE VIdCuenta INT;

    DECLARE lrf BOOLEAN;

    DECLARE Cursor01 CURSOR FOR
    SELECT id
    FROM cuentas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

    SET lrf = 0;

    OPEN Cursor01;

    l_cursor: LOOP

        FETCH Cursor01 INTO VIdCuenta;

        IF lrf = 1 THEN
            LEAVE l_cursor;
        END IF;

        INSERT INTO movimientos
        VALUES (
            NULL,
            VIdCuenta,
            NOW(),
            'Cuota mantenimiento 2026',
            'R',
            -cuota
        );

        UPDATE cuentas
        SET saldo = saldo - cuota
        WHERE id = VIdCuenta;

    END LOOP;

    CLOSE Cursor01;

END $$

DELIMITER ;

CALL mantenimiento(15);


-- Actividad 3. cuota_mantenimiento_2()
-- Base de datos bancos
-- Cuota según el saldo de cada cuenta

DELIMITER $$

DROP PROCEDURE IF EXISTS bancos.cuota_mantenimiento_2 $$

CREATE PROCEDURE bancos.cuota_mantenimiento_2()

BEGIN

    DECLARE VIdCuenta INT;
    DECLARE VSaldo DECIMAL(10,2);
    DECLARE VCuota DECIMAL(10,2);

    DECLARE lrf BOOLEAN;

    DECLARE Cursor01 CURSOR FOR
    SELECT id, saldo
    FROM cuentas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET lrf = 1;

    SET lrf = 0;

    OPEN Cursor01;

    l_cursor: LOOP

        FETCH Cursor01
        INTO VIdCuenta, VSaldo;

        IF lrf = 1 THEN
            LEAVE l_cursor;
        END IF;

        CASE

            WHEN VSaldo < 2000 THEN
                SET VCuota = 20;

            WHEN VSaldo BETWEEN 2000 AND 10000 THEN
                SET VCuota = 10;

            ELSE
                SET VCuota = 5;

        END CASE;

        INSERT INTO movimientos
        VALUES (
            NULL,
            VIdCuenta,
            NOW(),
            'Cuota mantenimiento 2026',
            'R',
            -VCuota
        );

        UPDATE cuentas
        SET saldo = saldo - VCuota
        WHERE id = VIdCuenta;

    END LOOP;

    CLOSE Cursor01;

END $$

DELIMITER ;

CALL cuota_mantenimiento_2();

