# Proyecto Final – Base de Datos para Tienda Online
**Alumno:** Salinas Mata Luis Antonio  
**Licenciatura:** Tecnologías y Sistemas de Información – UAM Cuajimalpa

---

## 1. Descripción del Problema 
Se nos pide la creación de una tienda online suponiendo que los productos electrónicos necesita un sistema para gestionar sus operaciones incluyendo:
- productos.
- clientes.
- pedidos (con detalles y estado).
- reseñas de productos.
- categorías. 

### Requisitos funcionales:

- **Gestión de Productos:** Nombre, descripción, precio, stock (no negativo), categoría.
- **Gestión de Clientes:** Nombre, correo (único), dirección, número de teléfono.
- **Pedidos:** Fecha, productos incluidos.
- **Reseñas:** Calificación (1–5 estrellas), comentario. Solo por clientes que hayan comprado el producto.
- **Categorías:** Clasificación de productos (ej. teléfonos, laptops, accesorios).
 
Se decidió agregar dos tablas más:

 - **detalle_pedido:** cantidad productos, precio total. 
 - **estado_pedido:** estado (pendiente, enviado, entregado)
   
Estas tablas adicionales permiten cumplir con la **Tercera Forma Normal (3NF)**

### Restricciones clave:

- Máximo 5 pedidos *pendientes* por cliente.
- El stock de productos no debe ser negativo.
- Las reseñas solo pueden ser hechas por clientes que compraron el producto.

### Objetivo General:

Diseñar una **base de datos relacional normalizada**, implementar consultas y al menos **8 procedimientos almacenados**, optimizarla con índices y validarla con datos de prueba.

---

## 2. Requisitos del Proyecto:

- Diseñar una base de datos relacional con al menos 5 tablas (Productos, Clientes, Pedidos, Reseñas, Categorías).

### Entregables: 
- Diagrama Entidad-Relación (ER) que modele entidades y relaciones.
- Esquema en tercera forma normal (3NF), con justificación de normalización.
- Identificación de claves primarias, foráneas y candidatas.

### Análisis para cumplir los criterios de entrega:

Para cumplir con el modelo Entidad-Relación (ER) tenemos que tomar en cuenta lo siguiente:

- **Entidades**: cajas (categoria, productos, clientes, pedidos, detalle_pedido, reseñas, estado_pedido).
- **Atributos**: cada campo de las tablas.
- **Relaciones**: líneas entre entidades.
- **Cardinalidad**: indicación 1:N, N:N, etc.

Ahora para ver que cumpla con la tercera Forma normal (3NF) primero debemos analizar si cumple con la 1NF:

 - LLave primaria en cada una de las tablas
 - No debe haber grupos repetitivos de datos dentro de una misma fila, y todos sus atributos son atómicos. Por ejemplo, un detalle_pedido tiene una cantidad y un "precio_total" especificos para una línea de pedido, no una lista de productos.

Con esto se asegura que cumpla con la "1NF" ahora debemos asegurar que cumpla con las "2NF":

 - Debe estar en "1NF" y todos los atributos no clave deben depender completamente de la clave primaria.

Y por último requisito para que cumpla con la "3NF":

- Debe estar en "2NF" y no debe haber dependencias transitivas. (Una dependencia transitiva ocurre cuando un atributo no clave depende de otro atributo no clave, en lugar de depender directamente de la clave primaria.)

En el diagrama que muestro a continuación se ve claramente que en todas las tablas, cada atributo no clave dependen directamente de la clave primaria de esa tabla, y no de otro atributo no clave dentro de la misma tabla. Por ejemplo, en Productos, nombre, precio, stock dependen directamente de "id_producto", no hay ningún atributo que dependa de nombre en lugar de "id_producto". Así cumpliendo con todos los requisitos del entregable.


## Diagrama base de datos relacional de tienda online
![Diagrama](DiagramaFinalBD.png)

---

## 3. Implementacion de la Base de Datos

Se utilizó **MySQL** como SGBD.

### Entregables:
- Script SQL para crear tablas, claves y restricciones.
- Al menos 3 índices (productos por nombre, por categoría, pedidos por cliente).
- Script SQL para insertar datos de prueba.
  
### Configuración Inicial Generada Automáticamente:
```SQL
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
```
- Evita que un campo con AUTO_INCREMENT pueda tener valor 0 automáticamente.

```SQL
START TRANSACTION;
```
- Inicia una transacción (conjunto de operaciones que se ejecutan como una unidad).
```SQL
SET time_zone = "+00:00";
```
- Establece la zona horaria en UTC (coordinada universal) para operaciones con fechas.

Una vez terminadas las configuraciones iniciales empezamos con la creación de las tablas necesarias.

### Tablas:

## Creación de la tabla categorías que incluye lo siguiente:
  - id_categoria: identificador único de categoría.
  - nombre_categoria: aquí se coloca el nombre de la categoría
  - descripcion: aquí se agrega una breve descripción de la categoría. 
```SQL
CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL,
  `descripcion` text NOT NULL
)
```
## Creación de la tabla  clientes que incluye lo siguiente:
  - id_clientes: identificador único de clientes.
  - nombre_cliente: aquí es donde se coloca el nombre del cliente.
  - correo_electronico: aquí se coloca el correo electrónico del cliente.
  - direccion: aqui se coloca la dirección del cliente.
  - numero_telefono: aquí se coloca el número de teléfono del cliente.  
```SQL
CREATE TABLE `clientes` (
  `id_clientes` int(11) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL UNIQUE,
  `direccion` varchar(255) NOT NULL,
  `numero_telefono` varchar(20) NOT NULL
)
```
## Creación de la tabla “detalle_pedido” incluye lo siguiente:
  - id_detalle_pedido: identificador único de la tabla “detalle_pedido”.
  -  id_pedido: llave foránea enlazada a la tabla "pedidos".
  -  id_producto: llave foranea enlazada a la tabla "productos".
  -  cantidad: aquí se inserta la cantidad productos que hay en el pedido.
  -  precio_total: aquí se inserta el precio final del pedido.
    
NOTA: Esta tabla tiene un enlace a la tabla "pedidos" y "productos" 
```SQL
CREATE TABLE `detalle_pedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL
)
```
## Creación de la tabla estado_pedido que incluye lo siguiente:
  - id_estado_pedido: identificador único de la tabla pedido.
  - estado: aquí contendrá el estado del pedido(enviado, cancelado, en proceso).
```SQL
CREATE TABLE `estado_pedido` (
  `id_estado_pedido` int(11) NOT NULL,
  `estado` text NOT NULL
)
```
## Creación de la tabla pedidos que incluye lo siguiente:
  - id_pedido: identificador único de la tabla pedidos.
  - id_cliente: llave foránea enlazada a la tabla "clientes".
  - id_estado_pedido: llave foránea enlazada a la tabla "estado_pedido".
  - fecha_pedido: aquí se guardará la fecha del pedido.
```SQL
CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_estado_pedido` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL
)
```
## Creación de la tabla productos
  - id_producto: identificador único de la tabla productos.
  - id_categoria: llave foránea enlazada a la tabla "categorias".
  - nombre_producto: aquí se colocará el nombre del producto.
  - descripcion: aquí se colocara una breve descripción del producto.
  - precio: aquí se colocará el precio del producto.
  - stock: aquí se colocará el stock disponible del producto.
```SQL
CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `nombre_producto` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL
)
```
## Creación de la tabla resenas
  - id_resena: identificador único de la tabla resena.
  - id_producto: llave foránea enlazada a la tabla "productos".
  - id_cliente: llave foránea enlazada a la tabla "cliente".
  - calificacion: aqui se le colocara la reseña con calificacion del 1 al 5.
  - comentario: aquí se dejará un breve comentario para la reseña.
  - fecha_resena: aquí se colocara la fecha de cuando se realizó la reseña.
```SQL
CREATE TABLE `resenas` (
  `id_resena` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `calificacion` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha_resena` datetime NOT NULL
)
```
## Índices y Claves Primarias
Una vez creadas las tablas hay que designar los Índices y Claves Primarias de cada tabla: 

```SQL
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_clientes`);

ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

ALTER TABLE `estado_pedido`
  ADD PRIMARY KEY (`id_estado_pedido`);

ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_estado_pedido` (`id_estado_pedido`);

ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

ALTER TABLE `resenas`
  ADD PRIMARY KEY (`id_resena`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_cliente` (`id_cliente`);
```
## AUTO_INCREMENT
Una vez designados los Índices y Claves Primarias tenemos que darle el parametro de **AUTO_INCREMENT** a cada Clave Primaria:
```SQL
--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_clientes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_pedido`
--
ALTER TABLE `estado_pedido`
  MODIFY `id_estado_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resenas`
--
ALTER TABLE `resenas`
  MODIFY `id_resena` int(11) NOT NULL AUTO_INCREMENT;
```
## Restriccones (FOREING KEYS)
Por ultimo tenemos que designar las **FOREING KEYS** para cada una de las tablas, igualmente a cada uno se le agrega un **ON UPDATE CASCADE** para que si cambia el ID en la tabla referida, se actualiza automáticamente en esta tabla.

```SQL
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_clientes`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`id_estado_pedido`) REFERENCES `estado_pedido` (`id_estado_pedido`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE,
  ADD CONSTRAINT `resenas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_clientes`) ON UPDATE CASCADE;
```
Y realizamos **COMMIT;** para asegurar que se apliquen definitivamente todos los cambios a la base de datos.
```SQL
COMMIT;
```

