-- Práctica 8.5 - Triggers
-- Adrian Campos Espejo

USE bancos;

-- Actividad 1. bonificacion_apertura
-- Descripcion: Trigger que añade automáticamente una
-- bonificación de 20€ al crear una nueva cuenta
-- Nombre: bonificacion_apertura
-- Momento: AFTER
-- Evento: INSERT
-- Tabla: cuentas


DELIMITER $$

DROP TRIGGER IF EXISTS bonificacion_apertura $$
CREATE TRIGGER bonificacion_apertura
AFTER INSERT
ON cuentas
FOR EACH ROW
BEGIN

    INSERT INTO movimientos (
        cuenta_id,
        fechahora,
        concepto,
        tipo,
        cantidad
    )
    VALUES (
        NEW.id,
        NOW(),
        'Bonificación de Apertura Cuenta',
        'I',
        20.00
    );

END$$

DELIMITER ;

-- Uso del trigger bonificacion_apertura

DELIMITER;
INSERT INTO cuentas (id, iban, cliente_id, fecha, saldo)
VALUES (null, 'ES22210311111235891231', 1, NOW(), 0.00);


-- Actividad 2. validar_movimiento
-- Descripcion: Trigger que valida los movimientos
-- de ingreso y reintegro actualizando el saldo
-- Nombre: validar_movimiento
-- Momento: BEFORE
-- Evento: INSERT
-- Tabla: movimientos


DELIMITER $$

DROP TRIGGER IF EXISTS validar_movimiento $$
CREATE TRIGGER validar_movimiento
BEFORE INSERT
ON movimientos
FOR EACH ROW
BEGIN

    DECLARE saldo_actual DECIMAL(10,2);

    -- Obtener saldo actual de la cuenta
    SELECT saldo
    INTO saldo_actual
    FROM cuentas
    WHERE id = NEW.cuenta_id;

    -- REINTEGRO
    
    IF NEW.tipo = 'R' THEN

        -- Si no hay saldo suficiente
        IF ABS(NEW.cantidad) > saldo_actual THEN

            SET NEW.cantidad = 0;

        ELSE

            -- Actualizar saldo
            UPDATE cuentas
            SET saldo = saldo + NEW.cantidad
            WHERE id = NEW.cuenta_id;

        END IF;

    END IF;

    
    -- INGRESO
   
    IF NEW.tipo = 'I' THEN

        UPDATE cuentas
        SET saldo = saldo + NEW.cantidad
        WHERE id = NEW.cuenta_id;

    END IF;

END$$

DELIMITER ;

-- Ingreso correcto
INSERT INTO movimientos (id, cuenta_id, fechahora, concepto, tipo, cantidad)
VALUES ( NULL, 1, NOW(), 'Ingreso Nómina', 'I', 500.00);

-- Reintegro correcto
INSERT INTO movimientos (id, cuenta_id, fechahora, concepto, tipo, cantidad)
VALUES (NULL, 1, NOW(), 'Retirada Cajero', 'R', -100.00);

-- Reintegro sin saldo suficiente
INSERT INTO movimientos (id, cuenta_id, fechahora, concepto, tipo, cantidad)
VALUES (NULL, 2, NOW(), 'Intento Retirada Grande', 'R', -9999.00);
