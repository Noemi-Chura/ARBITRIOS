INSERT INTO arb.tipo_registro_origen (id_tipo_registro_origen, denominacion, abreviatura, usuario_actualizado, fecha_actualizado, atributo_actualizado) VALUES
(1, 'Registro de Propiedad', 'RP', 'ADMIN', CURRENT_TIMESTAMP, 'created'),
(2, 'Declaración de Impuesto Predial', 'DIP', 'ADMIN', CURRENT_TIMESTAMP, 'created'),
(3, 'Licencia de Funcionamiento', 'LF', 'ADMIN', CURRENT_TIMESTAMP, 'created'),
(4, 'Autorización Municipal', 'AM', 'ADMIN', CURRENT_TIMESTAMP, 'created'),
(5, 'Levantamiento Catastral', 'LC', 'ADMIN', CURRENT_TIMESTAMP, 'created')
ON CONFLICT DO NOTHING;
