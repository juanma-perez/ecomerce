-- ============================================
-- Consulta programada: snapshot diario de ítems
-- Ejecuta el procedimiento almacenado sp_snapshot_items()
-- ============================================

CREATE SCHEDULE `mercadolibre-456701.challenge.snapshot_diario_items`
OPTIONS (
  schedule_expression = 'CRON_TZ=America/Bogota 59 23 * * *',
  display_name = 'Snapshot diario de ítems',
  description = 'Ejecuta sp_snapshot_items() cada noche al cierre para capturar precio y estado de productos',
  enabled = TRUE
)
AS
CALL `mercadolibre-456701.challenge.sp_snapshot_items`();
