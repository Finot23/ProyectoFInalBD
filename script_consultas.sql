[200~- 1. Listar productos disponibles por categoría, ordenados por precio
SELECT p.nombre_producto, p.precio, p.stock, c.nombre_categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE p.stock > 0
ORDER BY c.nombre_categoria, p.precio;

-- 2. Mostrar clientes con pedidos pendientes y total de compras
SELECT cl.id_clientes, cl.nombre_cliente, cl.correo_electronico,
       COUNT(p.id_pedido) AS pedidos_pendientes,
       COALESCE(SUM(dp.cantidad * pr.precio), 0) AS total_compras
FROM clientes cl
JOIN pedidos p ON cl.id_clientes = p.id_cliente
JOIN estado_pedido ep ON p.id_estado_pedido = ep.id_estado_pedido
LEFT JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
LEFT JOIN productos pr ON dp.id_producto = pr.id_producto
WHERE ep.estado = 'pendiente' 
GROUP BY cl.id_clientes
ORDER BY cl.id_clientes; 

-- 3. Reporte de los 5 productos con mejor calificación promedio en reseñas
SELECT pr.nombre_producto, AVG(r.calificacion) AS calificacion_promedio
FROM productos pr
JOIN resenas r ON pr.id_producto = r.id_producto
GROUP BY pr.id_producto
ORDER BY calificacion_promedio DESC
LIMIT 5;	
