-- Adrian Campos Espejo
-- Examen Practico Tema 8

-- Ejercicio 1.  resumen_cliente() - Funcion - BD: bancos
    -- Tipo: Función
    -- Nombre: resumen_cliente()
    -- Parámetro de entrada: id de un cliente (INT UNSIGNED)
    -- Devuelve: El número total de cuentas que tiene ese cliente (INT)
    -- Descripción: Dada la id de un cliente, la función deberá devolver cuántas cuentas tiene registradas en la base de datos.

USE bancos;
DROP FUNCTION IF EXISTS resumen_cliente;

DELIMITER $$

CREATE FUNCTION resumen_cliente(p_cliente_id INT UNSIGNED)
RETURNS INT

BEGIN

    DECLARE v_num_cuentas INT;
    SELECT SUM(*)
    INTO v_num_cuentas
    FROM cuentas
    WHERE cliente_id = p_cliente_id;
    RETURN (v_num_cuentas);

END $$

DELIMITER ;

-- Ejercicio 2. saldo_medio_ciudad() - Funcion - BD: bancos
    -- Tipo: Función
    -- Nombre: saldo_medio_ciudad()
    -- Parámetro de entrada: nombre de una ciudad (VARCHAR(50))
    -- Devuelve: El saldo medio de todas las cuentas pertenecientes a clientes de esa ciudad (DECIMAL(10,2))
    -- Descripción: Calcular el saldo medio de las cuentas cuyos titulares residen en la ciudad indicada. Si no hay clientes en esa ciudad, devolver 0.00.

DELIMITER $$
DROP FUNCTION IF EXISTS saldo_medio_ciudad()$$
CREATE FUNCTION saldo_medio_ciudad(p_nombre_ciudad VARCHAR(50))
RETURNS DECIMAL(10,2)

BEGIN

    DECLARE v_saldo_medio DECIMAL(10,2);
    SELECT AVG(c.saldo)
    INTO v_saldo_medio
    FROM cuentas c
    INNER JOIN clientes cl
        ON c.cliente_id = cl.id
    WHERE cl.ciudad = p_ciudad;

    RETURN (v_saldo_medio);

END $$

DELIMITER ;

-- Ejercicio 3. clientes_saldo_negativo() — Procedimiento · BD: bancos
    -- Tipo: Procedimiento
    -- Nombre: clientes_saldo_negativo()
    -- Parámetros de entrada: ninguno
    -- Descripción: El procedimiento deberá devolver un listado con todos los clientes que tienen al menos una cuenta con saldo negativo (menor que 0).
    -- El listado mostrará:
        -- id del cliente
        -- nombre
        -- apellidos
        -- email
        -- iban de la cuenta en rojo
        -- saldo de esa cuenta
DELIMITER $$

DROP PROCEDURE  IF EXISTS clientes_saldo_negativo()$$
CREATE FUNCTION clientes_saldo_negativo()

BEGIN

    SELECT
        cl.id,
        cl.nombre,
        cl.apellidos,
        cl.email,
        c.iban,
        c.saldo

    FROM clientes cl

    INNER JOIN cuentas c
        ON cl.id = c.cliente_id

    WHERE c.saldo < 0;

END $$

DELIMITER ;


-- Ejercicio 4. aplicar_interes() — Procedimiento con cursor · BD: bancos
    -- Tipo: Procedimiento
    -- Nombre: aplicar_interes()
    -- Parámetro de entrada: porcentaje de interés (DECIMAL(5,2))
    -- Cursor: deberá recorrer todas las cuentas con saldo mayor que 0.
    -- Descripción: Para cada cuenta con saldo positivo, insertar un nuevo movimiento en la tabla movimientos con:
        -- Fecha y hora actual
        -- Concepto: 'Abono de intereses'
        -- Tipo: 'I' (ingreso)
        -- Importe: saldo de la cuenta × (porcentaje / 100)
    -- Después de insertar el movimiento, actualizar el saldo de la cuenta sumando el importe abonado.

DELIMITER $$
DROP PROCEDURE IF EXISTS aplicar_interes;
CREATE PROCEDURE aplicar_interes(p_porcentaje DECIMAL(5,2))

BEGIN

    DECLARE v_cuenta_id INT UNSIGNED;
    DECLARE v_saldo DECIMAL(10,2);
    DECLARE v_interes DECIMAL(10,2);

    DECLARE cur_cuentas CURSOR FOR

        SELECT id, saldo
        FROM cuentas
        WHERE saldo > 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET l_last_row_fetched=1;

    OPEN cur_cuentas;

    bucle: LOOP

        FETCH cur_cuentas
        INTO v_cuenta_id, v_saldo;

        SET v_interes = v_saldo * (p_porcentaje / 100);

        INSERT INTO movimientos
        VALUES
        (
            NULL,
            v_cuenta_id,
            NOW(),
            'Abono de intereses',
            'I',
            v_interes
        );

        UPDATE cuentas
        SET saldo = saldo + v_interes
        WHERE id = v_cuenta_id;

    END LOOP;

    CLOSE cur_cuentas;

END $$

DELIMITER ;

-- Ejercicio 5. actualizar_stock_venta — Trigger · BD: geslibros
    -- Tipo: Trigger
    -- Nombre: actualizar_stock_venta
    -- Momento: AFTER
    -- Evento: INSERT
    -- Tabla: lineasventas
    -- Descripción: Cada vez que se inserte una línea de venta, se deberá decrementar el stock del libro correspondiente en la tabla libros según la cantidad indicada en la línea de venta.
    -- Ejemplo: Si se venden 4 unidades del libro con id = 7, el campo stock del libro 7 debe reducirse en 4 unidades.

USE geslibros;

DELIMITER $$
DROP TRIGGER IF EXISTS control_precio_libro $$

CREATE TRIGGER actualizar_stock_venta
AFTER INSERT
ON lineasventas
FOR EACH ROW

BEGIN

    UPDATE libros
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.libro_id;

END $$

DELIMITER ;

-- Ejercicio 6. control_precio_libro — Trigger · BD: geslibros
    -- Tipo: Trigger
    -- Nombre: control_precio_libro
    -- Momento: BEFORE
    -- Evento: UPDATE
    -- Tabla: libros
    -- Descripción: Antes de actualizar un libro, comprobar que el nuevo precio de venta (precio_venta) no sea inferior al precio de coste (precio_coste). Si el nuevo precio_venta fuera menor o igual al precio_coste, se deberá asignar automáticamente como precio_venta el valor de precio_coste multiplicado por 1.10 (es decir, con un margen mínimo del 10%).
    -- Observaciones: El alumno debe identificar correctamente las referencias NEW y OLD.

USE geslibros;
DELIMITER $$
DROP TRIGGER IF EXISTS control_precio_libro;
CREATE TRIGGER control_precio_libro
BEFORE UPDATE
ON libros
FOR EACH ROW

BEGIN

    IF NEW.precio_venta <= NEW.precio_coste THEN
        SET NEW.precio_venta = NEW.precio_coste * 1.10;
    END IF;

END $$

DELIMITER ;

-- Ejercicio 7. verificar_importes_ventas() — Procedimiento con cursor · BD: geslibros
    -- Tipo: Procedimiento
    -- Nombre: verificar_importes_ventas()
    -- Parámetros de entrada: ninguno
    -- Cursor: deberá recorrer todas las ventas de la tabla ventas.
    -- Descripción: Para cada venta, comparar el valor almacenado en la columna importe_bruto con la suma real de la columna importe de sus registros en lineasventas. Si los importes no coinciden, actualizar importe_bruto con el valor correcto y mostrar por pantalla:
        -- id de la venta
        -- importe almacenado
        -- importe calculado
        -- diferencia

USE geslibros;
DELIMITER $$

DROP PROCEDURE IF EXISTS verificar_importes_ventas()$$
DELIMITER $$

CREATE PROCEDURE verificar_importes_ventas()

BEGIN

    DECLARE v_venta_id INT UNSIGNED;
    DECLARE v_importe_bruto DECIMAL(10,2);
    DECLARE v_importe_calculado DECIMAL(10,2);

    DECLARE cur_ventas CURSOR FOR

        SELECT id, importe_bruto
        FROM ventas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET l_last_row_fetched=1;

    OPEN cur_ventas;

    bucle: LOOP

        FETCH cur_ventas
        INTO v_venta_id, v_importe_bruto;

        SELECT SUM(importe)
        INTO v_importe_calculado
        FROM lineasventas
        WHERE venta_id = v_venta_id;

        IF v_importe_bruto <> v_importe_calculado THEN

            SELECT
                v_venta_id AS id_venta,
                v_importe_bruto AS importe_almacenado,
                v_importe_calculado AS importe_calculado,
                (v_importe_calculado - v_importe_bruto)
                AS diferencia;

            UPDATE ventas

            SET importe_bruto = v_importe_calculado

            WHERE id = v_venta_id;

        END IF;

    END LOOP;

    CLOSE cur_ventas;

END $$

DELIMITER ;

-- Ejercicio 8. exportar_movimientos_diarios — Evento · BD: bancos
    - Tipo: Evento
    - Nombre: exportar_movimientos_diarios
    - Tipo de planificación: periódico, con frecuencia diaria
    - Inicio: mañana a las 00:00:00
    - Duración máxima: 1 año desde la fecha de inicio
    - Descripción: Al final de cada día, generar un fichero CSV llamado movimientos_dia.csv con todos los movimientos registrados durante ese día (fecha igual a CURDATE()).
    - El fichero incluirá las columnas:
        - id del movimiento
        - fecha
        - concepto
        - tipo
        - importe
        - iban de la cuenta asociada
    - Separador de columnas: ;

USE bancos;

DELIMITER $$

DROP EVENT IF EXISTS exportar_movimientos_diarios $$
CREATE EVENT exportar_movimientos_diarios
ON SCHEDULE
EVERY 1 DAY
STARTS "2026-06-02 00:00:00"
ENDS "2027-06-02 00:00:00"

DO
BEGIN

    SELECT
        m.id,
        m.fechahora,
        m.concepto,
        m.tipo,
        m.cantidad,
        c.iban

    INTO OUTFILE 'c:movimientos_dia.csv'

    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'

    FROM movimientos m

    INNER JOIN cuentas c
        ON m.cuenta_id = c.id

    WHERE DATE(m.fechahora) = CURDATE();

END  $$

DELIMITER ;
