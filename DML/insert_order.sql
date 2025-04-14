
-- ==============================================
-- Script: insert_order.sql
-- Tabla: order
-- ==============================================
INSERT INTO `mercadolibre-456701.challenge.order` (
  order_id, customer_id, item_id, quantity, order_date, total_price
) VALUES
  (3001, 11, 2001, 1, DATE '2020-01-10', 800000),
  (3002, 10, 2002, 1, DATE '2020-01-15', 750000),
  (3003, 11, 2003, 1, DATE '2020-01-20', 159000000),
  (3004, 11, 2004, 1, DATE '2020-02-01', 2500000),
  (3005, 12, 2005, 2, DATE '2020-03-05', 3600000);
