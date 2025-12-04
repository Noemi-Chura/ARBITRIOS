INSERT INTO gen.gen_habilitacion_urbana (
  id, estado, id_distrito, id_tipo_habilitacion_urbana, nombre, f_control, h_control, fecha_servidor
) VALUES
(1, 'Activo', 1, 1, 'Urbanización Principal', CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP),
(2, 'Activo', 1, 2, 'Habilitación Comercial', CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP),
(3, 'Activo', 1, 1, 'Habilitación Industrial', CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

INSERT INTO gen.gen_predio (
  id, estado, numero, letra, nombre_predio, nro_partida, id_habilitacion_urbana,
  f_control, h_control, fecha_servidor, id_departamento, id_provincia, id_distrito
) VALUES
(1, 'Activo', '001', 'A', 'Predio Casa Vallejo', 'PA-001-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(2, 'Activo', '002', 'B', 'Predio Tienda La Paz', 'PA-002-2021', 2, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(3, 'Activo', '003', 'C', 'Predio Oficina Central', 'PA-003-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(4, 'Activo', '004', 'D', 'Predio Almacén', 'PA-004-2021', 3, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(5, 'Activo', '005', 'E', 'Predio Taller', 'PA-005-2021', 3, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(6, 'Activo', '006', 'F', 'Predio Restaurante', 'PA-006-2021', 2, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(7, 'Anulado', '007', 'G', 'Predio Antiguo', 'PA-007-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(8, 'Activo', '008', 'H', 'Predio Farmacia', 'PA-008-2021', 2, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(9, 'Activo', '009', 'I', 'Predio Consulado', 'PA-009-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(10, 'Subdividido', '010', 'J', 'Predio Dividido', 'PA-010-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(11, 'Activo', '011', 'K', 'Predio Hotel', 'PA-011-2021', 2, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(12, 'Activo', '012', 'L', 'Predio Escuela', 'PA-012-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(13, 'Activo', '013', 'M', 'Predio Iglesia', 'PA-013-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(14, 'Activo', '014', 'N', 'Predio Clínica', 'PA-014-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1),
(15, 'Activo', '015', 'O', 'Predio Banco', 'PA-015-2021', 1, CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, 1, 1, 1)
ON CONFLICT (id) DO NOTHING;

INSERT INTO arb.arbitrio (
  id_arbitrio, id_contribuyente, id_predio, id_tipo_registro_origen, 
  anio, estado, observacion, usuario_actualizado, fecha_actualizado
) VALUES
(1, 1, 1, 1, 2024, 'activo', 'Registro inicial', 'ADMIN', CURRENT_TIMESTAMP),
(2, 1, 2, 1, 2024, 'activo', 'Predio adicional', 'ADMIN', CURRENT_TIMESTAMP),
(3, 2, 3, 2, 2024, 'activo', 'Oficina comercial', 'ADMIN', CURRENT_TIMESTAMP),
(4, 3, 4, 1, 2024, 'activo', 'Almacén municipal', 'ADMIN', CURRENT_TIMESTAMP),
(5, 5, 5, 3, 2024, 'activo', 'Taller de reparación', 'ADMIN', CURRENT_TIMESTAMP),
(6, 6, 6, 1, 2024, 'activo', 'Comercio de alimentos', 'ADMIN', CURRENT_TIMESTAMP),
(7, 1, 11, 1, 2024, 'activo', 'Hotel principal', 'ADMIN', CURRENT_TIMESTAMP),
(8, 4, 12, 2, 2024, 'activo', 'Institución educativa', 'ADMIN', CURRENT_TIMESTAMP),
(9, 7, 13, 1, 2024, 'activo', 'Organización religiosa', 'ADMIN', CURRENT_TIMESTAMP),
(10, 8, 14, 1, 2024, 'activo', 'Centro de salud', 'ADMIN', CURRENT_TIMESTAMP)
ON CONFLICT (id_arbitrio) DO NOTHING;