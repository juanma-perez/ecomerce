
# 📦 Mercado Libre - challenge

Este repositorio contiene scripts de creación, carga y análisis de datos sobre un modelo de marketplace (Mercado Libre), implementado en BigQuery.

---

## 📁 Contenido del proyecto

### 1. 🏗️ Definición de Tablas (DDL)
- **`create_tables.sql`**: Contiene la definición estructurada de las tablas `customer`, `category`, `item`, `order`, y `item_snapshot` .

### 2. 🧪 Inserción de Datos (DML)
- **`insert_customer.sql`**: Carga de usuarios compradores y vendedores.
- **`insert_category.sql`**: Jerarquía de categorías basada en la estructura real de Mercado Libre.
- **`insert_item.sql`**: Productos publicados por vendedores.
- **`insert_order.sql`**: Registro de órdenes de compra realizadas por los usuarios.

### 3. 📸 Snapshot Diario de Ítems
- **`sp_snapshot_items.sql`**: Procedimiento almacenado que registra diariamente el precio y estado actual de todos los ítems (con fecha `CURRENT_DATE("America/Bogota")`). 
- **`snapshot_diario_items.sql`**: Script que crea una tarea programada (`Scheduled Query`) para ejecutar `sp_snapshot_items()` todos los días a las 23:59 (hora Bogotá).

### 4. 📊 Consultas de Negocio
- **`respuestas_negocio.sql`**: Contiene consultas SQL que responden a preguntas clave del negocio como:
  - Clientes que cumplen años hoy y han comprado más de $1.5M en enero 2020.
  - Top 5 vendedores mensuales en la categoría “Celulares” en 2020.

### 5. 🚀 Despliegue automatizado con GitHub Actions
- **`deploy_to_bigquery.yml`**: Workflow de GitHub Actions que:
  - Se activa al hacer push sobre la rama `dev`.
  - Ejecuta el script `DDL/create_tables.sql`.
  - Luego ejecuta todos los archivos `.sql` de la carpeta `DML/`.
  - Usa autenticación con una cuenta de servicio (`GCP_SERVICE_ACCOUNT_KEY`) para conectarse a BigQuery.

---

## ✅ Recomendaciones para ejecución

- Ejecutar primero `create_tables.sql`.
- Luego cargar los datos con los scripts `insert_*.sql`.
- Ejecutar `sp_snapshot_items()` manualmente o mediante `snapshot_diario_items.sql`.
- Validar resultados con las consultas de `respuestas_negocio.sql`.

---

## 🌎 Zona Horaria

> Todas las operaciones de snapshot diario están basadas en la zona horaria: **America/Bogota**.

---

## 📂 Estructura sugerida del repositorio

```
/DDL/
  create_tables.sql
/DML/
  insert_customer.sql
  insert_category.sql
  insert_item.sql
  insert_order.sql
/SCTORED_PROCEDURES/
  sp_snapshot_items.sql
/JOBS/
  snapshot_diario_items.sql
/QUERIES/
  respuestas_negocio.sql
/.github/workflows/
  deploy_to_bigquery.yml
```
