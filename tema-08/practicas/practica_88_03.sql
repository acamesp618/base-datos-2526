-- Práctica 8.8 - Triggers II - Autorías
-- Adrian Campos Espejo

USE bancos;

-- Actividad 1. Crear la tabla autoria_movimientos

DROP TABLE IF EXISTS auditoria_movimientos;

CREATE TABLE IF NOT EXISTS auditoria_movimientos(

    id INT AUTO_INCREMENT PRIMARY KEY,

    evento VARCHAR(15),

    cuenta_id_ant INT UNSIGNED,
    fechahora_ant TIMESTAMP,
    tipo_ant CHAR(1),
    cantidad_ant DECIMAL(8,2),

    cuenta_id_nuv INT UNSIGNED,
    fechahora_nuv TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_nuv CHAR(1),
    cantidad_nuv DECIMAL(10,2),

    usuario VARCHAR(40),

    fecharegsitro TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- Actividad 2. Triggers auditar_nuevo_movimiento

DELIMITER $$

DROP TRIGGER IF EXISTS bancos.auditar_nuevo_movimiento $$
CREATE TRIGGER bancos.auditar_nuevo_movimiento
AFTER INSERT
ON movimientos
FOR EACH ROW

BEGIN

    INSERT INTO auditoria_movimientos
    (
        evento,
        cuenta_id_nuv,
        fechahora_nuv,
        tipo_nuv,
        cantidad_nuv,
        usuario
    )

    VALUES
    (
        'INSERT',
        NEW.cuenta_id,
        NEW.fechahora,
        NEW.tipo,
        NEW.cantidad,
        USER()
    );

END $$

DELIMITER ;

-- Actividad 3. Triggers auditar_update_movimientos

DELIMITER $$

DROP TRIGGER IF EXISTS bancos.auditar_update_movimientos $$
CREATE TRIGGER bancos.auditar_update_movimientos
AFTER UPDATE
ON movimientos
FOR EACH ROW

BEGIN

    INSERT INTO auditoria_movimientos
    (
        evento,

        cuenta_id_ant,
        fechahora_ant,
        tipo_ant,
        cantidad_ant,

        cuenta_id_nuv,
        fechahora_nuv,
        tipo_nuv,
        cantidad_nuv,

        usuario
    )

    VALUES
    (
        'UPDATE',

        OLD.cuenta_id,
        OLD.fechahora,
        OLD.tipo,
        OLD.cantidad,

        NEW.cuenta_id,
        NEW.fechahora,
        NEW.tipo,
        NEW.cantidad,

        USER()
    );

END $$

DELIMITER ;

-- Actividad 4. Triggers auditar_delete_movimientos
DELIMITER $$

DROP TRIGGER IF EXISTS bancos.auditar_delete_movimientos $$
CREATE TRIGGER bancos.auditar_delete_movimientos
AFTER DELETE
ON movimientos
FOR EACH ROW

BEGIN

    INSERT INTO auditoria_movimientos
    (
        evento,
        cuenta_id_ant,
        fechahora_ant,
        tipo_ant,
        cantidad_ant,

        usuario
    )

    VALUES
    (
        'DELETE',

        OLD.cuenta_id,
        OLD.fechahora,
        OLD.tipo,
        OLD.cantidad,
        USER()
    );

END $$

DELIMITER ;
