-- ==============================================
-- Script: insert_category.sql
-- Tabla: category
-- Descripción: Jerarquía de categorías del marketplace
-- ==============================================

-- Insertar categorías principales
INSERT INTO `mercadolibre-456620.challenge.category` (
  category_id, category_name, parent_id, path, created_at, updated_at
) VALUES
  (1, 'Tecnología', NULL, 'Tecnología', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (2, 'Electrodomésticos', NULL, 'Electrodomésticos', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (3, 'Hogar y Muebles', NULL, 'Hogar y Muebles', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (4, 'Deportes y Fitness', NULL, 'Deportes y Fitness', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (5, 'Moda', NULL, 'Moda', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- Insertar subcategorías de 'Tecnología'
INSERT INTO `mercadolibre-456620.challenge.category` (
  category_id, category_name, parent_id, path, created_at, updated_at
) VALUES
  (101, 'Celulares y Teléfonos', 1, 'Tecnología > Celulares y Teléfonos', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (102, 'Computación', 1, 'Tecnología > Computación', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (103, 'Cámaras y Accesorios', 1, 'Tecnología > Cámaras y Accesorios', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- Insertar subcategorías de 'Electrodomésticos'
INSERT INTO `mercadolibre-456620.challenge.category` (
  category_id, category_name, parent_id, path, created_at, updated_at
) VALUES
  (201, 'Refrigeración', 2, 'Electrodomésticos > Refrigeración', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (202, 'Lavado', 2, 'Electrodomésticos > Lavado', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- Insertar subcategorías de 'Hogar y Muebles'
INSERT INTO `mercadolibre-456620.challenge.category` (
  category_id, category_name, parent_id, path, created_at, updated_at
) VALUES
  (301, 'Sala', 3, 'Hogar y Muebles > Sala', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (302, 'Comedor', 3, 'Hogar y Muebles > Comedor', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- Insertar subcategorías de 'Deportes y Fitness'
INSERT INTO `mercadolibre-456620.challenge.category` (
  category_id, category_name, parent_id, path, created_at, updated_at
) VALUES
  (401, 'Ciclismo', 4, 'Deportes y Fitness > Ciclismo', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (402, 'Fitness y Musculación', 4, 'Deportes y Fitness > Fitness y Musculación', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- Insertar subcategorías de 'Moda'
INSERT INTO `mercadolibre-456620.challenge.category` (
  category_id, category_name, parent_id, path, created_at, updated_at
) VALUES
  (501, 'Ropa para Hombre', 5, 'Moda > Ropa para Hombre', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
  (502, 'Ropa para Mujer', 5, 'Moda > Ropa para Mujer', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());
