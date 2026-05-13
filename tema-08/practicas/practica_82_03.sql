-- Actividad 7.11 - Examen años anteriores
-- Adrian Campos Espejo

-- Actividad 1. saldo_total

DELIMITER $$

CREATE FUNCTION saldo_total()
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(saldo)
    INTO total
    FROM cuentas;

    RETURN total;
END $$

DELIMITER ;
SELECT saldo_total();

-- Actividad 2. mejor_cliente

DELIMITER $$

CREATE FUNCTION mejor_cliente()
RETURNS INT UNSIGNED
READS SQL DATA
BEGIN
    DECLARE id_mejor INT UNSIGNED;

    SELECT cliente_id
    INTO id_mejor
    FROM cuentas
    ORDER BY saldo DESC
    LIMIT 1;

    RETURN id_mejor;
END $$

DELIMITER ;
SELECT mejor_cliente();

-- Actividad 3. Funcion saldo_cuentas
DELIMITER $$

CREATE FUNCTION saldo_cuentas(p_cuenta_id INT UNSIGNED)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(cantidad)
    INTO total
    FROM movimientos
    WHERE cuenta_id = p_cuenta_id;

    RETURN total;
END $$

DELIMITER ;

-- Actividad 4. Procedimiento verificar_saldo

DELIMITER $$

CREATE PROCEDURE verificar_saldo(IN p_cuenta_id INT UNSIGNED)
BEGIN
    DECLARE saldo_tabla DECIMAL(10,2);
    DECLARE saldo_verificado DECIMAL(10,2);

    SELECT saldo
    INTO saldo_tabla
    FROM cuentas
    WHERE id = p_cuenta_id;

    SET saldo_verificado = saldo_cuentas(p_cuenta_id);

    IF saldo_tabla <> saldo_verificado THEN

        SELECT 'CUENTA CON SALDO NO VERIFICADO', *
        FROM cuentas
        WHERE id = p_cuenta_id;

    END IF;
END $$

DELIMITER ;
CALL verificar_saldo(1);

-- Actividad 5. Prodecimiento auditar_saldo

DELIMITER $$

CREATE PROCEDURE auditar_saldo(IN p_cuenta_id INT UNSIGNED)
BEGIN
    DECLARE saldo_tabla DECIMAL(10,2);
    DECLARE saldo_real DECIMAL(10,2);

    SELECT saldo
    INTO saldo_tabla
    FROM cuentas
    WHERE id = p_cuenta_id;

    SET saldo_real = saldo_cuentas(p_cuenta_id);

    IF saldo_tabla <> saldo_real THEN

        UPDATE cuentas
        SET saldo = saldo_real
        WHERE id = p_cuenta_id;

    END IF;
END $$

DELIMITER ;
CALL auditar_saldo(1);