# Proyecto Final de la Clase de Bases de datos en la UAM Cuajimalpa.
 - Creado por Salinas Mata Luis Antonio, alumno de LTSI. 

## 1. Descripción del Problema 
- Se nos pidio la creacion de una tienda online suponiendo que los productos electrónicos necesita un sistema para gestionar sus operaciones, incluyendo productos, clientes, pedidos, reseñas de productos y categorías. 
 
 * Se solicito que se deberán diseñar e implementar una base de datos relacional con al menos 5 tablas que cumpla con los siguientes requisitos funcionales:
   
   - Gestion de Productos.
   - Gestion de Clientes.
   - Pedidos.
   - Resenas.
   - Categorias
 
En mi caso tome la decicion de agregar dos tablas mas las cuales son:

 - detalle_pedido
 - estado_pedido

Agregue estas dos tablas ya que considero que de esta manera en el Esquema se cumple con la Tercera Forma Normal(3NF).

## 2. Requisitos del Proyecto:

- Diseñar una base de datos relacional con al menos 5 tablas (Productos, Clientes, Pedidos, Detal1es_Pedido, Reseñas, Categorías).

### Entregable: 
- Diagrama Entidad-Relación (ER) que modele entidades y relaciones.
- Esquema en tercera forma normal (3NF), con justificación de normalización.
- Identificación de claves primarias, foráneas y candidatas.

### Analisis realizado para cumplir con los criterios de entrega:
Para cumplir con el modelo Entidad-Relacion (ER) que modele entidades y relaciones tenemos que tomar en cuenta lo siguiente:

 - Entidades: Cada una de las cajas (categoria, productos, clientes, pedidos, detalle_pedido, resenas, estado_pedido) representan una entidad significativa en la tienda.
 - Atributos: Las lineas dentro de cada caja son los atributos de esa entidad.
 - Relaciones: Las lineas que conectan las cajas representan las relaciones entre las entidades.
 - Cardinalidad: Los simbolos en los extremos de las lineas (1, N) indican la cardinalidad de esas relaciones.

Ahora para ver que cumpla con la tercera Forma normal (3NF) primero debemos analizar si cumple con la 1NF:

 - LLave primaria en cada una de las tablas
 - No debe haber grupos repetitivos de datos dentro de una misma fila, y todos sis atributos son atomicos. Por ejemplo, un detalle_pedido tiene una cantidad y un precio_total especificos para una linea de pedido, no una lista de productos.

Con esto se asegura que cumpla con la "1NF" ahora debemos asegurar que cumpla con las "2NF":

 - Debe estar en "1NF" y todos los atributos no clave deben depender completamente de la clave primaria.

Y por ultimo requisito para que cumpla con la "3NF":

- Debe estar en "2NF" y no debe haber dependencias transitivas. (Una dependencia transitiva ocurre cuando un atributo no clave depende de otro atributo no clave, en lugar de depender directamente de la clave primaria.)

En el diagrama que muestro a continucaicon se ve claramente que en todas las tablas, cada atributo no clave depende directamente de la clave primaria de esa tabla, y no de otro atributo no clave dentro de la misma tabla. Por ejemplo, en Productos, nombre, precio, stock dependen directamente de id_producto, no hay ningún atributo que dependa de nombre en lugar de id_producto. Asi cumpliendo con todos los requisitos del enstregable.

## Diagrama base de datos relacional de tienda online
![Diagrama](DiagramaFinalBD.png)

## 3. Implementacion de la Base de Datos

Se nos solicito una vez implementado el diagrama, crear la base de datos en un SGBD (MySQL).

## Entregable
 - Script SQL para creae tablas, incluyendo:
   - Claves primarias y foraneas.
   - Restricciones(stock no negativo, unicidad de correos).
   - Almenos 3 indices para optimizar consultas.
- Script SQL para poblar la base con datos de prueba.
  
## Analisis realizado para cumplir con los criterios de entrega:
Antes de crear las tablas el SGBD me genero en automatico las siguientes configuraciones iniciales: 
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

Una vez terminada las configuraciones iniciales empezamos con la creacion de las tablas necesarias.

## Creacion de la tabla categorias que incluye lo siguiente:
  - id_categoria: identificador unico de categoria.
  - nombre_categoria: aqui se coloca el nombre de la categoria
  - descripcion: aqui se agrega una breve descripcion de la categoria. 
```SQL
CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL,
  `descripcion` text NOT NULL
)
```
## Creacion de la tabla  clientes que incluye lo siguiente:
  - id_clientes: identificador unico de clinetes
  - nombre_cliente: aqui es donde se coloca el nombre del cliente
  - correo_electronico: aqui se coloca el correo electronioco del clinete
  - direccion: aqui se colsoca la direccion del cliente
  - numero_telefono: aqui se coloca el numero de teledono del cliente
    
```SQL
CREATE TABLE `clientes` (
  `id_clientes` int(11) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `numero_telefono` varchar(20) NOT NULL
)
```
## Creacion de la tabla detalle_pedido incluye lo siguinete:
  - id_detalle_pedido: identificador unico de la tabla detalle_pedido
  -  id_pedido: llave foranea enlasada a la tabla "pedidos"
  -  id_producto: llave foranea enlasada a la tabla "productos"
  -  cantidad: aqui se inserta la cantidad productos que hay en el pedido
  -  precio_total: aqui se inserta el precio final del pedido
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
## Creacion de la tabla estado_pedido que incluye lo siguinete:
  - 



```SQL
CREATE TABLE `estado_pedido` (
  `id_estado_pedido` int(11) NOT NULL,
  `estado` text NOT NULL
)
```
## Creacion de la tabla pedidos que incluye lo siguinete:
  - 
```SQL
CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_estado_pedido` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL
)
```
## Creacion de la tabla productos


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
## Creacion de la tabla resenas


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
```
```
```
```
```
```
