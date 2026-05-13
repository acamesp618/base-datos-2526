-- Actividad 8.1 - Procedimientos en MySQL
-- Adrian Campos Espejo
USE bancos;

-- Ejercicio 1 - Procedimiento Clientes
-- Parametros: ciudad (VARCHAR2)
-- Descripcion: Devuelve una lista de clientes que residen en la ciudad especificada
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_por_ciudad $$
CREATE PROCEDURE clientes_por_ciudad(IN p_ciudad VARCHAR(20))
BEGIN
    SELECT * FROM clientes WHERE ciudad = p_ciudad;
END $$

DELIMITER ;
CALL clientes_por_ciudad('Ubrique');

-- Actividad 2 - Procedimiento Movimientos
-- Parametros: p_id_cuenta (INT UNSIGNED)
-- Descripcion: Devuelve todos los movimientos de una determinada cuenta 
DELIMITER $$
DROP PROCEDURE IF EXISTS movimientos_cuenta $$
CREATE PROCEDURE movimientos_cuenta(IN p_cuenta_id INT UNSIGNED)
BEGIN
    SELECT * FROM movimientos WHERE cuenta_id = p_cuenta_id ORDER BY fechahora DESC;
END $$

DELIMITER ;
CALL movimientos_cuenta(2);

-- Actividad 3 - Procedimiento Cuentas
-- Parametros: id_cliente (INT UNSIGNED)
-- Descripcion: Devuelve  las cuentas de un determinado cliente 
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_cuentas $$
CREATE PROCEDURE clientes_cuentas(IN p_cliente_id INT UNSIGNED)
BEGIN
    SELECT * FROM cuentas WHERE cliente_id = p_cliente_id;
END $$

DELIMITER ;
CALL clientes_cuentas(2);

-- Actividad 4 - Procedimiento SaldosBajos
-- Parametros: id_cliente (INT UNSIGNED)
-- Descripcion: Devuelve id, iban, nombre, apellidos, dni, saldo actual
DELIMITER $$
DROP PROCEDURE IF EXISTS saldosBajos $$
CREATE PROCEDURE saldosBajos(IN p_saldo DECIMAL(10,2))
BEGIN
    SELECT 
    cuentas.id AS cuenta,
    cuentas.iban,
    clientes.nombre,
    clientes.apellidos,
    clientes.dni,
    cuentas.saldo
    FROM cuentas
    JOIN clientes ON cuentas.cliente_id = cliente_id
    WHERE cuentas.saldo <= p_saldo;
END $$

DELIMITER ;
CALL saldosBajos(200.00);

-- Actividad 4 - Procedimiento SaldosBajos
-- Parametros: id_cliente (INT UNSIGNED)
-- Descripcion: Devuelve el saldo total por cliente ordenado alfabeticamente
DELIMITER $$

CREATE PROCEDURE saldo_total_cliente()
BEGIN
    SELECT 
        clientes.id AS id_cliente,
        clientes.nombre,
        clientes.apellidos,
        clientes.dni,
        clientes.ciudad,
        SUM(cuentas.saldo) AS saldo_total
    FROM clientes
    LEFT JOIN cuentas ON clientes.id = cuentas.cliente_id
    GROUP BY clientes.id, clientes.nombre, clientes.apellidos, clientes.dni, clientes.ciudad
    ORDER BY clientes.apellidos, clientes.nombre;
END $$

DELIMITER ;

CALL saldo_total_cliente();