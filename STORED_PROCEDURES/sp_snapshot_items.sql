
-- ==========================================================================
-- Stored Procedure: sp_snapshot_items
-- Descripción: Reprocesa el snapshot diario de ítems usando la fecha actual (zona Bogotá)
-- Lógica: Elimina e inserta el snapshot para CURRENT_DATE("America/Bogota")
-- ==========================================================================
CREATE OR REPLACE PROCEDURE `mercadolibre-456701.challenge.sp_snapshot_items`()
BEGIN

  DECLARE fecha DATE DEFAULT CURRENT_DATE("America/Bogota");

  -- Eliminar snapshot existente para esa fecha
  DELETE FROM `mercadolibre-456701.challenge.item_snapshot`
  WHERE snapshot_date = fecha;

  -- Insertar nuevo snapshot desde el estado actual
  INSERT INTO `mercadolibre-456701.challenge.item_snapshot` (
    snapshot_date,
    item_id,
    price,
    status
  )
  SELECT
    fecha AS snapshot_date,
    item_id,
    price,
    status
  FROM `mercadolibre-456701.challenge.item`;

END;
