-- ===========================================================
-- Consulta: Clientes que cumplen años hoy y compraron > $1.5M en enero 2020
-- ===========================================================
WITH ordenes_enero_2020 AS (
  SELECT
    customer_id,
    SUM(total_price) AS total_compras
  FROM `mercadolibre-456701.challenge.order`
  WHERE
    EXTRACT(YEAR FROM order_date) = 2020
    AND EXTRACT(MONTH FROM order_date) = 1
  GROUP BY customer_id
  HAVING SUM(total_price) > 1500000
),

cumpleanieros_hoy AS (
  SELECT *
  FROM `mercadolibre-456701.challenge.customer`
  WHERE
    EXTRACT(MONTH FROM birthdate) = EXTRACT(MONTH FROM CURRENT_DATE("America/Bogota"))
    AND EXTRACT(DAY FROM birthdate) = EXTRACT(DAY FROM CURRENT_DATE("America/Bogota"))
)

SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  o.total_compras
FROM cumpleanieros_hoy c
JOIN ordenes_enero_2020 o
  ON c.customer_id = o.customer_id;

-- ================================================================
-- Consulta: Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la
--categoría Celulares. Se requiere el mes y año de análisis, nombre y apellido del
--vendedor, cantidad de ventas realizadas, cantidad de productos vendidos y el monto
--total transaccionado.
-- ================================================================
WITH ordenes_2020 AS (
  SELECT
    order_id,
    item_id,
    quantity,
    total_price,
    order_date
  FROM `mercadolibre-456701.challenge.order`
  WHERE EXTRACT(YEAR FROM order_date) = 2020
),

items_celulares AS (
  SELECT
    i.item_id,
    i.seller_id
  FROM `mercadolibre-456701.challenge.item` i
  JOIN `mercadolibre-456701.challenge.category` c
    ON i.category_id = c.category_id
  WHERE lower(c.path) like '%celulares%'
),

ventas AS (
  SELECT
    EXTRACT(YEAR FROM o.order_date) AS anio,
    EXTRACT(MONTH FROM o.order_date) AS mes,
    i.seller_id,
    COUNT(DISTINCT o.order_id) AS cantidad_ordenes,
    SUM(o.quantity) AS productos_vendidos,
    SUM(o.total_price) AS total_vendido
  FROM ordenes_2020 o
  JOIN items_celulares i
    ON o.item_id = i.item_id
  GROUP BY anio, mes, i.seller_id
),

ventas_con_vendedor AS (
  SELECT
    v.anio,
    v.mes,
    v.seller_id,
    c.first_name,
    c.last_name,
    v.cantidad_ordenes,
    v.productos_vendidos,
    v.total_vendido,
    DENSE_RANK() OVER (PARTITION BY v.anio, v.mes ORDER BY v.total_vendido DESC) AS ranking
  FROM ventas v
  JOIN `mercadolibre-456701.challenge.customer` c
    ON v.seller_id = c.customer_id
)
SELECT
  anio,
  mes,
  seller_id,
  first_name,
  last_name,
  cantidad_ordenes,
  productos_vendidos,
  total_vendido
FROM ventas_con_vendedor
WHERE ranking <= 5
ORDER BY anio, mes, total_vendido DESC;
