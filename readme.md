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

En el diagrama que muestro a continucaicon se ve claramente que en todas las tablas, cada atributo no clave depende directamente de la clave primaria de esa tabla, y no de otro atributo no clave dentro de la misma tabla. Por ejemplo, en Productos, nombre, precio, stock dependen directamente de id_producto, no hay ningún atributo que dependa de nombre en lugar de id_producto. Asi cumpliendo con todos los Rquisitos del enstregable.
 # AQUI ES DONDE VA LA IMAGEN DE MI DIAGRAMA .PNG
