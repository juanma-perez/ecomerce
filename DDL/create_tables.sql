-- ##################################################
-- Script: create_tables.sql (Mejorado)
-- Descripción:
-- Proyecto: mercadolibre-456701
-- Dataset: challenge
-- Versión: 1.1
-- Autor: Manuel Pérez
-- Fecha de Modificación: 2025-04-13
-- ##################################################

-- ===============================
-- Tabla: customer
-- Usuarios registrados en el sitio
-- ===============================
DROP TABLE IF EXISTS `mercadolibre-456701.challenge.customer`;
CREATE TABLE `mercadolibre-456701.challenge.customer` (
    customer_id INT64 OPTIONS(description="Identificador único del usuario"),
    PRIMARY KEY (customer_id) NOT ENFORCED,
    email STRING OPTIONS(description="Email del usuario"),
    first_name STRING OPTIONS(description="Nombres del usuario"),
    last_name STRING OPTIONS(description="Apellido del usuario"),
    gender STRING OPTIONS(description="Género (M, F, Otro)"),
    birthdate DATE OPTIONS(description="Fecha de nacimiento"),
    address STRING OPTIONS(description="Dirección del usuario"),
    phone STRING OPTIONS(description="Teléfono del usuario")
)
OPTIONS (
    description = "Tabla que almacena los datos de los usuarios registrados (compradores y vendedores)."
);

-- ===============================
-- Tabla: category
-- Estructura jerárquica de categorías
-- ===============================
DROP TABLE IF EXISTS `mercadolibre-456701.challenge.category`;
CREATE TABLE `mercadolibre-456701.challenge.category` (
    category_id INT64 OPTIONS(description="Identificador único de la categoría"),
    PRIMARY KEY (category_id) NOT ENFORCED,
    category_name STRING OPTIONS(description="Nombre corto de la categoría (ej: 'Smartphones')"),
    parent_id INT64 OPTIONS(description="ID de la categoría padre (NULL si es raíz)"),
    path STRING OPTIONS(description="Ruta completa desde la raíz (ej: 'Tecnología > Celulares > Smartphones')"),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() OPTIONS(description="Fecha de creación de la categoría"),
    updated_at TIMESTAMP OPTIONS(description="Fecha de última modificación de la categoría")
)
OPTIONS (
    description = "Tabla jerárquica de categorías con estructura padre-hijo y path precalculado."
);

-- ===============================
-- Tabla: item
-- Publicaciones de productos
-- ===============================
DROP TABLE IF EXISTS `mercadolibre-456701.challenge.item`;
CREATE TABLE `mercadolibre-456701.challenge.item` (
    item_id INT64 OPTIONS(description="Identificador único del producto"),
    PRIMARY KEY (item_id) NOT ENFORCED,
    title STRING OPTIONS(description="Título descriptivo del producto"),
    price NUMERIC OPTIONS(description="Precio actual del producto"),
    status STRING OPTIONS(description="Estado del producto (activo, pausado, eliminado)"),
    category_id INT64 OPTIONS(description="ID de la categoría a la que pertenece el producto"),
    seller_id INT64 OPTIONS(description="ID del vendedor que publicó el producto"),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() OPTIONS(description="Fecha en la que se publicó el producto"),
    updated_at TIMESTAMP OPTIONS(description="Fecha de última modificación del producto")
)
OPTIONS (
    description = "Tabla que contiene todos los productos publicados en la plataforma, asociados a su vendedor."
);

ALTER TABLE `mercadolibre-456701.challenge.item`
ADD CONSTRAINT fk_item_category FOREIGN KEY (category_id)
REFERENCES `mercadolibre-456701.challenge.category`(category_id) NOT ENFORCED;

ALTER TABLE `mercadolibre-456701.challenge.item`
ADD CONSTRAINT fk_item_customer_seller FOREIGN KEY (seller_id)
REFERENCES `mercadolibre-456701.challenge.customer`(customer_id) NOT ENFORCED;

-- ===============================
-- Tabla: order
-- Registro de compras realizadas
-- ===============================
DROP TABLE IF EXISTS `mercadolibre-456701.challenge.order`;
CREATE TABLE `mercadolibre-456701.challenge.order` (
    order_id INT64 OPTIONS(description="Identificador único de la orden de compra"),
    PRIMARY KEY (order_id) NOT ENFORCED,
    customer_id INT64 OPTIONS(description="ID del cliente que realizó la compra"),
    item_id INT64 OPTIONS(description="ID del producto comprado"),
    quantity INT64 OPTIONS(description="Cantidad de unidades compradas"),
    order_date DATE OPTIONS(description="Fecha en la que se realizó la orden"),
    total_price NUMERIC OPTIONS(description="Monto total transaccionado (precio * cantidad)")
)
OPTIONS (
    description = "Registro detallado de las órdenes de compra generadas en el sitio."
);

ALTER TABLE `mercadolibre-456701.challenge.order`
ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id)
REFERENCES `mercadolibre-456701.challenge.customer`(customer_id) NOT ENFORCED;

ALTER TABLE `mercadolibre-456701.challenge.order`
ADD CONSTRAINT fk_order_item FOREIGN KEY (item_id)
REFERENCES `mercadolibre-456701.challenge.item`(item_id) NOT ENFORCED;

-- ===============================
-- Tabla: order
-- Estado final de los items al final del día 
-- ===============================
DROP TABLE `mercadolibre-456701.challenge.item_snapshot` ;
CREATE TABLE  `mercadolibre-456701.challenge.item_snapshot` (
  snapshot_date DATE OPTIONS(description="Fecha del snapshot (corte del día)"),
  item_id INT64 OPTIONS(description="Identificador único del producto"),
  price NUMERIC OPTIONS(description="Precio del producto al momento del snapshot"),
  status STRING OPTIONS(description="Estado del producto al momento del snapshot (activo, pausado, eliminado, etc.)")
)
PARTITION BY snapshot_date
OPTIONS (
  description = "Tabla que almacena un snapshot diario del precio y estado actual de los productos. Reprocesable sin duplicados."
);
