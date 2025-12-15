# Requerimientos funcionales y uso de la base de datos

Este documento describe, en detalle, cada requerimiento funcional del módulo de Arbitrios Municipales, cómo se implementa en la aplicación y cómo se aprovecha la base de datos PostgreSQL. Incluye tablas involucradas, flujos de código y formas de verificación en la interfaz.

---

## 1. Registro de datos por predio (independiente de DDJJ)
- Tablas: `arb.arbitrio` (vínculo contribuyente-predio), `arb.arbitrio_detalle` (detalle por año/item).
- Flujo: Alta de predio desde la UI → `ArbitriosController::agregarPredio()` → inserta en `arb.arbitrio` sin depender de `arb.declaracion_jurada`.
- Verificación en página: Menú Arbitrios → Buscar contribuyente → pestaña Predios: se listan predios registrados.
- Uso de BD: llave compuesta contribuyente-predio evita duplicados; PK/FK aseguran integridad.

## 2. Categorización de licencias de funcionamiento
- Tablas: `arb.arbitrio` (campo `id_tipo_registro_origen`), `arb.tipo_registro_origen`.
- Flujo: Importar desde licencias en `importarPredios()`; si la fuente es “licencias”, se marca `id_tipo_registro_origen = 3`.
- Verificación: Al importar predios, en la grilla aparece la columna “Referencia origen”.
- Uso de BD: tabla maestra de orígenes para trazabilidad y filtros.

## 3. Múltiples categorías por predio (usos variados)
- Tablas: `arb.arbitrio` (cabecera), `arb.arbitrio_detalle` (varios ítems por año/predio).
- Flujo: `crearCategorizacion()` crea nuevos `item` para el mismo `id_arbitrio`, permitiendo distintas combinaciones de beneficios/exoneraciones y meses afectos.
- Verificación: Historial de categorizaciones muestra lista por año/item para un predio.
- Uso de BD: histórico no destructivo; cada ítem conserva auditoría de fechas y usuario.

## 4. Cálculo por Barrido (frentera y frecuencia)
- Tablas: `arb.arbitrio_detalle` (campos `frentera_metros`, `frecuencia_barrido`, meses afectos).
- Flujo: `preCalcular()` y `crearCategorizacion()` computan el componente de Barrido usando frentera × frecuencia × meses.
- Verificación: En la UI, el precálculo muestra el monto de Barrido y el total antes de guardar.
- Uso de BD: se almacenan frentera y frecuencia para recalcular y auditar.

## 5. Cálculo por Residuos Sólidos (relleno) según área construida y categoría
- Tablas: `arb.arbitrio_detalle` (`area_construida`, `id_tipo_beneficio_relleno_sanitario`).
- Flujo: `crearCategorizacion()` guarda área y categoría; `preCalcular()` distribuye el componente de relleno.
- Verificación: Detalle de categorización muestra área y categoría aplicadas; totales reflejados en cuenta corriente.
- Uso de BD: categorías parametrizadas en `arb.tipo_beneficio` para tarifas diferenciadas.

## 6. Cálculo Parques y Jardines por distancia a parques
- Tablas: `arb.arbitrio_detalle` (`distancia_a_parque`, `id_tipo_beneficio_parques_jardines`).
- Flujo: El usuario registra la distancia (≤50m, ≤100m, >100m) y la categoría; `preCalcular()` aplica el factor en el monto base.
- Verificación: En la UI de categorizaciones, se muestran distancia y monto asignado; visible también en cuenta corriente.
- Uso de BD: almacena distancia y categoría para recalcular y auditar.

## 7. Cálculo automático de Arbitrio, Intereses y Moras
- Tablas: `arb.arbitrio_detalle` (`monto_base`, `interes`, `mora`, `monto_final`, `fecha_actualizado`).
- Flujo: `procesarCuentaCorriente()` invoca la función SQL `arb.fn_actualizar_mora_interes(id_detalle)`; si falla, usa `calcularMoraInteresManual()` como respaldo.
- Verificación: Al procesar cuenta corriente, los totales se actualizan; revisar respuesta JSON o tabla en UI.
- Uso de BD: lógica financiera centralizada en función SQL para consistencia y rendimiento.

## 8. Cálculo de Serenazgo por índice de inseguridad
- Tablas: `arb.arbitrio_detalle` (`porcentaje_inseguridad`, `id_tipo_beneficio_serenazgo`).
- Flujo: `preCalcular()` aplica factor según inseguridad y meses; `crearCategorizacion()` persiste los valores.
- Verificación: Detalle de categorización muestra porcentaje y monto; visible en cuenta corriente.
- Uso de BD: categorías en `arb.tipo_beneficio` permiten ajustar tarifas por zona.

## 9. Integración con módulo de Caja (pagos en tiempo real)
- Tablas: `caj.pago`, `caj.pago_detalle`, `caj.recibo`, `caj.cajero`, y `arb.arbitrio_detalle` (monto_pagado, estado_pago).
- Flujo: `procesarPago()` actualiza pagos y estado; `generarRecibosCaja()`/`generarReciboSimple()`/`generarReciboIndividual()` crean pagos y recibos, actualizan numeración en `caj.cajero`.
- Verificación: Emitir recibo desde UI y consultar registros en `caj.*`; saldo reflejado en `arb.arbitrio_detalle`.
- Uso de BD: transacciones atómicas y numeración de recibos en BD para coherencia.

## 10. Estados de Cuenta y notificación por correo
- Tablas: `arb.arbitrio_detalle` (saldos), `gen.gen_contribuyente` (email).
- Flujo: `cuentaCorriente()` arma dataset para estado de cuenta; `notificar()` calcula saldo y envía (simulado) correo, registrando en logs.
- Verificación: Ejecutar estado de cuenta y revisar JSON; correr notificación y revisar logs.
- Uso de BD: saldos se obtienen directo de `arb.arbitrio_detalle`, sin recalcular en cliente.

## 11. Reporte de recaudación mensual/anual
- Tablas: `arb.arbitrio_detalle` unido a `arb.arbitrio` y `gen.gen_predio`.
- Flujo: `recaudacion()` agrega base, interés, mora, emitido y pagado por mes/año; permite filtrar por `ubigeo`.
- Verificación: Consultar reporte en UI o endpoint y validar totales.
- Uso de BD: uso de agregaciones SQL (`SUM`, `GROUP BY`) para eficiencia.

---

## Cómo se verifica en la página
- Búsqueda de contribuyente: muestra predios y origen registrados en `arb.arbitrio`.
- Pestaña Predios: alta/baja de predios; sincroniza con `arb.arbitrio` y `arb.arbitrio_detalle`.
- Pestaña Categorizaciones: lista/crea/edita/elimina ítems (`arb.arbitrio_detalle`), con categorías, exoneraciones y meses afectos.
- Cuenta Corriente: recalcula mora/interés antes de mostrar saldo.
- Caja: emite recibos en `caj.*` y actualiza pagos en `arb.arbitrio_detalle`.
- Reportes: consolidan recaudación mensual/anual desde SQL agregado.

---

## Uso eficiente de la base de datos
- Esquemas separados: `arb` (arbitrios), `gen` (maestros), `caj` (caja) para responsabilidades claras.
- Relaciones explícitas: FK entre `arb.arbitrio_detalle` y `arb.arbitrio`; evita duplicidad y mantiene integridad.
- Función SQL de cálculo: `arb.fn_actualizar_mora_interes` centraliza lógica de mora/interés.
- Agregaciones en BD: reportes calculan en SQL, reduciendo carga en PHP.
- Índices por PK/FK: búsquedas por contribuyente, predio y año son eficientes.
- Consultas parametrizadas: `query/prepare` evita inyección y asegura atomicidad.

---

## Evidencias rápidas de funcionamiento
1. Crear categorización: alta en UI → revisar nueva fila en `arb.arbitrio_detalle` y totales.
2. Procesar cuenta corriente: ejecutar → ver JSON con mora/interés recalculados.
3. Emitir recibo: generar desde Caja → nuevas filas en `caj.pago`, `caj.recibo` y saldo reducido en `arb.arbitrio_detalle`.
4. Reporte de recaudación: consultar → validar sumas por mes/año coinciden con SQL.

---

## Buenas prácticas para la presentación al docente
- Muestra el flujo completo: registro de predio → categorización → cálculo → pago → reporte.
- En cada paso, señala las tablas impactadas (usa `\dt` en `psql` y consultas puntuales).
- Destaca el uso de `arb.fn_actualizar_mora_interes` como cálculo en BD.
- Demuestra la integración en tiempo real con Caja y la consistencia de saldos.

---

Última actualización: 15 de diciembre de 2025
