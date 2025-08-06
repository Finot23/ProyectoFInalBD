DELIMITER $$

CREATE TRIGGER limitar_pedidos_pendientes
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    DECLARE pedidos_pendientes INT;

    SELECT COUNT(*) INTO pedidos_pendientes
    FROM pedidos
    WHERE id_cliente = NEW.id_cliente AND id_estado_pedido = 1;

    IF NEW.id_estado_pedido = 1 AND pedidos_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya tiene 5 pedidos pendientes.';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER validar_resena
BEFORE INSERT ON resenas
FOR EACH ROW
BEGIN
    DECLARE conteo INT;

    SELECT COUNT(*) INTO conteo
    FROM pedidos p
    JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
    WHERE p.id_cliente = NEW.id_cliente
      AND dp.id_producto = NEW.id_producto;

    IF conteo = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no puede reseñar un producto que no compró.';
    END IF;
END$$

DELIMITER ;
-- Índice para búsqueda por fecha de pedido
CREATE INDEX idx_fecha_pedido ON pedidos(fecha_pedido);

-- Índice para búsqueda por estado del pedido
CREATE INDEX idx_estado_pedido ON pedidos(id_estado_pedido);

-- Índice para obtener los detalles del pedido por su ID
CREATE INDEX idx_id_pedido_detalle ON detalle_pedido(id_pedido);

-- Índice para búsqueda de clientes por correo electrónico
CREATE INDEX idx_correo_cliente ON clientes(correo_electronico);
CREATE VIEW vista_productos_economicos AS
SELECT id_producto, nombre_producto, precio
FROM productos
WHERE precio < 5000.00;

-- Consulta ejemplo
SELECT * FROM vista_productos_economicos;
