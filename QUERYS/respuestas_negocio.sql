-- ===========================================================
-- Consulta: Clientes que cumplen años hoy y compraron > $1.5M en enero 2020
-- Proyecto: mercadolibre-456701
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
  SELECT   customer_id,
  first_name,
  last_name,
  email,
  FROM `mercadolibre-456701.challenge.customer`
  WHERE
    EXTRACT(MONTH FROM birthdate) = EXTRACT(MONTH FROM CURRENT_DATE())
    AND EXTRACT(DAY FROM birthdate) = EXTRACT(DAY FROM CURRENT_DATE())
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

