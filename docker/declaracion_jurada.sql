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