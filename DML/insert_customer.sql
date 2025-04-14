
-- ==============================================
-- Script: insert_customer.sql
-- Tabla: customer
-- ==============================================
INSERT INTO `mercadolibre-456701.challenge.customer` (
  customer_id, email, first_name, last_name, gender, birthdate, address, phone
) VALUES
  (10, 'vendedor.exitoso@mail.com', 'Pedro', 'Vargas', 'M', DATE '2025-04-13', 'Calle 100, Bogotá', '3001231234'),
  (11, 'ana.morales@mail.com', 'Ana', 'Morales', 'F', DATE '1992-06-18', 'Cl 23, Bogotá', '3112223344'),
  (12, 'jose.arias@mail.com', 'José', 'Arias', 'M', DATE '1990-08-10', 'Av. 80, Medellín', '3130001112'),
  (13, 'maria.vera@mail.com', 'María', 'Vera', 'F', DATE '1988-11-03', 'Cl 9, Cali', '3204445566');
