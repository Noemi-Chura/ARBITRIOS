-- ==========================================================
-- 1. DDL: DECLARACIÓN JURADA (DDJJ)
-- ==========================================================
CREATE TABLE IF NOT EXISTS arb.declaracion_jurada (
    id_declaracion_jurada SERIAL,
    id_contribuyente INT NOT NULL,
    id_predio INT NOT NULL, 
    anio INT NOT NULL, 
    usuario_actualizado VARCHAR(100),
    fecha_actualizado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado VARCHAR(100),
    
    CONSTRAINT pk_declaracion_jurada PRIMARY KEY (id_declaracion_jurada),
    CONSTRAINT fk_ddjj_contribuyente FOREIGN KEY (id_contribuyente) REFERENCES gen.gen_contribuyente(id),
    CONSTRAINT fk_ddjj_predio FOREIGN KEY (id_predio) REFERENCES gen.gen_predio(id),
    
    -- Restricción: Un contribuyente puede tener solo una DDJJ 'Activa' para un predio en un año dado.
    CONSTRAINT uq_ddjj_contribuyente_predio_anio_activo UNIQUE (id_contribuyente, id_predio, anio)
);

-- ==========================================================
-- 2. INSERCIÓN DE DATOS: arb.declaracion_jurada (DDJJ)
-- [CORREGIDO: Eliminados espacios extraños en los VALUES]
-- ==========================================================
INSERT INTO arb.declaracion_jurada (
    id_contribuyente, id_predio, anio, usuario_actualizado
) VALUES
-- Contribuyente 1
(1, 1, 2025, 'ADMIN'), 
(1, 2, 2025, 'ADMIN'), 
(1, 11, 2025, 'ADMIN'), 
-- Contribuyente 2
(2, 3, 2025, 'ADMIN'), 
(2, 8, 2025, 'ADMIN'), 
(2, 14, 2025, 'ADMIN'), 
-- Contribuyente 3
(3, 4, 2025, 'ADMIN'), -- Predio 4 (Almacén)
(3, 5, 2025, 'ADMIN') 
ON CONFLICT (id_contribuyente, id_predio, anio) DO NOTHING;

-- 1.1 Insertar Grupo de Categoría por defecto (Necesario para la FK en Categoria)
INSERT INTO arb.grupo_categoria (id_grupo_categoria, denominacion, abreviatura, usuario_actualizado) VALUES
(1, 'Categorías de Licencia', 'LIC', 'ADMIN')
ON CONFLICT (id_grupo_categoria) DO NOTHING;

-- 1.2 Insertar Categorías que se usan en las Licencias (ID 1, 2, 3)
INSERT INTO arb.categoria (id_categoria, codigo, denominacion, abreviatura, id_grupo_categoria, usuario_actualizado) VALUES
(1, 'C1', 'Comercio Minorista / Hospedaje / Financiera', 'CM', 1, 'ADMIN'),
(2, 'C2', 'Servicios de Restauración', 'SR', 1, 'ADMIN'),
(3, 'C3', 'Servicios de Salud / Farmacia', 'SS', 1, 'ADMIN')
ON CONFLICT (id_categoria) DO NOTHING;

-- ==========================================================
-- 3. INSERCIÓN DE DATOS: arb.licencia_funcionamiento (LF)
-- [CORREGIDO: Eliminados espacios extraños en los VALUES]
-- ==========================================================
INSERT INTO arb.licencia_funcionamiento (
    id_licencia, id_contribuyente, id_predio, id_categoria, nro_licencia, 
    categoria_licencia, fecha_emision, fecha_vencimiento, estado, 
    actividad_comercial, aforo, usuario_actualizado
) VALUES
-- Contribuyente 1 (2 licencias)
(1, 1, 2, 1, 'LF-2024-001', 'Minorista', '2024-01-15', '2025-01-15', 'activo', 
 'Tienda de Abarrotes', 15, 'ADMIN'),
(2, 1, 6, 2, 'LF-2024-002', 'Restaurante', '2024-03-20', '2025-03-20', 'activo', 
 'Comercio de Alimentos', 50, 'ADMIN'),
-- Contribuyente 2 (2 licencias)
(3, 2, 8, 3, 'LF-2024-003', 'Salud', '2024-05-10', '2025-05-10', 'activo', 
 'Farmacia y Botica', 20, 'ADMIN'),
(4, 2, 11, 1, 'LF-2024-004', 'Hospedaje', '2024-07-01', '2025-07-01', 'activo', 
 'Hotel y Servicios', 100, 'ADMIN'),
-- Contribuyente 3 (2 licencias)
(5, 3, 14, 3, 'LF-2024-005', 'Salud', '2024-09-01', '2025-09-01', 'activo', 
 'Clínica Médica', 30, 'ADMIN'),
(6, 3, 15, 1, 'LF-2024-006', 'Financiera', '2024-10-25', '2025-10-25', 'activo', 
 'Agencia Bancaria', 40, 'ADMIN')
ON CONFLICT (id_licencia) DO NOTHING;

-- ==========================================================
-- 4. ACTUALIZACIÓN DE SECUENCIA
-- ==========================================================
SELECT SETVAL('arb.licencia_funcionamiento_id_licencia_seq', (SELECT MAX(id_licencia) FROM arb.licencia_funcionamiento));


ALTER TABLE arb.arbitrio_detalle 
ADD COLUMN item INTEGER DEFAULT 1;


-- Agregar campos para exoneraciones
ALTER TABLE arb.arbitrio_detalle 
ADD COLUMN id_exoneracion_limpieza_publica INTEGER,
ADD COLUMN id_exoneracion_parques_jardines INTEGER,
ADD COLUMN id_exoneracion_relleno_sanitario INTEGER,
ADD COLUMN id_exoneracion_serenazgo INTEGER;

-- Agregar foreign keys si es necesario
ALTER TABLE arb.arbitrio_detalle 
ADD CONSTRAINT fk_exoneracion_limpieza FOREIGN KEY (id_exoneracion_limpieza_publica) 
REFERENCES arb.tipo_beneficio(id_tipo_beneficio),
ADD CONSTRAINT fk_exoneracion_parques FOREIGN KEY (id_exoneracion_parques_jardines) 
REFERENCES arb.tipo_beneficio(id_tipo_beneficio),
ADD CONSTRAINT fk_exoneracion_residuos FOREIGN KEY (id_exoneracion_relleno_sanitario) 
REFERENCES arb.tipo_beneficio(id_tipo_beneficio),
ADD CONSTRAINT fk_exoneracion_serenazgo FOREIGN KEY (id_exoneracion_serenazgo) 
REFERENCES arb.tipo_beneficio(id_tipo_beneficio);


-- Primero, si existe una secuencia para id_tributo, ajustémosla
CREATE SEQUENCE IF NOT EXISTS arb.tributo_id_tributo_seq;

-- Asigna la secuencia a la columna id_tributo
ALTER TABLE arb.tributo 
ALTER COLUMN id_tributo 
SET DEFAULT nextval('arb.tributo_id_tributo_seq'::regclass);

-- Insertar los tributos de arbitrios municipales
INSERT INTO arb.tributo (id_tributo, codigo, denominacion, abreviatura, reajuste, interes, usuario_actualizado) VALUES
-- Tributos principales de arbitrios
(1, 'ARB-LIMP', 'Limpieza Pública', 'LIMP', 0.00, 0.00, 'SISTEMA'),
(2, 'ARB-PARQ', 'Parques y Jardines', 'PARQ', 0.00, 0.00, 'SISTEMA'),
(3, 'ARB-RS', 'Relleno Sanitario', 'RS', 0.00, 0.00, 'SISTEMA'),
(4, 'ARB-SER', 'Serenazgo', 'SER', 0.00, 0.00, 'SISTEMA');

-- O si prefieres usar secuencia automática:
-- ==========================================================
-- 1. INSERTAR TRIBUTOS (si la tabla está vacía)
-- ==========================================================
TRUNCATE TABLE arb.tributo RESTART IDENTITY CASCADE;

INSERT INTO arb.tributo (codigo, denominacion, abreviatura, reajuste, interes, usuario_actualizado) VALUES
('ARB-LIMP', 'Limpieza Pública', 'LIMP', 0.00, 0.00, 'SISTEMA'),
('ARB-PARQ', 'Parques y Jardines', 'PARQ', 0.00, 0.00, 'SISTEMA'),
('ARB-RS', 'Relleno Sanitario', 'RS', 0.00, 0.00, 'SISTEMA'),
('ARB-SER', 'Serenazgo', 'SER', 0.00, 0.00, 'SISTEMA');

-- Verificar
SELECT * FROM arb.tributo ORDER BY id_tributo;

-- ==========================================================
-- 2. INSERTAR TIPOS DE BENEFICIO (Categorías y Exoneraciones)
-- ==========================================================
TRUNCATE TABLE arb.tipo_beneficio RESTART IDENTITY CASCADE;

-- CATEGORÍAS PARA LIMPIEZA PÚBLICA (id_tributo = 1)
INSERT INTO arb.tipo_beneficio (codigo, denominacion, abreviatura, id_tributo, usuario_actualizado) VALUES
('CAT-LIMP-01', 'Sin categoría', 'S/C', 1, 'SISTEMA'),
('CAT-LIMP-02', 'Casa Habitación', 'CASA', 1, 'SISTEMA'),
('CAT-LIMP-03', 'Comercio', 'COM', 1, 'SISTEMA'),
('CAT-LIMP-04', 'Servicio General', 'SERV', 1, 'SISTEMA'),
('CAT-LIMP-05', 'Entidad Financiera', 'FINAN', 1, 'SISTEMA'),
('CAT-LIMP-06', 'Entidad Pública', 'PUB', 1, 'SISTEMA'),
('CAT-LIMP-07', 'Industria', 'IND', 1, 'SISTEMA'),

-- CATEGORÍAS PARA PARQUES Y JARDINES (id_tributo = 2)
('CAT-PARQ-01', 'Sin categoría', 'S/C', 2, 'SISTEMA'),
('CAT-PARQ-02', 'Frente a áreas verdes', 'FRENTE', 2, 'SISTEMA'),
('CAT-PARQ-03', 'Cerca de áreas verdes en radio de 1 MZA', 'CERCA', 2, 'SISTEMA'),
('CAT-PARQ-04', 'Lejos de áreas verdes más de 1 MZA', 'LEJOS', 2, 'SISTEMA'),

-- CATEGORÍAS PARA RESIDUOS SÓLIDOS (solo "Sin categoría" según lo solicitado)
('CAT-RES-01', 'Sin categoría', 'S/C', 3, 'SISTEMA'),

-- CATEGORÍAS PARA SERENAZGO (id_tributo = 4)
('CAT-SER-01', 'Sin categoría', 'S/C', 4, 'SISTEMA'),
('CAT-SER-02', 'Terreno sin construir', 'TERRENO', 4, 'SISTEMA'),
('CAT-SER-03', 'Casa Habitación', 'CASA', 4, 'SISTEMA'),
('CAT-SER-04', 'Comercio', 'COM', 4, 'SISTEMA'),
('CAT-SER-05', 'Servicio General', 'SERV', 4, 'SISTEMA'),
('CAT-SER-06', 'Entidad Financiera', 'FINAN', 4, 'SISTEMA'),
('CAT-SER-07', 'Industria/Minería o Fines', 'IND', 4, 'SISTEMA'),

-- =========== EXONERACIONES ===========
-- Para Limpieza Pública (id_tributo = 1) - "Afecto al arbitrio" será el valor por defecto (ID 22)
('EXO-LIMP-00', 'Afecto al arbitrio (0% exoneración)', 'AFECTO', 1, 'SISTEMA'),
('EXO-LIMP-25', 'Exonerado pensionista a 25%', 'EXO-25%', 1, 'SISTEMA'),
('EXO-LIMP-33', 'Exonerado 33.33%', 'EXO-33%', 1, 'SISTEMA'),
('EXO-LIMP-50', 'Exonerado pensionista a 50%', 'EXO-50%', 1, 'SISTEMA'),
('EXO-LIMP-100', 'Exonerado total 100%', 'EXO-100%', 1, 'SISTEMA'),

-- Para Parques y Jardines (id_tributo = 2)
('EXO-PARQ-00', 'Afecto al arbitrio (0% exoneración)', 'AFECTO', 2, 'SISTEMA'),
('EXO-PARQ-25', 'Exonerado pensionista a 25%', 'EXO-25%', 2, 'SISTEMA'),
('EXO-PARQ-33', 'Exonerado 33.33%', 'EXO-33%', 2, 'SISTEMA'),
('EXO-PARQ-50', 'Exonerado pensionista a 50%', 'EXO-50%', 2, 'SISTEMA'),
('EXO-PARQ-100', 'Exonerado total 100%', 'EXO-100%', 2, 'SISTEMA'),

-- Para Relleno Sanitario (id_tributo = 3)
('EXO-RES-00', 'Afecto al arbitrio (0% exoneración)', 'AFECTO', 3, 'SISTEMA'),
('EXO-RES-25', 'Exonerado pensionista a 25%', 'EXO-25%', 3, 'SISTEMA'),
('EXO-RES-33', 'Exonerado 33.33%', 'EXO-33%', 3, 'SISTEMA'),
('EXO-RES-50', 'Exonerado pensionista a 50%', 'EXO-50%', 3, 'SISTEMA'),
('EXO-RES-100', 'Exonerado total 100%', 'EXO-100%', 3, 'SISTEMA'),

-- Para Serenazgo (id_tributo = 4)
('EXO-SER-00', 'Afecto al arbitrio (0% exoneración)', 'AFECTO', 4, 'SISTEMA'),
('EXO-SER-25', 'Exonerado pensionista a 25%', 'EXO-25%', 4, 'SISTEMA'),
('EXO-SER-33', 'Exonerado 33.33%', 'EXO-33%', 4, 'SISTEMA'),
('EXO-SER-50', 'Exonerado pensionista a 50%', 'EXO-50%', 4, 'SISTEMA'),
('EXO-SER-100', 'Exonerado total 100%', 'EXO-100%', 4, 'SISTEMA');


INSERT INTO arb.arbitrio_detalle (
    id_arbitrio_detalle, id_arbitrio, 
    id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines, 
    id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo, 
    frentera_metros, frecuencia_barrido, nro_habitantes, area_construida, area_terreno, tiene_licencia, 
    porcentaje_inseguridad, monto_base, monto_final, distancia_a_parque, 
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre, 
    anio, usuario_actualizado, interes, mora, item, 
    id_exoneracion_limpieza_publica, id_exoneracion_parques_jardines, 
    id_exoneracion_relleno_sanitario, id_exoneracion_serenazgo
) VALUES (
    4, -- Nuevo id_arbitrio_detalle
    16, -- Mismo id_arbitrio (Contribuyente 1, Predio 14)
    3, -- Cat Limpieza: Comercio
    10, -- Cat Parques: Cerca de áreas verdes
    12, -- Cat Residuos: Sin categoría
    16, -- Cat Serenazgo: Comercio
    8.00, 3, 2, 80.00, 150.00, 1, -- Datos
    0.00, 120.00, 130.50, 25.00, -- Montos (incluye Mora)
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, -- Meses: Todos activos
    2024, 'SISTEMA', 10.50, 0.00, 1, -- Año 2024
    20, -- Exo Limpieza: Afecto
    25, -- Exo Parques: Afecto
    34, -- Exo Residuos: Exonerado total 100%
    35  -- Exo Serenazgo: Afecto
);

INSERT INTO arb.arbitrio_detalle (
    id_arbitrio_detalle, id_arbitrio, 
    id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines, 
    id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo, 
    frentera_metros, frecuencia_barrido, nro_habitantes, area_construida, area_terreno, tiene_licencia, 
    porcentaje_inseguridad, monto_base, monto_final, distancia_a_parque, 
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre, 
    anio, usuario_actualizado, interes, mora, item, 
    id_exoneracion_limpieza_publica, id_exoneracion_parques_jardines, 
    id_exoneracion_relleno_sanitario, id_exoneracion_serenazgo
) VALUES (
    5, -- Nuevo id_arbitrio_detalle
    16, -- Mismo id_arbitrio (Contribuyente 1, Predio 14)
    2, 
    9, 
    12, 
    15, -- Cat Serenazgo: Casa Habitación
    10.00, 5, 4, 100.00, 200.00, 1, 
    0.00, 95.00, 107.50, 40.00, 
    0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, -- Meses: De Mayo a Diciembre activos
    2023, 'ADMIN', 7.50, 5.00, 1, -- Interés y Mora aplicados
    20, 
    25, 
    30, 
    35 
);

-- Primer INSERT: id_arbitrio = 16 (Contribuyente 1, Predio 14, Año 2025)
INSERT INTO arb.arbitrio_detalle (
    id_arbitrio_detalle, id_arbitrio, 
    id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines, 
    id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo, 
    frentera_metros, frecuencia_barrido, nro_habitantes, area_construida, area_terreno, tiene_licencia, 
    porcentaje_inseguridad, monto_base, monto_final, distancia_a_parque, 
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre, 
    anio, usuario_actualizado, interes, mora, item, 
    id_exoneracion_limpieza_publica, id_exoneracion_parques_jardines, 
    id_exoneracion_relleno_sanitario, id_exoneracion_serenazgo
) VALUES (
    1, 
    16, 
    2, 
    9, 
    12, 
    16, 
    10.50, 5, 4, 120.00, 200.00, 1, -- tiene_licencia: 1
    0.00, 150.75, 156.00, 50.00, 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, -- Meses: todos 1
    2025, 'ADMIN', 5.25, 0.00, 1, 
    20, 
    28, 
    30, 
    35  
);

-- Segundo INSERT: id_arbitrio = 20 (Contribuyente 1, Predio 2, Año 2025)
INSERT INTO arb.arbitrio_detalle (
    id_arbitrio_detalle, id_arbitrio, 
    id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines, 
    id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo, 
    frentera_metros, frecuencia_barrido, nro_habitantes, area_construida, area_terreno, tiene_licencia, 
    porcentaje_inseguridad, monto_base, monto_final, distancia_a_parque, 
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre, 
    anio, usuario_actualizado, interes, mora, item, 
    id_exoneracion_limpieza_publica, id_exoneracion_parques_jardines, 
    id_exoneracion_relleno_sanitario, id_exoneracion_serenazgo
) VALUES (
    6, 
    20, 
    3, 10, 12, 17, 
    10.50, 5, 4, 120.00, 200.00, 1, -- tiene_licencia: 1
    0.00, 200.00, 200.00, 50.00, 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, -- Meses: todos 1
    2024, 'ADMIN', 0.00, 0.00, 1, 
    24, 25, 30, 35 
);

INSERT INTO arb.arbitrio_detalle (
    id_arbitrio_detalle, id_arbitrio, 
    id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines, 
    id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo, 
    frentera_metros, frecuencia_barrido, nro_habitantes, area_construida, area_terreno, tiene_licencia, 
    porcentaje_inseguridad, monto_base, monto_final, distancia_a_parque, 
    enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre, 
    anio, usuario_actualizado, interes, mora, item, 
    id_exoneracion_limpieza_publica, id_exoneracion_parques_jardines, 
    id_exoneracion_relleno_sanitario, id_exoneracion_serenazgo
) VALUES (
    5, -- Nuevo id_arbitrio_detalle
    16, -- Mismo id_arbitrio (Contribuyente 1, Predio 14)
    2, 
    9, 
    12, 
    15, -- Cat Serenazgo: Casa Habitación
    10.00, 5, 4, 100.00, 200.00, 1, 
    0.00, 95.00, 107.50, 40.00, 
    0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, -- Meses: De Mayo a Diciembre activos
    2023, 'ADMIN', 7.50, 5.00, 1, -- Interés y Mora aplicados
    20, 
    25, 
    30, 
    35 
);