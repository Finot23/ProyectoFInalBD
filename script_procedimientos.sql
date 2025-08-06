DELIMITER $$

-- 1. Registrar un nuevo pedido, verificando límite de 5 pedidos pendientes y stock suficiente
CREATE PROCEDURE sp_registrar_pedido(
    IN id_cl INT,
    IN id_prod INT,
    IN cantidad INT,
    IN fecha_ped DATE
)
BEGIN
    DECLARE pedidos_pendientes INT;
    DECLARE stock_actual INT;
    DECLARE nuevo_id_pedido INT;

    SELECT COUNT(*) INTO pedidos_pendientes
    FROM pedidos
    WHERE id_cliente = id_cl AND id_estado_pedido = 1; -- pendiente = 1

    IF pedidos_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya tiene 5 pedidos pendientes';
    ELSE
        SELECT stock INTO stock_actual
        FROM productos
        WHERE id_producto = id_prod;

        IF stock_actual < cantidad THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No hay suficiente stock para este producto';
        ELSE
            INSERT INTO pedidos (id_cliente, id_estado_pedido, fecha_pedido)
            VALUES (id_cl, 1, fecha_ped);

            SELECT LAST_INSERT_ID() INTO nuevo_id_pedido;

            INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_total)
            VALUES (
                nuevo_id_pedido,
                id_prod,
                cantidad,
                cantidad * (SELECT precio FROM productos WHERE id_producto = id_prod)
            );

            UPDATE productos SET stock = stock - cantidad WHERE id_producto = id_prod;
        END IF;
    END IF;
END$$

-- 2. Registrar una reseña, verificando que el cliente haya comprado el producto
CREATE PROCEDURE sp_registrar_resena(
    IN id_cl INT,
    IN id_ped INT,
    IN id_prod INT,
    IN calificacion INT,
    IN comentario TEXT,
    IN fecha_res DATE
)
BEGIN
    IF (
        SELECT COUNT(*) 
        FROM pedidos p
        INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
        WHERE p.id_pedido = id_ped AND p.id_cliente = id_cl
        AND dp.id_producto = id_prod
    ) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no ha comprado este producto';
    ELSE
        INSERT INTO resenas (id_producto, id_cliente, calificacion, comentario, fecha_resena)
        VALUES (id_prod, id_cl, calificacion, comentario, fecha_res);
    END IF;
END$$

-- 3. Actualizar stock de un producto después de venta
CREATE PROCEDURE sp_actualizar_stock (
    IN id_prod INT,
    IN cantidad_vendida INT
)
BEGIN
    IF (
        SELECT stock
        FROM productos
        WHERE id_producto = id_prod 
    ) < cantidad_vendida THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este producto no tiene stock suficiente';
    ELSE
        UPDATE productos
        SET stock = stock - cantidad_vendida
        WHERE id_producto = id_prod;
    END IF;
END$$

-- 4. Cambiar estado de un pedido
CREATE PROCEDURE sp_cambiar_estado(
    IN id_ped INT,
    IN nuevo_estado INT
)
BEGIN
    IF nuevo_estado NOT IN (1, 2, 3) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado no existente (1-3)';
    ELSEIF NOT EXISTS (
        SELECT 1 FROM pedidos WHERE id_pedido = id_ped
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El pedido no existe';
    ELSE
        UPDATE pedidos SET id_estado_pedido = nuevo_estado 
        WHERE id_pedido = id_ped;
    END IF;
END$$

-- 5. Eliminar reseñas de un producto específico
CREATE PROCEDURE sp_eliminar_resena(IN id_prod INT)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM resenas WHERE id_producto = id_prod
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay reseñas de ese producto';
    ELSE
        DELETE FROM resenas WHERE id_producto = id_prod;
    END IF;
END$$

-- 6. Agregar un nuevo producto, verificando duplicado por nombre y categoría
CREATE PROCEDURE sp_agregar_producto(
    IN nombre VARCHAR(255),
    IN descripcion TEXT,
    IN precio DECIMAL(10,2),
    IN stock INT,
    IN id_categoria INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM productos WHERE nombre_producto = nombre AND id_categoria = id_categoria
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe un producto con ese nombre y categoría';
    ELSE
        INSERT INTO productos (nombre_producto, descripcion, precio, stock, id_categoria)
        VALUES (nombre, descripcion, precio, stock, id_categoria);
    END IF;
END$$

-- 7. Actualizar el número de teléfono de un cliente
CREATE PROCEDURE sp_actualizar_telefono_cliente(
    IN id_cl INT,
    IN nuevo_tel VARCHAR(20)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM clientes WHERE id_clientes = id_cl
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se encontró al cliente';
    ELSEIF EXISTS (
        SELECT 1 FROM clientes WHERE numero_telefono = nuevo_tel AND id_clientes <> id_cl
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono ya está registrado por otro cliente';
    ELSE
        UPDATE clientes SET numero_telefono = nuevo_tel
        WHERE id_clientes = id_cl;
    END IF;
END$$

-- 8. Reporte de productos con stock bajo (<=5)
CREATE PROCEDURE sp_reporte_stock()
BEGIN
    SELECT nombre_producto, stock FROM productos
    WHERE stock <= 5
    ORDER BY stock ASC;
END$$

DELIMITER ;

