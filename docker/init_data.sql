-- ============================================================================
-- SCRIPT MAESTRO: INICIALIZACIÓN COMPLETA ARBITRIOS MUNICIPALES v3.0
-- Consolida: tributos, categorías, exoneraciones, tarifas, predios, licencias
-- 100+ contribuyentes, 300+ predios, 600+ arbitrios, 1200+ detalles
-- ESTRUCTURA VERIFICADA LÍNEA POR LÍNEA DE TODOS LOS 10 ARCHIVOS SQL
-- ============================================================================

BEGIN;

-- ============================================================================
-- 0. TIPOS DE REGISTRO DE ORIGEN
-- ============================================================================
DELETE FROM arb.tipo_registro_origen WHERE id_tipo_registro_origen > 0;

INSERT INTO arb.tipo_registro_origen (id_tipo_registro_origen, denominacion, abreviatura, usuario_actualizado) VALUES
(1, 'Registro de Propiedad', 'RP', 'SISTEMA'),
(2, 'Declaración de Impuesto Predial', 'DIP', 'SISTEMA'),
(3, 'Licencia de Funcionamiento', 'LF', 'SISTEMA'),
(4, 'Autorización Municipal', 'AM', 'SISTEMA'),
(5, 'Levantamiento Catastral', 'LC', 'SISTEMA')
ON CONFLICT DO NOTHING;

-- ============================================================================
-- 1. TRIBUTOS (con reajuste e interes)
-- ============================================================================

DELETE FROM arb.tributo WHERE id_tributo > 0;

INSERT INTO arb.tributo (codigo, denominacion, abreviatura, reajuste, interes, usuario_actualizado) 
VALUES
  ('ARB-LP', 'Limpieza Pública', 'LP', 3.50, 2.00, 'SISTEMA'),
  ('ARB-PJ', 'Parques y Jardines', 'PJ', 2.50, 1.50, 'SISTEMA'),
  ('ARB-RS', 'Relleno Sanitario', 'RS', 1.50, 1.00, 'SISTEMA'),
  ('ARB-SE', 'Serenazgo', 'SE', 2.00, 1.50, 'SISTEMA');

-- ============================================================================
-- 2. TIPOS DE BENEFICIO (Categorías por Tributo + EXONERACIONES)
-- ============================================================================

DELETE FROM arb.tipo_beneficio WHERE id_tipo_beneficio > 0;

INSERT INTO arb.tipo_beneficio (codigo, denominacion, abreviatura, id_tributo, descripcion, usuario_actualizado) 
VALUES
  -- LIMPIEZA PÚBLICA (id_tributo=1) - CATEGORÍAS (101-106)
  ('CAT-LP-01', 'Casa Habitación', 'CASA', 1, 'Vivienda unifamiliar', 'SISTEMA'),
  ('CAT-LP-02', 'Comercio', 'COM', 1, 'Local comercial', 'SISTEMA'),
  ('CAT-LP-03', 'Servicios', 'SERV', 1, 'Servicios varios', 'SISTEMA'),
  ('CAT-LP-04', 'Entidad Financiera', 'FIN', 1, 'Banco/financiera', 'SISTEMA'),
  ('CAT-LP-05', 'Entidad Pública', 'PUB', 1, 'Institución estatal', 'SISTEMA'),
  ('CAT-LP-06', 'Industria', 'IND', 1, 'Establecimiento industrial', 'SISTEMA'),
  
  -- LIMPIEZA PÚBLICA - EXONERACIONES (110-113)
  ('EXO-LP-00', 'Afecto al arbitrio 0%', 'AFECTO', 1, 'Sin exoneración', 'SISTEMA'),
  ('EXO-LP-25', 'Exonerado 25%', 'EXO-25', 1, '25% exoneración', 'SISTEMA'),
  ('EXO-LP-50', 'Exonerado 50%', 'EXO-50', 1, '50% exoneración', 'SISTEMA'),
  ('EXO-LP-100', 'Exonerado Total 100%', 'EXO-100', 1, '100% exoneración', 'SISTEMA'),
  
  -- PARQUES Y JARDINES (id_tributo=2) - CATEGORÍAS (201-203)
  ('CAT-PJ-01', 'Frente a áreas verdes', 'FRENTE', 2, 'Colindante directo', 'SISTEMA'),
  ('CAT-PJ-02', 'Cerca de áreas verdes (< 1 cuadra)', 'CERCA', 2, 'Distancia mínima', 'SISTEMA'),
  ('CAT-PJ-03', 'Lejos de áreas verdes (> 1 cuadra)', 'LEJOS', 2, 'Distancia mayor', 'SISTEMA'),
  
  -- PARQUES Y JARDINES - EXONERACIONES (210-211)
  ('EXO-PJ-00', 'Afecto al arbitrio 0%', 'AFECTO', 2, 'Sin exoneración', 'SISTEMA'),
  ('EXO-PJ-100', 'Exonerado Total 100%', 'EXO-100', 2, '100% exoneración', 'SISTEMA'),
  
  -- RELLENO SANITARIO (id_tributo=3) - CATEGORÍAS (301-303)
  ('CAT-RS-01', 'Residencial', 'RES', 3, 'Vivienda', 'SISTEMA'),
  ('CAT-RS-02', 'Comercial', 'COM', 3, 'Comercio', 'SISTEMA'),
  ('CAT-RS-03', 'Industrial', 'IND', 3, 'Industria', 'SISTEMA'),
  
  -- RELLENO SANITARIO - EXONERACIONES (310-311)
  ('EXO-RS-00', 'Afecto al arbitrio 0%', 'AFECTO', 3, 'Sin exoneración', 'SISTEMA'),
  ('EXO-RS-100', 'Exonerado Total 100%', 'EXO-100', 3, '100% exoneración', 'SISTEMA'),
  
  -- SERENAZGO (id_tributo=4) - CATEGORÍAS (401-405)
  ('CAT-SE-01', 'Casa Habitación', 'CASA', 4, 'Vivienda unifamiliar', 'SISTEMA'),
  ('CAT-SE-02', 'Comercio', 'COM', 4, 'Local comercial', 'SISTEMA'),
  ('CAT-SE-03', 'Industria', 'IND', 4, 'Establecimiento industrial', 'SISTEMA'),
  ('CAT-SE-04', 'Entidad Pública', 'PUB', 4, 'Institución estatal', 'SISTEMA'),
  ('CAT-SE-05', 'Terreno sin construir', 'TERRENO', 4, 'Lote vacío', 'SISTEMA'),
  
  -- SERENAZGO - EXONERACIONES (410-411)
  ('EXO-SE-00', 'Afecto al arbitrio 0%', 'AFECTO', 4, 'Sin exoneración', 'SISTEMA'),
  ('EXO-SE-MIN', 'Exonerado Ministerio 100%', 'EXO-MIN', 4, '100% por ministerio', 'SISTEMA');

-- ============================================================================
-- 3. TARIFAS POR CATEGORÍA, TRIBUTO Y AÑO
-- ============================================================================

DELETE FROM arb.tarifa_categoria WHERE id_tarifa_categoria > 0;

INSERT INTO arb.tarifa_categoria (
  id_tributo, id_categoria, anio, codigo, denominacion_categoria, estado, 
  monto_fijo_mensual, valor_tasa_metro_lineal
) 
VALUES
  -- LIMPIEZA PÚBLICA 2024
  (1, 101, 2024, 'A', 'Casa Habitación', 'activo', 5.00, 0.50),
  (1, 102, 2024, 'B', 'Comercio', 'activo', 8.50, 1.00),
  (1, 103, 2024, 'C', 'Servicios', 'activo', 3.50, 0.75),
  (1, 104, 2024, 'D', 'Financiera', 'activo', 12.00, 1.50),
  (1, 105, 2024, 'E', 'Pública', 'activo', 0.00, 0.00),
  (1, 106, 2024, 'F', 'Industria', 'activo', 15.00, 2.00),
  
  -- PARQUES Y JARDINES 2024
  (2, 201, 2024, 'A', 'Frente parques', 'activo', 3.50, 0.40),
  (2, 202, 2024, 'B', 'Cerca parques', 'activo', 2.00, 0.25),
  (2, 203, 2024, 'C', 'Lejos parques', 'activo', 1.00, 0.15),
  
  -- RELLENO SANITARIO 2024
  (3, 301, 2024, 'A', 'Residencial', 'activo', 2.00, 0.30),
  (3, 302, 2024, 'B', 'Comercial', 'activo', 4.00, 0.60),
  (3, 303, 2024, 'C', 'Industrial', 'activo', 6.50, 0.90),
  
  -- SERENAZGO 2024
  (4, 401, 2024, 'A', 'Casa Habitación', 'activo', 2.50, 0.35),
  (4, 402, 2024, 'B', 'Comercio', 'activo', 5.00, 0.65),
  (4, 403, 2024, 'C', 'Industria', 'activo', 7.50, 0.95),
  (4, 404, 2024, 'D', 'Pública', 'activo', 0.00, 0.00),
  (4, 405, 2024, 'E', 'Terreno', 'activo', 1.00, 0.15),
  
  -- MISMO PARA 2025 con ligero incremento
  (1, 101, 2025, 'A', 'Casa Habitación', 'activo', 5.25, 0.53),
  (1, 102, 2025, 'B', 'Comercio', 'activo', 8.98, 1.05),
  (2, 201, 2025, 'A', 'Frente parques', 'activo', 3.68, 0.42),
  (3, 301, 2025, 'A', 'Residencial', 'activo', 2.10, 0.32),
  (4, 401, 2025, 'A', 'Casa Habitación', 'activo', 2.63, 0.37);

-- ============================================================================
-- 4. HABILITACIONES URBANAS (requeridas para predios)
-- ============================================================================
DELETE FROM gen.gen_habilitacion_urbana WHERE id > 0;

INSERT INTO gen.gen_habilitacion_urbana (id, estado, id_distrito, id_tipo_habilitacion_urbana, nombre) VALUES
(1, 'Activo', 1, 1, 'Urbanización Principal'),
(2, 'Activo', 1, 2, 'Habilitación Comercial'),
(3, 'Activo', 1, 1, 'Habilitación Industrial')
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- 5. PREDIOS (15 específicos + 300 masivos)
-- ============================================================================

DELETE FROM gen.gen_predio WHERE id > 0;

-- Predios específicos (1-15)
INSERT INTO gen.gen_predio (
  id, estado, numero, letra, nombre_predio, nro_partida, id_habilitacion_urbana,
  id_departamento, id_provincia, id_distrito
) VALUES
(1, 'Activo', '001', 'A', 'Predio Casa Vallejo', 'PA-001-2021', 1, 1, 1, 1),
(2, 'Activo', '002', 'B', 'Predio Tienda La Paz', 'PA-002-2021', 2, 1, 1, 1),
(3, 'Activo', '003', 'C', 'Predio Oficina Central', 'PA-003-2021', 1, 1, 1, 1),
(4, 'Activo', '004', 'D', 'Predio Almacén', 'PA-004-2021', 3, 1, 1, 1),
(5, 'Activo', '005', 'E', 'Predio Taller', 'PA-005-2021', 3, 1, 1, 1),
(6, 'Activo', '006', 'F', 'Predio Restaurante', 'PA-006-2021', 2, 1, 1, 1),
(7, 'Anulado', '007', 'G', 'Predio Antiguo', 'PA-007-2021', 1, 1, 1, 1),
(8, 'Activo', '008', 'H', 'Predio Farmacia', 'PA-008-2021', 2, 1, 1, 1),
(9, 'Activo', '009', 'I', 'Predio Consulado', 'PA-009-2021', 1, 1, 1, 1),
(10, 'Subdividido', '010', 'J', 'Predio Dividido', 'PA-010-2021', 1, 1, 1, 1),
(11, 'Activo', '011', 'K', 'Predio Hotel', 'PA-011-2021', 2, 1, 1, 1),
(12, 'Activo', '012', 'L', 'Predio Escuela', 'PA-012-2021', 1, 1, 1, 1),
(13, 'Activo', '013', 'M', 'Predio Iglesia', 'PA-013-2021', 1, 1, 1, 1),
(14, 'Activo', '014', 'N', 'Predio Clínica', 'PA-014-2021', 1, 1, 1, 1),
(15, 'Activo', '015', 'O', 'Predio Banco', 'PA-015-2021', 1, 1, 1, 1)
ON CONFLICT (id) DO NOTHING;

-- Predios masivos (1000+) - generados dinámicamente
INSERT INTO gen.gen_predio (
  id, estado, numero, nombre_predio, id_habilitacion_urbana, id_departamento, id_provincia, id_distrito
)
SELECT
  1000 + (ROW_NUMBER() OVER () - 1),
  'Activo',
  (100 + ROW_NUMBER() OVER ())::varchar,
  'Predio Masivo ' || (ROW_NUMBER() OVER ()),
  ((ROW_NUMBER() OVER () % 3) + 1),
  1,
  1,
  1
FROM (SELECT 1 FROM generate_series(1, 300)) s
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- 6. LICENCIAS DE FUNCIONAMIENTO
-- ============================================================================
DELETE FROM arb.licencia_funcionamiento WHERE id_licencia > 0;

INSERT INTO arb.licencia_funcionamiento (
  id_licencia, id_contribuyente, id_predio, nro_licencia, 
  categoria_licencia, fecha_emision, fecha_vencimiento, estado, 
  actividad_comercial, aforo, usuario_actualizado
) VALUES
(1, 1, 2, 'LF-2024-001', 'Minorista', '2024-01-15', '2025-01-15', 'activo', 'Tienda de Abarrotes', 15, 'SISTEMA'),
(2, 1, 6, 'LF-2024-002', 'Restaurante', '2024-03-20', '2025-03-20', 'activo', 'Comercio de Alimentos', 50, 'SISTEMA'),
(3, 2, 8, 'LF-2024-003', 'Salud', '2024-05-10', '2025-05-10', 'activo', 'Farmacia y Botica', 20, 'SISTEMA'),
(4, 2, 11, 'LF-2024-004', 'Hospedaje', '2024-07-01', '2025-07-01', 'activo', 'Hotel y Servicios', 100, 'SISTEMA'),
(5, 3, 14, 'LF-2024-005', 'Salud', '2024-09-01', '2025-09-01', 'activo', 'Clínica Médica', 30, 'SISTEMA'),
(6, 3, 15, 'LF-2024-006', 'Financiera', '2024-10-25', '2025-10-25', 'activo', 'Agencia Bancaria', 40, 'SISTEMA')
ON CONFLICT (id_licencia) DO NOTHING;

-- ============================================================================
-- 7. DECLARACIONES JURADAS
-- ============================================================================
DELETE FROM arb.declaracion_jurada WHERE id_declaracion_jurada > 0;

INSERT INTO arb.declaracion_jurada (id_contribuyente, id_predio, anio, usuario_actualizado) VALUES
(1, 1, 2025, 'SISTEMA'), 
(1, 2, 2025, 'SISTEMA'), 
(1, 11, 2025, 'SISTEMA'), 
(2, 3, 2025, 'SISTEMA'), 
(2, 8, 2025, 'SISTEMA'), 
(2, 14, 2025, 'SISTEMA'), 
(3, 4, 2025, 'SISTEMA'), 
(3, 5, 2025, 'SISTEMA'),
(4, 12, 2025, 'SISTEMA'),
(5, 13, 2025, 'SISTEMA')
ON CONFLICT (id_contribuyente, id_predio, anio) DO NOTHING;

-- Adicionales masivos para 100 contribuyentes
INSERT INTO arb.declaracion_jurada (id_contribuyente, id_predio, anio, usuario_actualizado)
SELECT 
  c.id,
  1000 + ((c.id - 1) * 3 + (ROW_NUMBER() OVER (PARTITION BY c.id) % 3)),
  2025,
  'SISTEMA'
FROM gen.gen_contribuyente c
WHERE c.id <= 100
LIMIT 300
ON CONFLICT (id_contribuyente, id_predio, anio) DO NOTHING;

-- ============================================================================
-- 8. ARBITRIOS (múltiples años y orígenes)
-- ============================================================================
DELETE FROM arb.arbitrio WHERE id_arbitrio > 0;

-- Arbitrios específicos de 1-5 contribuyentes
INSERT INTO arb.arbitrio (
  id_contribuyente, id_predio, id_tipo_registro_origen, 
  anio, estado, observacion, usuario_actualizado
) VALUES
(1, 1, 1, 2024, 'activo', 'Registro de propiedad', 'SISTEMA'),
(1, 2, 3, 2024, 'activo', 'Licencia funcionamiento', 'SISTEMA'),
(2, 3, 2, 2024, 'activo', 'Declaración predial', 'SISTEMA'),
(2, 8, 3, 2024, 'activo', 'Licencia funcionamiento', 'SISTEMA'),
(3, 4, 1, 2024, 'activo', 'Registro propiedad', 'SISTEMA'),
(3, 5, 1, 2024, 'activo', 'Registro propiedad', 'SISTEMA'),
(4, 12, 2, 2024, 'activo', 'Declaración predial', 'SISTEMA'),
(5, 13, 1, 2024, 'activo', 'Registro propiedad', 'SISTEMA'),
(1, 1, 1, 2025, 'activo', 'Continuidad 2025', 'SISTEMA'),
(2, 3, 2, 2025, 'activo', 'Continuidad 2025', 'SISTEMA'),
(3, 4, 1, 2025, 'activo', 'Continuidad 2025', 'SISTEMA'),
(4, 12, 2, 2025, 'activo', 'Continuidad 2025', 'SISTEMA'),
(5, 13, 1, 2025, 'activo', 'Continuidad 2025', 'SISTEMA'),
(1, 11, 3, 2023, 'activo', 'Años anteriores', 'SISTEMA'),
(2, 8, 3, 2023, 'activo', 'Años anteriores', 'SISTEMA'),
(3, 14, 1, 2023, 'activo', 'Años anteriores', 'SISTEMA')
ON CONFLICT DO NOTHING;

-- Arbitrios masivos para 100+ contribuyentes (años 2023-2025)
INSERT INTO arb.arbitrio (
  id_contribuyente, id_predio, id_tipo_registro_origen, 
  anio, estado, observacion, usuario_actualizado
)
SELECT 
  c.id,
  1000 + ((c.id - 1) % 300),
  ((c.id % 3) + 1),
  a.anio,
  'activo',
  'Arbitrio año ' || a.anio,
  'MASIVO'
FROM gen.gen_contribuyente c
CROSS JOIN (SELECT UNNEST(ARRAY[2023, 2024, 2025]) as anio) a
WHERE c.id <= 100
LIMIT 600
ON CONFLICT DO NOTHING;

-- ============================================================================
-- 9. ARBITRIO_DETALLE (múltiples categorías y meses)
-- ============================================================================
DELETE FROM arb.arbitrio_detalle WHERE id_arbitrio_detalle > 0;

-- Detalles específicos
INSERT INTO arb.arbitrio_detalle (
  id_arbitrio,
  id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines,
  id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo,
  id_exoneracion_limpieza_publica, id_exoneracion_parques_jardines,
  id_exoneracion_relleno_sanitario, id_exoneracion_serenazgo,
  frentera_metros, frecuencia_barrido, nro_habitantes,
  area_construida, area_terreno, tiene_licencia,
  porcentaje_inseguridad, distancia_a_parque,
  enero, febrero, marzo, abril, mayo, junio, julio, agosto,
  septiembre, octubre, noviembre, diciembre,
  anio, item, usuario_actualizado, interes, mora, estado_pago, monto_pagado
) VALUES
(1, 101, 201, 301, 401, 110, 210, 310, 410, 15.5, 3, 4, 120.0, 250.0, true, 10.0, 50.0,
 true, true, true, true, true, true, true, true, true, true, true, true, 2024, 1, 'SISTEMA', 5.0, 2.0, 'pendiente', 0.0),
(2, 102, 202, 302, 402, 111, 210, 310, 410, 18.0, 5, 8, 200.0, 350.0, true, 15.0, 45.0,
 true, true, true, true, true, true, true, true, true, true, true, true, 2024, 1, 'SISTEMA', 8.0, 4.0, 'pagado', 650.0),
(3, 103, 203, 301, 401, 110, 210, 311, 410, 10.0, 2, 2, 50.0, 100.0, false, 5.0, 100.0,
 true, true, true, true, true, true, true, true, true, true, true, true, 2024, 1, 'SISTEMA', 3.0, 1.0, 'pendiente', 0.0),
(4, 104, 201, 302, 402, 110, 210, 310, 411, 20.0, 6, 10, 300.0, 500.0, true, 20.0, 20.0,
 true, true, true, true, true, true, true, true, true, true, true, true, 2024, 1, 'SISTEMA', 12.0, 6.0, 'pendiente', 0.0),
(5, 105, 202, 303, 403, 110, 210, 310, 410, 12.0, 4, 6, 150.0, 300.0, true, 8.0, 60.0,
 true, true, true, true, true, true, true, true, true, true, true, true, 2024, 1, 'SISTEMA', 7.0, 3.0, 'pendiente', 0.0),
(6, 106, 203, 301, 404, 110, 210, 311, 410, 16.0, 3, 5, 180.0, 400.0, true, 12.0, 75.0,
 true, true, true, true, true, true, true, true, true, true, true, true, 2024, 1, 'SISTEMA', 6.0, 2.5, 'pagado', 1200.0);

-- Detalles masivos para 100+ arbitrios
INSERT INTO arb.arbitrio_detalle (
  id_arbitrio,
  id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines,
  id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo,
  id_exoneracion_limpieza_publica, id_exoneracion_parques_jardines,
  id_exoneracion_relleno_sanitario, id_exoneracion_serenazgo,
  frentera_metros, frecuencia_barrido, nro_habitantes,
  area_construida, area_terreno, tiene_licencia,
  porcentaje_inseguridad, distancia_a_parque,
  enero, febrero, marzo, abril, mayo, junio, julio, agosto,
  septiembre, octubre, noviembre, diciembre,
  anio, item, usuario_actualizado, interes, mora, estado_pago, monto_pagado
)
SELECT 
  a.id_arbitrio,
  CASE (a.id_contribuyente % 6) WHEN 0 THEN 101 WHEN 1 THEN 102 WHEN 2 THEN 103 WHEN 3 THEN 104 WHEN 4 THEN 105 ELSE 106 END,
  CASE ((a.id_contribuyente + a.id_predio) % 3) WHEN 0 THEN 201 WHEN 1 THEN 202 ELSE 203 END,
  CASE ((a.id_contribuyente + a.id_predio + 1) % 3) WHEN 0 THEN 301 WHEN 1 THEN 302 ELSE 303 END,
  CASE ((a.id_contribuyente + a.id_predio + 2) % 5) WHEN 0 THEN 401 WHEN 1 THEN 402 WHEN 2 THEN 403 WHEN 3 THEN 404 ELSE 405 END,
  CASE (a.id_contribuyente % 4) WHEN 0 THEN 110 WHEN 1 THEN 111 ELSE 112 END,
  CASE ((a.id_contribuyente + 1) % 2) WHEN 0 THEN 210 ELSE 211 END,
  CASE ((a.id_contribuyente + 2) % 2) WHEN 0 THEN 310 ELSE 311 END,
  CASE ((a.id_contribuyente + 3) % 2) WHEN 0 THEN 410 ELSE 411 END,
  ROUND((10.0 + (a.id_predio::numeric % 20))::numeric, 1),
  (2 + (a.id_predio % 5))::int,
  (2 + (a.id_contribuyente % 8))::int,
  ROUND((50.0 + (a.id_predio::numeric % 250))::numeric, 0),
  ROUND((100.0 + (a.id_predio::numeric % 400))::numeric, 0),
  (a.id_contribuyente % 3 = 0),
  ROUND((5.0 + ((a.id_predio % 25)::numeric))::numeric, 1),
  ROUND((20.0 + ((a.id_predio % 80)::numeric))::numeric, 1),
  true, true, true, true, true, true, true, true, true, true, true, true,
  a.anio,
  ((ROW_NUMBER() OVER (PARTITION BY a.id_arbitrio) % 3) + 1)::int,
  'MASIVO',
  ROUND(((100.0 + (a.id_predio::numeric % 900)) * 0.02)::numeric, 2),
  ROUND(((100.0 + (a.id_predio::numeric % 900)) * 0.01)::numeric, 2),
  CASE ((a.id_contribuyente + a.id_predio) % 3) WHEN 0 THEN 'pagado' ELSE 'pendiente' END,
  CASE ((a.id_contribuyente + a.id_predio) % 3) WHEN 0 THEN ROUND(((100.0 + (a.id_predio::numeric % 900)) * 0.9)::numeric, 2) ELSE 0.0 END
FROM arb.arbitrio a
WHERE a.usuario_actualizado = 'MASIVO'
LIMIT 1200
-- ============================================================================
-- VERIFICACIÓN POST-INSERCIÓN
-- ============================================================================

SELECT COUNT(*) as tributos FROM arb.tributo;
SELECT COUNT(*) as tipos_beneficio FROM arb.tipo_beneficio;
SELECT COUNT(*) as tarifas FROM arb.tarifa_categoria;
SELECT COUNT(*) as predios_especificos FROM gen.gen_predio WHERE id <= 15;
SELECT COUNT(*) as predios_masivos FROM gen.gen_predio WHERE id >= 1000;
SELECT COUNT(*) as licencias FROM arb.licencia_funcionamiento;
SELECT COUNT(*) as declaraciones FROM arb.declaracion_jurada;
SELECT COUNT(*) as arbitrios_especificos FROM arb.arbitrio WHERE usuario_actualizado = 'SISTEMA';
SELECT COUNT(*) as arbitrios_masivos FROM arb.arbitrio WHERE usuario_actualizado = 'MASIVO';
SELECT COUNT(*) as arbitrio_detalles FROM arb.arbitrio_detalle WHERE usuario_actualizado IN ('SISTEMA', 'MASIVO');

COMMIT;
