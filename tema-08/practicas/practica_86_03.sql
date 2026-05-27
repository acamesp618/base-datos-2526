
-- Práctica 8.6 - Eventos
-- Adrian Campos Espejo

USE bancos;

-- Actividad 1. movimientos_semanales

DELIMITER $$

DROP EVENT IF EXISTS bancos.movimientos_semanales $$
CREATE EVENT bancos.movimientos_semanales
ON SCHEDULE EVERY 1 WEEK STARTS '2026-05-25 00:00:00'

DO

BEGIN

    SELECT *
    FROM movimientos
    INTO OUTFILE 'c:moviweek.csv'
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    ;

END $$

DELIMITER;

-- Actividad 2. Evento verificacion_saldo_diario

DELIMITER $$

DROP EVENT IF EXISTS bancos.verificacion_saldo_diario
CREATE EVENT bancos.verificacion_saldo_diario
ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP

DO

BEGIN
    CALL actualizar_saldo();
END $$

DELIMITER ;

-- Actividad 3. Evento verificacion_cliente_mensual

DELIMITER $$

DROP EVENT IF EXISTS bancos.verificacion_cliente_mensual $$

CREATE EVENT bancos.verificacion_cliente_mensual

ON SCHEDULE
EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP

DO

BEGIN

    SELECT cl.id, cl.nombre, cl.apellidos, cl.email, c.iban, c.saldo
    FROM clientes cl
    INNER JOIN cuentas c
    ON cl.id = c.cliente_id

    WHERE c.saldo < 0

    INTO OUTFILE 'c:clientesenrojo.csv'

    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    ;

END $$

DELIMITER ;