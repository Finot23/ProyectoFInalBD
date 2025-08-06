-- Indice para buscar producto por nombre
CREATE INDEX idx_nombre_producto ON productos(nombre);

-- Indice para obtener preductos por categoria
CREATE INDEX idx_categoria_producto ON productos(id_categoria);

-- Indice para obtener pedidos por cliente
CREATE INDEX idx_cliente_pedido ON pedidos(id_cliente);
