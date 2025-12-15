# Funcionamiento del módulo de Arbitrios Municipales

Documento integral que explica cómo funciona la aplicación (flujo de pantallas, lógica de negocio), qué hace cada componente y cómo se aprovecha la base de datos PostgreSQL.

---
## 1. Visión general
- **Stack**: PHP MVC + Nginx + PostgreSQL (en Docker). Esquemas: `arb` (arbitrios), `gen` (maestros), `caj` (caja/pagos).
- **Objetivo**: Registrar predios, categorizar arbitrios (varios usos por predio/año), calcular montos (base, interés, mora), emitir cuenta corriente y recibos, y reportar recaudación.

---
## 2. Flujo de usuario en la página
1) **Búsqueda de contribuyente**: se listan sus predios con estado y origen (`arb.arbitrio` + `gen.gen_predio` + `arb.tipo_registro_origen`).
2) **Predios**: alta/actualización/eliminación de registros en `arb.arbitrio` (vínculo contribuyente–predio, estado, origen, año). Evita duplicados.
3) **Categorizaciones** (núcleo):
   - Listar ítems (año/item) de `arb.arbitrio_detalle` con meses afectos, categorías y exoneraciones por tributo, montos y auditoría.
   - Crear/editar ítems capturando parámetros físicos y de negocio:
     - Barrido: frentera_metros, frecuencia_barrido, meses.
     - Residuos: area_construida, categoría relleno.
     - Parques: distancia_a_parque, categoría parques.
     - Serenazgo: porcentaje_inseguridad, categoría serenazgo.
     - Exoneraciones por tributo y meses afectos.
   - Eliminar ítems sin borrar cabecera.
4) **Pre-cálculo**: antes de guardar, la UI muestra el cálculo estimado (composición por tributo y total).
5) **Cuenta Corriente**: recalcula interés/mora en BD (función `arb.fn_actualizar_mora_interes`) y devuelve saldos por detalle y totales por contribuyente/predio.
6) **Caja / Recibos**: genera pagos (`caj.pago`, `caj.pago_detalle`) y recibos (`caj.recibo`) con numeración en `caj.cajero`; actualiza `monto_pagado` y `estado_pago` en `arb.arbitrio_detalle` en tiempo real.
7) **Notificaciones**: calcula saldo pendiente y usa el email del contribuyente (`gen.gen_contribuyente`) para avisos.
8) **Reportes**: recaudación mensual/anual (base, interés, mora, emitido, pagado) con filtros de año/mes/ubigeo.

---
## 3. Qué hace cada pieza (controlador principal)
- `index`: carga datos de contribuyente, predios, referencias, catálogos de tributos y beneficios.
- `agregar/actualizar/eliminarPredio`: CRUD de cabecera `arb.arbitrio`.
- `getCategorizacionesPredio` / `getCategorizaciones`: lecturas de detalle con joins a `arb.tipo_beneficio` (categorías/exoneraciones).
- `crear/actualizar/eliminarCategorizacion`: CRUD de `arb.arbitrio_detalle`; controla meses afectos y categorías por tributo.
- `preCalcular`: cálculo estimado antes de persistir (barrido, parques, residuos, serenazgo).
- `procesarCuentaCorriente`: recalcula mora/interés (función SQL) y arma totales de saldo.
- `procesarPago`: marca pagos y estado en `arb.arbitrio_detalle`.
- `generarRecibosCaja` + helpers (`generarReciboSimple/Individual/RegistroCaja`): crean pago, detalle y recibo en `caj.*`, actualizan numeración y reflejan pago en arbitrios.
- `recaudacion`: sumarios mensuales/anuales.
- `notificar`: saldo pendiente y envío simulado de correo.
- `getDeclaraciones/getLicencias/importarPredios`: importan predios de DDJJ o licencias marcando origen (`id_tipo_registro_origen`).

---
## 4. Uso intensivo de la base de datos
- **Esquemas especializados**: `arb` (arbitrios), `gen` (maestros), `caj` (caja) separan responsabilidades.
- **Modelo relacional claro**:
  - Cabecera: `arb.arbitrio` (contribuyente–predio–origen–año–estado).
  - Detalle: `arb.arbitrio_detalle` (año/item, meses afectos, parámetros físicos, categorías/exoneraciones, montos, auditoría).
  - Maestros: `arb.tipo_beneficio`, `arb.tipo_registro_origen`; Caja: `caj.pago`, `caj.pago_detalle`, `caj.recibo`, `caj.cajero`.
- **Cálculo en BD**: función `arb.fn_actualizar_mora_interes(id_detalle)` centraliza lógica financiera (consistencia, menos tráfico, mejor rendimiento). Hay fallback manual en PHP.
- **Agregaciones en SQL**: reportes usan `SUM` y `GROUP BY` en Postgres, evitando recálculo en PHP.
- **Índices por PK/FK**: búsquedas por contribuyente, predio, año, item son eficientes; integridad referencial evita datos huérfanos.
- **Consultas parametrizadas**: `query/prepare` en el modelo previene inyección y permite reuse.
- **Auditoría y trazabilidad**: campos de usuario/fecha en detalles; numeración de recibos en `caj.cajero`.

---
## 5. Requerimientos funcionales (mapa a BD y verificación)
1. Registro por predio independiente de DDJJ: `arb.arbitrio`; ver en pestaña Predios. Evita duplicados por contribuyente–predio.
2. Categorización de licencias: `id_tipo_registro_origen=3` en `arb.arbitrio`; ver columna “Referencia origen”.
3. Múltiples categorías por predio: varios items en `arb.arbitrio_detalle` (año/item) para un mismo arbitrio.
4. Barrido: `frentera_metros`, `frecuencia_barrido`, meses; cálculo en `preCalcular`/persistencia en detalle.
5. Residuos: `area_construida`, `id_tipo_beneficio_relleno_sanitario`; cálculo en `preCalcular` y detalle.
6. Parques: `distancia_a_parque`, `id_tipo_beneficio_parques_jardines`; cálculo en `preCalcular` y detalle.
7. Automático de monto/interés/mora: `arb.fn_actualizar_mora_interes` + fallback manual; campos en `arb.arbitrio_detalle`.
8. Serenazgo: `porcentaje_inseguridad`, `id_tipo_beneficio_serenazgo`; cálculo en `preCalcular` y detalle.
9. Integración con Caja: `caj.pago`, `caj.recibo`, `caj.cajero`, y actualización de `monto_pagado/estado_pago` en `arb.arbitrio_detalle`.
10. Estados de cuenta y correo: `cuentaCorriente()` arma dataset de `arb.arbitrio_detalle`; `notificar()` usa email de `gen.gen_contribuyente`.
11. Reporte de recaudación: `recaudacion()` agrega sobre `arb.arbitrio_detalle` + join a `arb.arbitrio`/`gen.gen_predio`.

---
## 6. Cómo se ve en la página (validación rápida)
- **Predios**: alta/baja/edición refleja cambios en `arb.arbitrio`.
- **Categorizaciones**: ítems muestran meses, categorías y montos desde `arb.arbitrio_detalle`.
- **Cuenta Corriente**: muestra saldos tras recalcular mora/interés en BD.
- **Caja**: emitir recibo crea filas en `caj.pago`, `caj.recibo` y descuenta saldo en detalle.
- **Reportes**: totales por mes/año salen de agregados SQL.

---
## 7. Evidencias sugeridas (para demo)
1) Crear o importar un predio → ver fila en `arb.arbitrio` (pestaña Predios). 
2) Crear categorización con meses/categorías → nueva fila en `arb.arbitrio_detalle` con montos. 
3) Procesar cuenta corriente → JSON/UI con mora/interés actualizados (llamada a función SQL). 
4) Emitir recibo → filas nuevas en `caj.pago` y `caj.recibo`, saldo reducido en `arb.arbitrio_detalle`. 
5) Consultar recaudación → validar sumas por mes/año (SQL `SUM`/`GROUP BY`).

---
## 8. Buenas prácticas al explicar al docente
- Recorrer el flujo completo: predio → categorización → cálculo → pago → reporte.
- En cada paso, señalar tablas impactadas (usar `psql`, `\dt`, y consultas puntuales de verificación).
- Destacar la función `arb.fn_actualizar_mora_interes` como cálculo en BD (consistencia y rendimiento).
- Mostrar integración en tiempo real con Caja y coherencia de saldos.

---
Última actualización: 15 de diciembre de 2025
