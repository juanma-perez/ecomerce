
-- ==============================================
-- Script: insert_item.sql
-- Tabla: item
-- ==============================================
INSERT INTO `mercadolibre-456701.challenge.item` (
  item_id, title, price, status, category_id, seller_id, created_at, updated_at
) VALUES
  (2001, 'iPhone X 128GB', 800000, 'activo', 101, 10, DATE '2019-12-15', DATE '2020-01-01'),
  (2002, 'Samsung A51', 750000, 'activo', 101, 10, DATE '2019-12-25', DATE '2020-01-05'),
  (2003, 'HP Laptop 14"', 2200000, 'activo', 102, 11, DATE '2020-01-10', DATE '2020-01-10'),
  (2004, 'Nevera Whirlpool 300L', 2500000, 'activo', 201, 12, DATE '2020-01-12', DATE '2020-01-12'),
  (2005, 'Cámara Canon EOS', 1800000, 'activo', 103, 13, DATE '2020-01-15', DATE '2020-01-15');
