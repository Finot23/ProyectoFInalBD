[200~CREATE DATABASE tienda;
CREATE DATABASE TIENDA;
USE tienda;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

CREATE TABLE categorias (
  id_categoria int(11) NOT NULL AUTO_INCREMENT,
  nombre_categoria varchar(100) NOT NULL,
  descripcion text NOT NULL,
  PRIMARY KEY (id_categoria)
);

CREATE TABLE clientes (
  id_clientes int(11) NOT NULL AUTO_INCREMENT,
  nombre_cliente varchar(255) NOT NULL,
  correo_electronico varchar(255) NOT NULL UNIQUE,
  direccion varchar(255) NOT NULL,
  numero_telefono varchar(20) NOT NULL,
  PRIMARY KEY (id_clientes)
);

CREATE TABLE estado_pedido (
  id_estado_pedido int(11) NOT NULL AUTO_INCREMENT,
  estado varchar(50) NOT NULL,
  PRIMARY KEY (id_estado_pedido)
);

CREATE TABLE pedidos (
  id_pedido int(11) NOT NULL AUTO_INCREMENT,
  id_cliente int(11) NOT NULL,
  id_estado_pedido int(11) NOT NULL,
  fecha_pedido datetime NOT NULL,
  PRIMARY KEY (id_pedido),
  KEY fk_pedidos_clientes (id_cliente),
  KEY fk_pedidos_estado (id_estado_pedido),
  CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES clientes (id_clientes) ON UPDATE CASCADE,
  CONSTRAINT fk_pedidos_estado FOREIGN KEY (id_estado_pedido) REFERENCES estado_pedido (id_estado_pedido) ON UPDATE CASCADE
);

CREATE TABLE productos (
  id_producto int(11) NOT NULL AUTO_INCREMENT,
  id_categoria int(11) NOT NULL,
  nombre_producto varchar(255) NOT NULL,
  descripcion text NOT NULL,
  precio decimal(10,2) NOT NULL,
  stock int(11) NOT NULL,
  PRIMARY KEY (id_producto),
  KEY fk_productos_categorias (id_categoria),
  CONSTRAINT fk_productos_categorias FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria) ON UPDATE CASCADE
);

CREATE TABLE detalle_pedido (
  id_detalle_pedido int(11) NOT NULL AUTO_INCREMENT,
  id_pedido int(11) NOT NULL,
  id_producto int(11) NOT NULL,
  cantidad int(11) NOT NULL,
  precio_total decimal(10,2) NOT NULL,
  PRIMARY KEY (id_detalle_pedido),
  KEY fk_detalle_pedido_pedido (id_pedido),
  KEY fk_detalle_pedido_producto (id_producto),
  CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido) ON UPDATE CASCADE,
  CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto) ON UPDATE CASCADE
);

CREATE TABLE resenas (
  id_resena int(11) NOT NULL AUTO_INCREMENT,
  id_producto int(11) NOT NULL,
  id_cliente int(11) NOT NULL,
  calificacion int(11) NOT NULL,
  comentario text NOT NULL,
  fecha_resena datetime NOT NULL,
  PRIMARY KEY (id_resena),
  KEY fk_resenas_producto (id_producto),
  KEY fk_resenas_cliente (id_cliente),
  CONSTRAINT fk_resenas_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto) ON UPDATE CASCADE,
  CONSTRAINT fk_resenas_cliente FOREIGN KEY (id_cliente) REFERENCES clientes (id_clientes) ON UPDATE CASCADE
);
