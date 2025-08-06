[200~-- Poblar tabla categorias
INSERT INTO categorias (nombre_categoria, descripcion) VALUES
('Teléfonos', 'Smartphones y móviles de diferentes marcas'),
('Laptops', 'Portátiles para trabajo y entretenimiento'),
('Accesorios', 'Cargadores, fundas, audífonos, etc.');

-- Poblar tabla clientes (15)
INSERT INTO clientes (nombre_cliente, correo_electronico, direccion, numero_telefono) VALUES
('Juan Pérez', 'juan1@gmail.com', 'Av. Reforma 123', '5512345678'),
('Ana Torres', 'ana2@gmail.com', 'Calle Morelos 45', '5512345679'),
('Luis Gómez', 'luis3@gmail.com', 'Insurgentes Sur 33', '5512345680'),
('María López', 'maria4@gmail.com', 'Av. Universidad 99', '5512345681'),
('Carlos Sánchez', 'carlos5@gmail.com', 'Norte 7, CDMX', '5512345682'),
('Fernanda Díaz', 'fernanda6@gmail.com', 'Sur 20, CDMX', '5512345683'),
('Alejandro Ruiz', 'alejandro7@gmail.com', 'Centro, Puebla', '5512345684'),
('Lucía Herrera', 'lucia8@gmail.com', 'Oeste 13, GDL', '5512345685'),
('Miguel Ángel', 'miguel9@gmail.com', 'Zona Centro, QRO', '5512345686'),
('Sofía Medina', 'sofia10@gmail.com', 'Av. Juárez 17', '5512345687'),
('Ricardo Lara', 'ricardo11@gmail.com', 'Calle 5, MTY', '5512345688'),
('Laura Vargas', 'laura12@gmail.com', 'Av. Hidalgo 77', '5512345689'),
('Diego Castro', 'diego13@gmail.com', 'Col. Roma, CDMX', '5512345690'),
('Valeria Ramos', 'valeria14@gmail.com', 'CDMX Sur', '5512345691'),
('Jorge Mendoza', 'jorge15@gmail.com', 'Querétaro Norte', '5512345692');

-- Poblar tabla productos (30)
INSERT INTO productos (id_categoria, nombre_producto, descripcion, precio, stock) VALUES
(1, 'iPhone 13', 'Smartphone de Apple', 17999.00, 25),
(1, 'Samsung Galaxy S21', 'Smartphone Android', 15999.00, 18),
(1, 'Xiaomi Redmi Note 10', 'Gama media Android', 6999.00, 30),
(1, 'Motorola G9', 'Teléfono económico', 4999.00, 50),
(1, 'Huawei P30', 'Smartphone con buena cámara', 10999.00, 10),
(2, 'MacBook Air M1', 'Laptop Apple con chip M1', 23999.00, 15),
(2, 'Dell XPS 13', 'Ultrabook profesional', 18999.00, 12),
(2, 'HP Pavilion', 'Laptop para estudiantes', 13999.00, 20),
(2, 'Lenovo IdeaPad 3', 'Laptop económica', 8999.00, 25),
(2, 'Asus ROG', 'Laptop gamer', 29999.00, 7),
(3, 'Cargador USB-C', 'Carga rápida 20W', 299.00, 100),
(3, 'Funda para iPhone', 'Funda de silicón', 199.00, 80),
(3, 'Audífonos Bluetooth', 'Inalámbricos y compactos', 499.00, 70),
(3, 'Teclado inalámbrico', 'Compatible con todos los SO', 699.00, 30),
(3, 'Mouse gamer', 'Con luces RGB', 599.00, 50),
(1, 'iPhone 12', 'Modelo anterior de Apple', 14999.00, 10),
(2, 'HP Envy', 'Laptop de gama alta', 15999.00, 8),
(2, 'Acer Aspire', 'Laptop básica para casa', 7999.00, 15),
(3, 'Cable HDMI', 'Cable de 2 metros', 199.00, 60),
(3, 'Power Bank 10000mAh', 'Batería externa', 399.00, 40),
(3, 'Soporte para laptop', 'Ergonómico y ajustable', 299.00, 25),
(1, 'Realme C25', 'Smartphone económico', 4499.00, 35),
(1, 'Nokia 5.4', 'Resistente y confiable', 5999.00, 20),
(2, 'Chromebook', 'Para tareas en la nube', 6999.00, 10),
(3, 'Hub USB 4 puertos', 'Expansión USB', 249.00, 90),
(3, 'Lámpara LED escritorio', 'Regulable', 349.00, 60),
(1, 'OnePlus Nord', 'Rendimiento premium', 12999.00, 13),
(2, 'LG Gram', 'Laptop liviana', 17999.00, 5),
(3, 'Audífonos con micrófono', 'Ideales para videollamadas', 399.00, 30),
(3, 'Webcam HD', 'Cámara para streaming', 799.00, 22);

-- Poblar tabla estado_pedido (3 estados)
INSERT INTO estado_pedido (estado) VALUES
('pendiente'), ('enviado'), ('entregado');

-- Poblar tabla pedidos (20)
INSERT INTO pedidos (id_cliente, id_estado_pedido, fecha_pedido) VALUES
(1, 1, '2025-07-01'), (2, 2, '2025-07-02'), (3, 1, '2025-07-03'), (4, 3, '2025-07-04'), (5, 1, '2025-07-05'),
(6, 2, '2025-07-06'), (7, 3, '2025-07-07'), (8, 1, '2025-07-08'), (9, 2, '2025-07-09'), (10, 3, '2025-07-10'),
(11, 1, '2025-07-11'), (12, 2, '2025-07-12'), (13, 3, '2025-07-13'), (14, 1, '2025-07-14'), (15, 2, '2025-07-15'),
(1, 3, '2025-07-16'), (2, 1, '2025-07-17'), (3, 2, '2025-07-18'), (4, 3, '2025-07-19'), (5, 1, '2025-07-20');

-- Poblar tabla detalle_pedido (25)
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_total) VALUES
(1, 1, 1, 17999.00), (1, 11, 2, 598.00), (2, 6, 1, 23999.00), (3, 3, 1, 6999.00), (4, 5, 1, 10999.00),
(5, 9, 1, 8999.00), (6, 15, 1, 599.00), (7, 16, 1, 14999.00), (8, 19, 3, 597.00), (9, 25, 1, 249.00),
(10, 28, 1, 12999.00), (11, 29, 1, 17999.00), (12, 30, 2, 798.00), (13, 22, 1, 4499.00), (14, 24, 1, 6999.00),
(15, 21, 1, 299.00), (16, 17, 1, 15999.00), (17, 4, 2, 9998.00), (18, 13, 1, 499.00), (19, 8, 1, 13999.00),
(20, 14, 1, 699.00), (3, 19, 1, 399.00), (6, 26, 2, 25998.00), (10, 27, 1, 17999.00), (12, 23, 1, 5999.00);

-- Poblar tabla resenas (10)
INSERT INTO resenas (id_producto, id_cliente, calificacion, comentario, fecha_resena) VALUES
(1, 1, 5, 'Excelente teléfono, muy rápido.', '2025-07-05'),
(3, 2, 4, 'Buena relación calidad-precio.', '2025-07-06'),
(6, 3, 5, 'La MacBook es muy potente.', '2025-07-07'),
(9, 4, 4, 'Rinde bien para clases.', '2025-07-08'),
(11, 5, 3, 'Cumple con lo necesario.', '2025-07-09'),
(13, 6, 4, 'Cómodos para escuchar música.', '2025-07-10'),
(16, 7, 5, 'iPhone 12 sigue siendo excelente.', '2025-07-11'),
(19, 8, 4, 'Buena batería.', '2025-07-12'),
(22, 9, 5, 'Sorprendido por la calidad.', '2025-07-13'),
(25, 10, 3, 'Funciona bien como USB extra.', '2025-07-14');
