<?php
require_once(__DIR__ . "/../models/Database.php");

class ArbitriosController {

    private $modelo;

    public function __construct() {
        $this->modelo = new Modelo();
    }

    public function index() {
        $id = $_GET['id'] ?? null;

        if (!$id) {
            die('<main><h3>Error: falta el id del contribuyente.</h3></main>');
        }

        $dato = $this->modelo->mostrarUno("gen.gen_contribuyente", "id='" . addslashes($id) . "'");

        if (!$dato) {
            die('<main><h3>Error: contribuyente no encontrado.</h3></main>');
        }

        // Consultar predios ya registrados en arbitrios para este contribuyente
        $predios = $this->modelo->consultaPersonalizada(
            "SELECT DISTINCT p.id, p.estado, 
                    SUBSTRING(p.codigo_catastral, 10) as codigo_catastral,
                    COALESCE(v.nombre, '') || ' ' || COALESCE(p.numero, '') || ' ' || COALESCE(p.letra, '') as direccion,
                    a.id_tipo_registro_origen, t.denominacion as referencia_origen,
                    a.usuario_actualizado, 
                    TO_CHAR(a.fecha_actualizado, 'YYYY-MM-DD HH24:MI:SS') as fecha_actualizado,
                    CAST(a.fecha_actualizado AS DATE) as f_control,
                    TO_CHAR(a.fecha_actualizado, 'HH24:MI:SS') as h_control
            FROM gen.gen_predio p
            INNER JOIN arb.arbitrio a ON a.id_predio = p.id
            LEFT JOIN arb.tipo_registro_origen t ON t.id_tipo_registro_origen = a.id_tipo_registro_origen
            LEFT JOIN gen.gen_via v ON v.id = p.id_via
            WHERE a.id_contribuyente = '" . addslashes($id) . "'
            ORDER BY p.id DESC LIMIT 20"
        );

        $referencias = $this->modelo->mostrar("arb.tipo_registro_origen");
        $estados = ['activo', 'anulado', 'Subdividido'];
        
        // Obtener categorías para los tributos
        $categorias_limpieza = $this->modelo->mostrar("arb.tipo_beneficio", "id_tributo = 1");
        $categorias_parques = $this->modelo->mostrar("arb.tipo_beneficio", "id_tributo = 2");
        $categorias_residuos = $this->modelo->mostrar("arb.tipo_beneficio", "id_tributo = 3");
        $categorias_serenazgo = $this->modelo->mostrar("arb.tipo_beneficio", "id_tributo = 4");
        
        // Obtener tributos
        $tributos = $this->modelo->mostrar("arb.tributo");
        
        // Obtener tipos de exoneración
        $exoneraciones = $this->modelo->mostrar("arb.tipo_beneficio", "abreviatura ILIKE '%exonerado%'");
        
        require_once(__DIR__ . "/../views/arbitrios/index.php");
    }

    // En src/controllers/arbitrios.php, agrega este método:

        public function eliminarPredio() {
            error_log("=== ELIMINAR PREDIO INICIADO ===");
            
            $idPredio = $_GET['id_predio'] ?? null;
            $idContribuyente = $_GET['id_contribuyente'] ?? null;
            
            error_log("ID Predio: " . $idPredio);
            error_log("ID Contribuyente: " . $idContribuyente);
            
            if (!$idPredio || !$idContribuyente) {
                error_log("ERROR: Faltan parámetros");
                echo json_encode(['error' => 'Falta ID del predio o contribuyente']);
                exit;
            }
            
            try {
                error_log("Conectando a la base de datos...");
                
                // Primero verificar si existe
                $sqlCheck = "SELECT COUNT(*) as existe FROM arb.arbitrio 
                            WHERE id_predio = :id_predio
                            AND id_contribuyente = :id_contribuyente";
                
                error_log("Ejecutando consulta de verificación...");
                $existe = $this->modelo->query($sqlCheck, [
                    'id_predio' => $idPredio,
                    'id_contribuyente' => $idContribuyente
                ]);
                
                error_log("Resultado verificación: " . print_r($existe, true));
                
                if ($existe[0]['existe'] == 0) {
                    error_log("ERROR: No existe el registro");
                    echo json_encode(['error' => 'El predio no está registrado en arbitrios']);
                    exit;
                }
                
                // Primero eliminar los detalles de arbitrio (si existen)
                error_log("Eliminando detalles de arbitrio...");
                $sqlDeleteDetalles = "DELETE FROM arb.arbitrio_detalle ad
                                    USING arb.arbitrio a 
                                    WHERE ad.id_arbitrio = a.id_arbitrio
                                    AND a.id_predio = :id_predio
                                    AND a.id_contribuyente = :id_contribuyente";
                
                $detallesEliminados = $this->modelo->query($sqlDeleteDetalles, [
                    'id_predio' => $idPredio,
                    'id_contribuyente' => $idContribuyente
                ]);
                
                error_log("Detalles eliminados correctamente");
                
                // Luego eliminar el arbitrio
                error_log("Eliminando arbitrio...");
                $sqlDeleteArbitrio = "DELETE FROM arb.arbitrio 
                                    WHERE id_predio = :id_predio
                                    AND id_contribuyente = :id_contribuyente
                                    RETURNING id_arbitrio";
                
                $resultado = $this->modelo->query($sqlDeleteArbitrio, [
                    'id_predio' => $idPredio,
                    'id_contribuyente' => $idContribuyente
                ]);
                
                error_log("Resultado eliminación: " . print_r($resultado, true));
                
                echo json_encode([
                    'success' => true,
                    'message' => 'Predio eliminado correctamente de arbitrios',
                    'id_eliminado' => $resultado[0]['id_arbitrio'] ?? null
                ]);
                
            } catch (Exception $e) {
                error_log("EXCEPCIÓN: " . $e->getMessage());
                error_log("Traza: " . $e->getTraceAsString());
                echo json_encode(['error' => 'Error al eliminar: ' . $e->getMessage()]);
            }
            
            exit;
        }

    // ============ MÉTODOS PARA CATEGORIZACIÓN POR AÑOS ============
    
    // Obtener categorizaciones por año para un predio
// En el método getCategorizacionesPredio, modificar la consulta para usar 1/0
// En el archivo arbitrios.php, dentro de la clase Arbitrios (o el nombre de tu clase)

public function getCategorizacionesPredio() {
    // 1. Obtener parámetros de la URL
    $idPredio = $_GET['id_predio'] ?? null;
    $idContribuyente = $_GET['id_contribuyente'] ?? null;

    if (!$idPredio || !$idContribuyente) {
        // Enviar un mensaje de error si faltan parámetros
        echo json_encode(['success' => false, 'error' => 'Parámetros incompletos (id_predio o id_contribuyente)']);
        exit;
    }

    // 2. Definir la consulta SQL con múltiples LEFT JOINs
    // Nota: Usamos '::int' para convertir el booleano de PostgreSQL (true/false) a entero (1/0)
    // y COALESCE para manejar los valores NULL de las exoneraciones (asignando 'Afecto al arbitrio').
    $sql = "
        SELECT
            ad.id_arbitrio_detalle,
            ad.anio,
            ad.item,
            -- Meses (Convertir booleanos a enteros 1/0)
            ad.enero::int AS enero, ad.febrero::int AS febrero, ad.marzo::int AS marzo,
            ad.abril::int AS abril, ad.mayo::int AS mayo, ad.junio::int AS junio,
            ad.julio::int AS julio, ad.agosto::int AS agosto, ad.septiembre::int AS septiembre,
            ad.octubre::int AS octubre, ad.noviembre::int AS noviembre, ad.diciembre::int AS diciembre,
            
            -- Categorías (Se unen 4 veces a la tabla arb.tipo_beneficio)
            COALESCE(tlp.denominacion, 'N/A') AS categoria_limpieza,
            COALESCE(tpj.denominacion, 'N/A') AS categoria_parques,
            COALESCE(trs.denominacion, 'N/A') AS categoria_residuos,
            COALESCE(tsr.denominacion, 'N/A') AS categoria_serenazgo,
            
            -- Exoneraciones (Se unen 4 veces más, si es NULL (no tiene), mostramos 'Afecto al arbitrio')
            COALESCE(elp.denominacion, 'Afecto al arbitrio') AS exoneracion_limpieza,
            COALESCE(epj.denominacion, 'Afecto al arbitrio') AS exoneracion_parques,
            COALESCE(ers.denominacion, 'Afecto al arbitrio') AS exoneracion_residuos,
            COALESCE(esr.denominacion, 'Afecto al arbitrio') AS exoneracion_serenazgo,
            
            -- Montos y Auditoría
            ad.monto_base,
            ad.interes,
            ad.mora,
            ad.monto_final,
            ad.usuario_actualizado,
            TO_CHAR(ad.fecha_actualizado, 'YYYY-MM-DD HH24:MI') AS fecha_actualizado
        FROM
            arb.arbitrio_detalle ad
        INNER JOIN
            arb.arbitrio a ON ad.id_arbitrio = a.id_arbitrio
        
        -- JOINS para CATEGORÍAS
        LEFT JOIN arb.tipo_beneficio tlp ON ad.id_tipo_beneficio_limpieza_publica = tlp.id_tipo_beneficio
        LEFT JOIN arb.tipo_beneficio tpj ON ad.id_tipo_beneficio_parques_jardines = tpj.id_tipo_beneficio
        LEFT JOIN arb.tipo_beneficio trs ON ad.id_tipo_beneficio_relleno_sanitario = trs.id_tipo_beneficio
        LEFT JOIN arb.tipo_beneficio tsr ON ad.id_tipo_beneficio_serenazgo = tsr.id_tipo_beneficio
        
        -- JOINS para EXONERACIONES
        LEFT JOIN arb.tipo_beneficio elp ON ad.id_exoneracion_limpieza_publica = elp.id_tipo_beneficio
        LEFT JOIN arb.tipo_beneficio epj ON ad.id_exoneracion_parques_jardines = epj.id_tipo_beneficio
        LEFT JOIN arb.tipo_beneficio ers ON ad.id_exoneracion_relleno_sanitario = ers.id_tipo_beneficio
        LEFT JOIN arb.tipo_beneficio esr ON ad.id_exoneracion_serenazgo = esr.id_tipo_beneficio
        
        WHERE
            a.id_predio = :id_predio AND a.id_contribuyente = :id_contribuyente
        ORDER BY
            ad.anio DESC, ad.item DESC;
    ";

    // 3. Ejecutar la consulta
    try {
        $params = [
            ':id_predio' => $idPredio,
            ':id_contribuyente' => $idContribuyente
        ];
        
        // Asumiendo que $this->modelo->query ejecuta la consulta y devuelve un array de resultados
        $data = $this->modelo->query($sql, $params);

        // Si se encontraron datos o si el array está vacío (pero la consulta fue exitosa)
        echo json_encode(['success' => true, 'data' => $data]);

    } catch (Exception $e) {
        // En caso de un error de conexión o sintaxis SQL
        error_log('[ARBITRIOS] Error SQL al cargar categorizaciones: ' . $e->getMessage());
        echo json_encode(['success' => false, 'error' => 'Error de Base de Datos: ' . $e->getMessage()]);
    }
    exit;
}
    
    // Crear nueva categorización
// Crear nueva categorización - CORREGIDO
// En arbitrios.php - método crearCategorizacion
// En el método crearCategorizacion() - VERSIÓN CORREGIDA
public function crearCategorizacion() {
    $data = json_decode(file_get_contents('php://input'), true);
    
    // DEPURACIÓN DETALLADA
    error_log('==========================================');
    error_log('[ARBITRIOS] CREAR CATEGORIZACIÓN - DATOS RAW: ' . file_get_contents('php://input'));
    error_log('[ARBITRIOS] Datos decodificados:');
    error_log(print_r($data, true));
    
    $required = ['id_contribuyente', 'id_predio', 'anio', 'item'];
    foreach ($required as $field) {
        if (empty($data[$field])) {
            echo json_encode(['error' => "Campo requerido: {$field}"]);
            exit;
        }
    }
    
    try {
        // Convertir IDs a enteros
        $idContribuyente = (int)$data['id_contribuyente'];
        $idPredio = (int)$data['id_predio'];
        $anio = (int)$data['anio'];
        
        // Buscar si ya existe un arbitrio para este contribuyente y predio
        $sqlArbitrio = "SELECT id_arbitrio FROM arb.arbitrio 
                       WHERE id_contribuyente = :id_contribuyente 
                       AND id_predio = :id_predio
                       LIMIT 1";
        
        $arbitrio = $this->modelo->query($sqlArbitrio, [
            'id_contribuyente' => $idContribuyente,
            'id_predio' => $idPredio
        ]);
        
        $idArbitrio = null;
        
        if (!empty($arbitrio)) {
            // Usar el arbitrio existente
            $idArbitrio = (int)$arbitrio[0]['id_arbitrio'];
            error_log('[ARBITRIOS] Usando arbitrio existente ID: ' . $idArbitrio);
        } else {
            // Crear nuevo arbitrio
            error_log('[ARBITRIOS] Creando nuevo arbitrio para contribuyente ' . $idContribuyente . ' y predio ' . $idPredio);
            
            // Obtener el próximo ID de arbitrio
            $sqlMaxId = "SELECT COALESCE(MAX(id_arbitrio), 0) as max_id FROM arb.arbitrio";
            $result = $this->modelo->consultaPersonalizada($sqlMaxId);
            $nextIdArbitrio = (int)$result[0]['max_id'] + 1;
            
            error_log('[ARBITRIOS] Nuevo ID arbitrio: ' . $nextIdArbitrio);
            
            // Crear el arbitrio (registro padre)
            $sqlInsertArbitrio = "INSERT INTO arb.arbitrio (
                id_arbitrio, id_contribuyente, id_predio, id_tipo_registro_origen, 
                anio, estado, observacion, usuario_actualizado, fecha_actualizado
            ) VALUES (
                :id_arbitrio, :id_contribuyente, :id_predio, 1, 
                :anio, 'activo', 'Creado automáticamente desde categorización', 'SISTEMA', CURRENT_TIMESTAMP
            )";
            
            $this->modelo->query($sqlInsertArbitrio, [
                'id_arbitrio' => $nextIdArbitrio,
                'id_contribuyente' => $idContribuyente,
                'id_predio' => $idPredio,
                'anio' => $anio
            ]);
            
            $idArbitrio = $nextIdArbitrio;
            error_log('[ARBITRIOS] Arbitrio creado con ID: ' . $idArbitrio);
        }
        
        // Ahora crear el detalle de arbitrio
        $sqlMaxDetalle = "SELECT COALESCE(MAX(id_arbitrio_detalle), 0) as max_id FROM arb.arbitrio_detalle";
        $resultDetalle = $this->modelo->consultaPersonalizada($sqlMaxDetalle);
        $nextIdDetalle = (int)$resultDetalle[0]['max_id'] + 1;
        
        error_log('[ARBITRIOS] Creando detalle con ID: ' . $nextIdDetalle . ' para arbitrio: ' . $idArbitrio);
        
        // Función para manejar valores vacíos
        function parseValue($value) {
            if ($value === '' || $value === null || $value === 'null') {
                return null;
            }
            return (int)$value;
        }
        
        // Preparar valores de categoría y exoneración
        $id_limpieza = parseValue($data['id_tipo_beneficio_limpieza_publica'] ?? '');
        $id_parques = parseValue($data['id_tipo_beneficio_parques_jardines'] ?? '');
        $id_residuos = parseValue($data['id_tipo_beneficio_relleno_sanitario'] ?? '');
        $id_serenazgo = parseValue($data['id_tipo_beneficio_serenazgo'] ?? '');
        
        $ex_limpieza = parseValue($data['exoneracion_limpieza_publica'] ?? '');
        $ex_parques = parseValue($data['exoneracion_parques_jardines'] ?? '');
        $ex_residuos = parseValue($data['exoneracion_relleno_sanitario'] ?? '');
        $ex_serenazgo = parseValue($data['exoneracion_serenazgo'] ?? '');
        
        error_log('[ARBITRIOS] Valores procesados:');
        error_log('  Categoría Limpieza: ' . ($id_limpieza ?? 'NULL'));
        error_log('  Categoría Parques: ' . ($id_parques ?? 'NULL'));
        error_log('  Categoría Residuos: ' . ($id_residuos ?? 'NULL'));
        error_log('  Categoría Serenazgo: ' . ($id_serenazgo ?? 'NULL'));
        error_log('  Exoneración Limpieza: ' . ($ex_limpieza ?? 'NULL'));
        error_log('  Exoneración Parques: ' . ($ex_parques ?? 'NULL'));
        error_log('  Exoneración Residuos: ' . ($ex_residuos ?? 'NULL'));
        error_log('  Exoneración Serenazgo: ' . ($ex_serenazgo ?? 'NULL'));
        
        $sqlInsert = "INSERT INTO arb.arbitrio_detalle (
            id_arbitrio_detalle, id_arbitrio, 
            id_tipo_beneficio_limpieza_publica,
            id_tipo_beneficio_parques_jardines,
            id_tipo_beneficio_relleno_sanitario,
            id_tipo_beneficio_serenazgo,
            id_exoneracion_limpieza_publica,
            id_exoneracion_parques_jardines,
            id_exoneracion_relleno_sanitario,
            id_exoneracion_serenazgo,
            frentera_metros, frecuencia_barrido, nro_habitantes,
            area_construida, area_terreno, tiene_licencia,
            porcentaje_inseguridad, distancia_a_parque,
            enero, febrero, marzo, abril, mayo, junio, julio, agosto,
            septiembre, octubre, noviembre, diciembre,
            anio, item, usuario_actualizado, fecha_actualizado
        ) VALUES (
            :id_detalle, :id_arbitrio,
            :id_limpieza, :id_parques, :id_residuos, :id_serenazgo,
            :ex_limpieza, :ex_parques, :ex_residuos, :ex_serenazgo,
            :frentera, :frecuencia, :habitantes,
            :area_construida, :area_terreno, :tiene_licencia,
            :inseguridad, :distancia_parque,
            :enero, :febrero, :marzo, :abril, :mayo, :junio, :julio, :agosto,
            :septiembre, :octubre, :noviembre, :diciembre,
            :anio, :item, 'SISTEMA', CURRENT_TIMESTAMP
        )";
        
        $params = [
            'id_detalle' => $nextIdDetalle,
            'id_arbitrio' => $idArbitrio,
            // Categorías
            'id_limpieza' => $id_limpieza,
            'id_parques' => $id_parques,
            'id_residuos' => $id_residuos,
            'id_serenazgo' => $id_serenazgo,
            // Exoneraciones
            'ex_limpieza' => $ex_limpieza,
            'ex_parques' => $ex_parques,
            'ex_residuos' => $ex_residuos,
            'ex_serenazgo' => $ex_serenazgo,
            // Otros campos
            'frentera' => (float)($data['frentera_metros'] ?? 0),
            'frecuencia' => (int)($data['frecuencia_barrido'] ?? 1),
            'habitantes' => (int)($data['nro_habitantes'] ?? 1),
            'area_construida' => (float)($data['area_construida'] ?? 0),
            'area_terreno' => (float)($data['area_terreno'] ?? 0),
            'tiene_licencia' => (int)($data['tiene_licencia'] ?? 0),
            'inseguridad' => (float)($data['porcentaje_inseguridad'] ?? 0),
            'distancia_parque' => (float)($data['distancia_a_parque'] ?? 1000),
            'enero' => (int)($data['enero'] ?? 0),
            'febrero' => (int)($data['febrero'] ?? 0),
            'marzo' => (int)($data['marzo'] ?? 0),
            'abril' => (int)($data['abril'] ?? 0),
            'mayo' => (int)($data['mayo'] ?? 0),
            'junio' => (int)($data['junio'] ?? 0),
            'julio' => (int)($data['julio'] ?? 0),
            'agosto' => (int)($data['agosto'] ?? 0),
            'septiembre' => (int)($data['septiembre'] ?? 0),
            'octubre' => (int)($data['octubre'] ?? 0),
            'noviembre' => (int)($data['noviembre'] ?? 0),
            'diciembre' => (int)($data['diciembre'] ?? 0),
            'anio' => $anio,
            'item' => (int)$data['item']
        ];
        
        error_log('[ARBITRIOS] Parámetros finales para inserción: ' . print_r($params, true));
        
        $this->modelo->query($sqlInsert, $params);
        
        // Verificar qué se insertó
        $sqlVerify = "SELECT 
            id_tipo_beneficio_limpieza_publica,
            id_tipo_beneficio_parques_jardines,
            id_tipo_beneficio_relleno_sanitario,
            id_tipo_beneficio_serenazgo,
            id_exoneracion_limpieza_publica,
            id_exoneracion_parques_jardines,
            id_exoneracion_relleno_sanitario,
            id_exoneracion_serenazgo
        FROM arb.arbitrio_detalle 
        WHERE id_arbitrio_detalle = :id_detalle";
        
        $verification = $this->modelo->query($sqlVerify, ['id_detalle' => $nextIdDetalle]);
        error_log('[ARBITRIOS] Verificación de inserción: ' . print_r($verification, true));
        
        echo json_encode([
            'success' => true,
            'message' => 'Categorización creada correctamente',
            'id_arbitrio_detalle' => $nextIdDetalle,
            'id_arbitrio' => $idArbitrio,
            'verification' => $verification
        ]);
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] ERROR completo: ' . $e->getMessage());
        error_log('[ARBITRIOS] Traza: ' . $e->getTraceAsString());
        echo json_encode(['error' => 'Error en la base de datos: ' . $e->getMessage()]);
    }
    
    exit;
}
    
    // Clonar categorización existente
// En el método clonarCategorizacion()
public function clonarCategorizacion() {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $idDetalle = $data['id_arbitrio_detalle'] ?? null;
    $nuevoAnio = $data['nuevo_anio'] ?? null;
    $nuevoItem = $data['nuevo_item'] ?? null;
    
    if (!$idDetalle || !$nuevoAnio || !$nuevoItem) {
        echo json_encode(['error' => 'Datos incompletos']);
        exit;
    }
    
    try {
        // Obtener datos de la categorización original
        $sqlOriginal = "SELECT ad.*, a.id_contribuyente, a.id_predio 
                       FROM arb.arbitrio_detalle ad
                       INNER JOIN arb.arbitrio a ON a.id_arbitrio = ad.id_arbitrio
                       WHERE ad.id_arbitrio_detalle = :id_detalle";
        
        $original = $this->modelo->query($sqlOriginal, ['id_detalle' => $idDetalle]);
        
        if (empty($original)) {
            echo json_encode(['error' => 'Categorización no encontrada']);
            exit;
        }
        
        $original = $original[0];
        $idArbitrio = $original['id_arbitrio'];
        
        // Verificar que el arbitrio existe
        $sqlCheckArbitrio = "SELECT 1 FROM arb.arbitrio WHERE id_arbitrio = :id_arbitrio";
        $existeArbitrio = $this->modelo->query($sqlCheckArbitrio, ['id_arbitrio' => $idArbitrio]);
        
        if (empty($existeArbitrio)) {
            echo json_encode(['error' => 'El arbitrio padre no existe']);
            exit;
        }
        
        // ... resto del código para clonar ...
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] Error al clonar: ' . $e->getMessage());
        echo json_encode(['error' => 'Error: ' . $e->getMessage()]);
    }
    
    exit;
}
    
    // Eliminar categorización
    public function eliminarCategorizacion() {
        $idDetalle = $_GET['id_detalle'] ?? null;
        
        if (!$idDetalle) {
            echo json_encode(['error' => 'Falta ID de la categorización']);
            exit;
        }
        
        try {
            $sqlDelete = "DELETE FROM arb.arbitrio_detalle 
                         WHERE id_arbitrio_detalle = :id_detalle";
            
            $this->modelo->query($sqlDelete, ['id_detalle' => $idDetalle]);
            
            echo json_encode([
                'success' => true,
                'message' => 'Categorización eliminada correctamente'
            ]);
            
        } catch (Exception $e) {
            echo json_encode(['error' => 'Error: ' . $e->getMessage()]);
        }
        
        exit;
    }

    // ============ NUEVOS MÉTODOS PARA IMPORTACIÓN ============
    
    // Obtener licencias de funcionamiento para un contribuyente
    public function getLicencias() {
        $idContribuyente = $_GET['id'] ?? null;
        
        if (!$idContribuyente) {
            echo json_encode(['error' => 'Falta ID del contribuyente']);
            exit;
        }
        
        // CONSULTA CORREGIDA - Más simple y robusta
        $sql = "SELECT 
                    l.id_licencia as id,
                    l.nro_licencia as codigo,
                    COALESCE(
                        TRIM(
                            CONCAT(
                                COALESCE(p.nombre_predio, ''),
                                CASE 
                                    WHEN p.nombre_predio IS NOT NULL AND (v.nombre IS NOT NULL OR p.numero IS NOT NULL) THEN ' - '
                                    ELSE ''
                                END,
                                COALESCE(v.nombre, ''),
                                CASE 
                                    WHEN v.nombre IS NOT NULL AND p.numero IS NOT NULL THEN ' '
                                    ELSE ''
                                END,
                                COALESCE(p.numero, ''),
                                CASE 
                                    WHEN p.letra IS NOT NULL AND TRIM(p.letra) != '' THEN ' ' || p.letra
                                    ELSE ''
                                END
                            )
                        ),
                        'Sin dirección'
                    ) as direccion,
                    CONCAT(
                        'Licencia: ', l.nro_licencia, 
                        ' | Categoría: ', COALESCE(l.categoria_licencia, 'Sin categoría'),
                        ' | Vence: ', TO_CHAR(l.fecha_vencimiento, 'DD/MM/YYYY')
                    ) as adicional,
                    l.id_predio
                FROM arb.licencia_funcionamiento l
                LEFT JOIN gen.gen_predio p ON p.id = l.id_predio
                LEFT JOIN gen.gen_via v ON v.id = p.id_via
                WHERE l.id_contribuyente = :id_contribuyente
                AND l.estado = 'activo'
                ORDER BY l.fecha_emision DESC";
        
        // DEBUG: Ver la consulta
        error_log("Consulta licencias SQL: " . $sql);
        error_log("ID contribuyente: " . $idContribuyente);
        
        try {
            $licencias = $this->modelo->query($sql, ['id_contribuyente' => $idContribuyente]);
            
            error_log("Licencias encontradas: " . count($licencias));
            if (count($licencias) > 0) {
                error_log("Primera licencia: " . print_r($licencias[0], true));
            }
            
            header('Content-Type: application/json');
            echo json_encode([
                'success' => true, 
                'data' => $licencias,
                'debug' => [
                    'total' => count($licencias),
                    'contribuyente' => $idContribuyente
                ]
            ]);
            
        } catch (Exception $e) {
            error_log("ERROR en getLicencias: " . $e->getMessage());
            echo json_encode([
                'success' => false, 
                'error' => 'Error en consulta: ' . $e->getMessage()
            ]);
        }
        
        exit;
    }

    // Obtener declaraciones juradas para un contribuyente
    public function getDeclaraciones() {
        $idContribuyente = $_GET['id'] ?? null;
        
        if (!$idContribuyente) {
            echo json_encode(['error' => 'Falta ID del contribuyente']);
            exit;
        }
        
        // CONSULTA CORREGIDA
        $sql = "SELECT 
                    d.id_declaracion_jurada as id,
                    CONCAT('DDJJ-', d.anio, '-', LPAD(d.id_declaracion_jurada::text, 3, '0')) as codigo,
                    COALESCE(
                        TRIM(
                            CONCAT(
                                COALESCE(p.nombre_predio, ''),
                                CASE 
                                    WHEN p.nombre_predio IS NOT NULL AND (v.nombre IS NOT NULL OR p.numero IS NOT NULL) THEN ' - '
                                    ELSE ''
                                END,
                                COALESCE(v.nombre, ''),
                                CASE 
                                    WHEN v.nombre IS NOT NULL AND p.numero IS NOT NULL THEN ' '
                                    ELSE ''
                                END,
                                COALESCE(p.numero, ''),
                                CASE 
                                    WHEN p.letra IS NOT NULL AND TRIM(p.letra) != '' THEN ' ' || p.letra
                                    ELSE ''
                                END
                            )
                        ),
                        'Sin dirección'
                    ) as direccion,
                    CONCAT('Año: ', d.anio, ' | Predio ID: ', p.id) as adicional,
                    d.id_predio
                FROM arb.declaracion_jurada d
                LEFT JOIN gen.gen_predio p ON p.id = d.id_predio
                LEFT JOIN gen.gen_via v ON v.id = p.id_via
                WHERE d.id_contribuyente = :id_contribuyente
                ORDER BY d.anio DESC, d.id_declaracion_jurada DESC";
        
        error_log("Consulta DDJJ SQL: " . $sql);
        error_log("ID contribuyente: " . $idContribuyente);
        
        try {
            $declaraciones = $this->modelo->query($sql, ['id_contribuyente' => $idContribuyente]);
            
            error_log("Declaraciones encontradas: " . count($declaraciones));
            if (count($declaraciones) > 0) {
                error_log("Primera declaración: " . print_r($declaraciones[0], true));
            }
            
            header('Content-Type: application/json');
            echo json_encode([
                'success' => true, 
                'data' => $declaraciones,
                'debug' => [
                    'total' => count($declaraciones),
                    'contribuyente' => $idContribuyente
                ]
            ]);
            
        } catch (Exception $e) {
            error_log("ERROR en getDeclaraciones: " . $e->getMessage());
            echo json_encode([
                'success' => false, 
                'error' => 'Error en consulta: ' . $e->getMessage()
            ]);
        }
        
        exit;
    }

    // Importar predios seleccionados a arbitrios
public function importarPredios() {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $idContribuyente = $data['id_contribuyente'] ?? null;
    $predios = $data['predios'] ?? [];
    $tipoFuente = $data['tipo_fuente'] ?? '';
    
    if (!$idContribuyente || empty($predios)) {
        echo json_encode(['error' => 'Datos incompletos']);
        exit;
    }
    
    try {
        $importados = 0;
        $noImportados = 0;
        $errors = [];
        $detalles = [];
        
        foreach ($predios as $predio) {
            $idPredio = $predio['id_predio'];
            $codigoPredio = $predio['codigo'] ?? 'N/A';
            
            // Verificar si el predio ya existe en arbitrios para este contribuyente
            $sqlCheck = "SELECT COUNT(*) as existe, 
                                id_arbitrio,
                                id_tipo_registro_origen,
                                estado
                         FROM arb.arbitrio 
                         WHERE id_contribuyente = :id_contribuyente 
                         AND id_predio = :id_predio
                         GROUP BY id_arbitrio, id_tipo_registro_origen, estado";
            
            $existe = $this->modelo->query($sqlCheck, [
                'id_contribuyente' => $idContribuyente,
                'id_predio' => $idPredio
            ]);
            
            if (!empty($existe) && $existe[0]['existe'] > 0) {
                $noImportados++;
                $detalles[] = "❌ Predio <strong>{$codigoPredio}</strong> ya está registrado en arbitrios (Origen: " . $this->getTipoOrigen($existe[0]['id_tipo_registro_origen']) . ")";
                continue;
            }
            
            // Determinar el tipo_registro_origen según la fuente
            $idTipoRegistro = 1; // Por defecto: Registro de Propiedad
            if ($tipoFuente === 'licencias') {
                $idTipoRegistro = 3; // Licencia de Funcionamiento
            } elseif ($tipoFuente === 'declaraciones') {
                $idTipoRegistro = 2; // Declaración de Impuesto Predial
            }
            
            // Obtener el próximo ID de arbitrio
            $nextId = $this->modelo->consultaPersonalizada(
                "SELECT COALESCE(MAX(id_arbitrio), 0) + 1 as next_id FROM arb.arbitrio"
            )[0]['next_id'];
            
            // Insertar nuevo registro en arbitrios
            $sqlInsert = "INSERT INTO arb.arbitrio 
                        (id_arbitrio, id_contribuyente, id_predio, id_tipo_registro_origen, 
                         anio, estado, observacion, usuario_actualizado, fecha_actualizado)
                        VALUES (:id_arbitrio, :id_contribuyente, :id_predio, :id_tipo_registro_origen, 
                                :anio, 'activo', :observacion, :usuario, CURRENT_TIMESTAMP)";
            
            $observacion = "Importado desde " . ($tipoFuente === 'licencias' ? 'Licencia de Funcionamiento' : 'Declaración Jurada');
            
            $this->modelo->query($sqlInsert, [
                'id_arbitrio' => $nextId,
                'id_contribuyente' => $idContribuyente,
                'id_predio' => $idPredio,
                'id_tipo_registro_origen' => $idTipoRegistro,
                'anio' => date('Y'),
                'observacion' => $observacion,
                'usuario' => 'SISTEMA_IMPORTACION'
            ]);
            
            $importados++;
            $detalles[] = "✅ Predio <strong>{$codigoPredio}</strong> importado correctamente";
        }
        
        $message = "";
        if ($importados > 0) {
            $message .= "Se importaron <strong>{$importados}</strong> predios correctamente. ";
        }
        if ($noImportados > 0) {
            $message .= "<strong>{$noImportados}</strong> predios ya estaban registrados. ";
        }
        
        echo json_encode([
            'success' => true,
            'message' => $message,
            'importados' => $importados,
            'no_importados' => $noImportados,
            'total_procesados' => count($predios),
            'detalles' => $detalles,
            'errors' => $errors
        ]);
        
    } catch (Exception $e) {
        echo json_encode(['error' => 'Error al importar: ' . $e->getMessage()]);
    }
    
    exit;
}

// Método auxiliar para obtener nombre del tipo de origen
private function getTipoOrigen($idTipoRegistro) {
    $tipos = [
        1 => 'Registro de Propiedad',
        2 => 'Declaración Jurada',
        3 => 'Licencia de Funcionamiento',
        4 => 'Otro Origen'
    ];
    
    return $tipos[$idTipoRegistro] ?? 'Desconocido';
}

    // Método para buscar predios generales
    public function buscarPredios() {
        $searchTerm = $_GET['q'] ?? '';
        
        if (strlen($searchTerm) < 2) {
            echo json_encode(['success' => false, 'message' => 'Término de búsqueda muy corto']);
            exit;
        }
        
        $sql = "SELECT 
                    p.id,
                    p.codigo_catastral,
                    CONCAT(COALESCE(v.nombre, ''), ' ', COALESCE(p.numero, ''), ' ', COALESCE(p.letra, '')) as direccion,
                    p.nombre_predio,
                    p.estado
                FROM gen.gen_predio p
                LEFT JOIN gen.gen_via v ON v.id = p.id_via
                WHERE p.nombre_predio ILIKE :search 
                OR p.codigo_catastral ILIKE :search
                OR v.nombre ILIKE :search
                OR CONCAT(COALESCE(v.nombre, ''), ' ', COALESCE(p.numero, ''), ' ', COALESCE(p.letra, '')) ILIKE :search
                ORDER BY p.id DESC
                LIMIT 10";
        
        $predios = $this->modelo->query($sql, ['search' => "%{$searchTerm}%"]);
        
        header('Content-Type: application/json');
        echo json_encode(['success' => true, 'data' => $predios]);
        exit;
    }
    
    // Agregar un predio manualmente
    public function agregarPredio() {
        $data = $_POST;
        
        $required = ['id_contribuyente', 'id_predio', 'estado', 'id_tipo_registro_origen'];
        foreach ($required as $field) {
            if (empty($data[$field])) {
                echo json_encode(['error' => "Campo requerido: {$field}"]);
                exit;
            }
        }
        
        try {
            // Verificar si ya existe
            $sqlCheck = "SELECT COUNT(*) as existe FROM arb.arbitrio 
                        WHERE id_contribuyente = :id_contribuyente 
                        AND id_predio = :id_predio";
            
            $existe = $this->modelo->query($sqlCheck, [
                'id_contribuyente' => $data['id_contribuyente'],
                'id_predio' => $data['id_predio']
            ]);
            
            if ($existe[0]['existe'] > 0) {
                echo json_encode(['error' => 'Este predio ya está registrado para el contribuyente']);
                exit;
            }
            
            // Obtener próximo ID
            $nextId = $this->modelo->consultaPersonalizada(
                "SELECT COALESCE(MAX(id_arbitrio), 0) + 1 as next_id FROM arb.arbitrio"
            )[0]['next_id'];
            
            // Insertar
            $sqlInsert = "INSERT INTO arb.arbitrio 
                        (id_arbitrio, id_contribuyente, id_predio, id_tipo_registro_origen, 
                         anio, estado, usuario_actualizado, fecha_actualizado)
                        VALUES (:id_arbitrio, :id_contribuyente, :id_predio, :id_tipo_registro_origen, 
                                :anio, :estado, :usuario, CURRENT_TIMESTAMP)";
            
            $this->modelo->query($sqlInsert, [
                'id_arbitrio' => $nextId,
                'id_contribuyente' => $data['id_contribuyente'],
                'id_predio' => $data['id_predio'],
                'id_tipo_registro_origen' => $data['id_tipo_registro_origen'],
                'anio' => date('Y'),
                'estado' => $data['estado'],
                'usuario' => 'ADMIN'
            ]);
            
            echo json_encode([
                'success' => true,
                'message' => 'Predio agregado correctamente',
                'id_arbitrio' => $nextId
            ]);
            
        } catch (Exception $e) {
            echo json_encode(['error' => 'Error: ' . $e->getMessage()]);
        }
        
        exit;
    }

    // ============ MÉTODOS PARA PROCESAR CUENTA CORRIENTE ============

// Procesar cuenta corriente de predios seleccionados
// Reemplaza el método procesarCuentaCorriente con esta versión mejorada
public function procesarCuentaCorriente() {
    header('Content-Type: application/json');
    
    try {
        $input = file_get_contents('php://input');
        $data = json_decode($input, true);
        
        error_log('[ARBITRIOS] === PROCESAR CUENTA CORRIENTE - VERSIÓN CORREGIDA ===');
        error_log('[ARBITRIOS] Datos recibidos: ' . print_r($data, true));
        
        if (!$data || empty($data['predios'])) {
            echo json_encode(['error' => 'No hay predios seleccionados']);
            exit;
        }
        
        $anioDesde = (int)($data['anio_desde'] ?? date('Y'));
        $anioHasta = (int)($data['anio_hasta'] ?? date('Y'));
        
        $detalles = [];
        $totalProcesado = 0;
        $prediosConCategorizaciones = 0;
        
        foreach ($data['predios'] as $idPredio) {
            error_log('[ARBITRIOS] Procesando predio ID: ' . $idPredio);
            
            // 1. Buscar el arbitrio asociado a este predio
            $sqlArbitrio = "SELECT 
                                a.id_arbitrio,
                                a.id_contribuyente,
                                p.codigo_catastral,
                                c.nombre as nombre_contribuyente
                            FROM arb.arbitrio a
                            INNER JOIN gen.gen_predio p ON p.id = a.id_predio
                            INNER JOIN gen.gen_contribuyente c ON c.id = a.id_contribuyente
                            WHERE a.id_predio = :id_predio
                            LIMIT 1";
            
            $arbitrioInfo = $this->modelo->query($sqlArbitrio, ['id_predio' => $idPredio]);
            
            if (empty($arbitrioInfo)) {
                $detalles[] = [
                    'tributo' => 'Arbitrios',
                    'predio' => 'N/A',
                    'codigo' => 'N/A',
                    'fecha_vencimiento' => $data['fecha_vencimiento'] ?? date('Y-m-d'),
                    'monto_base' => 0,
                    'interes' => 0,
                    'mora' => 0,
                    'total' => 0,
                    'estado' => '✗ Error',
                    'mensaje' => 'Predio no registrado en arbitrios'
                ];
                continue;
            }
            
            $arbitrioInfo = $arbitrioInfo[0];
            $idArbitrio = $arbitrioInfo['id_arbitrio'];
            error_log('[ARBITRIOS] ID Arbitrio encontrado: ' . $idArbitrio);
            
            // 2. Buscar categorizaciones para este arbitrio
            $sqlCategorizaciones = "SELECT 
                                        ad.id_arbitrio_detalle,
                                        ad.anio,
                                        ad.item,
                                        ad.monto_base,
                                        ad.interes,
                                        ad.mora,
                                        ad.monto_final,
                                        ad.fecha_actualizado,
                                        TO_CHAR(ad.fecha_actualizado, 'DD/MM/YYYY HH24:MI') as fecha_formateada
                                    FROM arb.arbitrio_detalle ad
                                    WHERE ad.id_arbitrio = :id_arbitrio
                                    AND ad.anio BETWEEN :anio_desde AND :anio_hasta
                                    ORDER BY ad.anio DESC, ad.item DESC";
            
            $categorizaciones = $this->modelo->query($sqlCategorizaciones, [
                'id_arbitrio' => $idArbitrio,
                'anio_desde' => $anioDesde,
                'anio_hasta' => $anioHasta
            ]);
            
            error_log('[ARBITRIOS] Categorizaciones encontradas para arbitrio ' . $idArbitrio . ': ' . count($categorizaciones));
            
            if (empty($categorizaciones)) {
                $detalles[] = [
                    'tributo' => 'Arbitrios',
                    'predio' => $arbitrioInfo['codigo_catastral'],
                    'codigo' => 'ARB-' . $arbitrioInfo['codigo_catastral'],
                    'fecha_vencimiento' => $data['fecha_vencimiento'] ?? date('Y-m-d'),
                    'monto_base' => 0,
                    'interes' => 0,
                    'mora' => 0,
                    'total' => 0,
                    'estado' => '✗ Error',
                    'mensaje' => 'No hay categorizaciones para el período ' . $anioDesde . '-' . $anioHasta
                ];
                continue;
            }
            
            // 3. Procesar cada categorización
            foreach ($categorizaciones as $cat) {
                error_log('[ARBITRIOS] Procesando categorización ID: ' . $cat['id_arbitrio_detalle'] . 
                         ' - Monto base: ' . $cat['monto_base']);
                
                // Intentar actualizar cálculo
                $montoActualizado = null;
                
                try {
                    // Intentar con función PostgreSQL
                    $sqlActualizar = "SELECT arb.fn_actualizar_mora_interes(:id_detalle)";
                    $this->modelo->query($sqlActualizar, ['id_detalle' => $cat['id_arbitrio_detalle']]);
                    
                    // Obtener datos actualizados
                    $sqlActualizado = "SELECT 
                                        monto_base, 
                                        interes, 
                                        mora, 
                                        monto_final,
                                        TO_CHAR(fecha_actualizado, 'DD/MM/YYYY HH24:MI') as fecha_formateada
                                      FROM arb.arbitrio_detalle 
                                      WHERE id_arbitrio_detalle = :id_detalle";
                    
                    $actualizado = $this->modelo->query($sqlActualizado, [
                        'id_detalle' => $cat['id_arbitrio_detalle']
                    ]);
                    
                    if (!empty($actualizado)) {
                        $montoActualizado = $actualizado[0];
                    }
                    
                } catch (Exception $e) {
                    error_log('[ARBITRIOS] Error al usar función: ' . $e->getMessage());
                    // Si falla, usar los datos existentes
                    $montoActualizado = [
                        'monto_base' => $cat['monto_base'],
                        'interes' => $cat['interes'],
                        'mora' => $cat['mora'],
                        'monto_final' => $cat['monto_final'],
                        'fecha_formateada' => $cat['fecha_formateada']
                    ];
                }
                
                if ($montoActualizado) {
                    $detalle = [
                        'tributo' => 'Arbitrios',
                        'predio' => $arbitrioInfo['codigo_catastral'],
                        'codigo' => 'ARB-' . $arbitrioInfo['codigo_catastral'] . '-' . $cat['anio'] . '-' . $cat['item'],
                        'fecha_vencimiento' => $data['fecha_vencimiento'] ?? date('Y-m-d', strtotime('+30 days')),
                        'monto_base' => (float)$montoActualizado['monto_base'],
                        'interes' => (float)$montoActualizado['interes'],
                        'mora' => (float)$montoActualizado['mora'],
                        'total' => (float)$montoActualizado['monto_final'],
                        'estado' => '✓ Procesado',
                        'mensaje' => 'Cálculo actualizado',
                        'anio' => $cat['anio'],
                        'item' => $cat['item'],
                        'contribuyente' => $arbitrioInfo['nombre_contribuyente'],
                        'fecha_actualizacion' => $montoActualizado['fecha_formateada']
                    ];
                    
                    $detalles[] = $detalle;
                    $totalProcesado += (float)$montoActualizado['monto_final'];
                    $prediosConCategorizaciones++;
                    
                    error_log('[ARBITRIOS] Procesado: ' . json_encode($detalle));
                }
            }
        }
        
        // 4. Preparar respuesta
        $resultado = [
            'success' => true,
            'message' => 'Proceso completado',
            'total_procesado' => $totalProcesado,
            'total_registros' => count($detalles),
            'predios_con_categorizaciones' => $prediosConCategorizaciones,
            'detalles' => $detalles
        ];
        
        // Estadísticas
        $procesados = array_filter($detalles, function($d) { 
            return strpos($d['estado'], '✓') !== false; 
        });
        $errores = array_filter($detalles, function($d) { 
            return strpos($d['estado'], '✗') !== false; 
        });
        
        $resultado['estadisticas'] = [
            'procesados' => count($procesados),
            'errores' => count($errores),
            'total_predios' => count($data['predios'])
        ];
        
        error_log('[ARBITRIOS] Resultado final: Procesados=' . count($procesados) . 
                 ', Errores=' . count($errores) . 
                 ', Total=' . $totalProcesado);
        
        echo json_encode($resultado);
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] Error general: ' . $e->getMessage());
        error_log('[ARBITRIOS] Traza: ' . $e->getTraceAsString());
        echo json_encode([
            'success' => false,
            'error' => 'Error del sistema: ' . $e->getMessage()
        ]);
    }
    
    exit;
}

private function calcularMoraInteresManual($idDetalle) {
    try {
        error_log('[ARBITRIOS] Calculando mora/interés manualmente para ID: ' . $idDetalle);
        
        // Primero obtener los datos actuales con más información
        $sqlDatos = "SELECT 
                        monto_base,
                        interes,
                        mora,
                        monto_final,
                        fecha_actualizado,
                        EXTRACT(DAY FROM (CURRENT_DATE - fecha_actualizado)) as dias_transcurridos
                     FROM arb.arbitrio_detalle 
                     WHERE id_arbitrio_detalle = :id_detalle";
        
        $datos = $this->modelo->query($sqlDatos, ['id_detalle' => $idDetalle]);
        
        if (empty($datos)) {
            error_log('[ARBITRIOS] No se encontró detalle para cálculo manual');
            return false;
        }
        
        $datos = $datos[0];
        $montoBase = (float)$datos['monto_base'];
        $dias = max(0, (int)$datos['dias_transcurridos']); // No negativo
        
        // Si no han pasado días, no hay cambios
        if ($dias === 0) {
            error_log('[ARBITRIOS] No han pasado días desde la última actualización');
            return true;
        }
        
        // Usar las mismas tasas que la función PostgreSQL
        $tasaInteres = 0.0005; // 0.05% diario
        $tasaMora = 0.0003;    // 0.03% diario
        
        $interes = $montoBase * $tasaInteres * $dias;
        $mora = $montoBase * $tasaMora * $dias;
        $total = $montoBase + $interes + $mora;
        
        error_log('[ARBITRIOS] Cálculo manual - ' .
                 'Base: ' . $montoBase . ', ' .
                 'Días: ' . $dias . ', ' .
                 'Interés (' . ($tasaInteres * 100) . '%): ' . $interes . ', ' .
                 'Mora (' . ($tasaMora * 100) . '%): ' . $mora . ', ' .
                 'Total: ' . $total);
        
        // Actualizar
        $sqlUpdate = "UPDATE arb.arbitrio_detalle 
                     SET interes = :interes,
                         mora = :mora,
                         monto_final = :total,
                         fecha_actualizado = CURRENT_TIMESTAMP
                     WHERE id_arbitrio_detalle = :id_detalle
                     RETURNING id_arbitrio_detalle";
        
        $result = $this->modelo->query($sqlUpdate, [
            'interes' => $interes,
            'mora' => $mora,
            'total' => $total,
            'id_detalle' => $idDetalle
        ]);
        
        error_log('[ARBITRIOS] Cálculo manual completado para ID: ' . 
                 ($result[0]['id_arbitrio_detalle'] ?? $idDetalle));
        
        return true;
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] Error en cálculo manual: ' . $e->getMessage());
        return false;
    }
}

    // Método para actualizar mora e interés
    private function actualizarMoraInteres($idDetalle) {
        try {
            $sql = "SELECT arb.fn_actualizar_mora_interes(:id_detalle)";
            $this->modelo->query($sql, ['id_detalle' => $idDetalle]);
            return true;
        } catch (Exception $e) {
            error_log('[ARBITRIOS] Error al actualizar mora/interés: ' . $e->getMessage());
            return false;
        }
    }

    // Método para generar registro en caja
   private function generarRegistroCaja($idPredio, $idTributo, $datosArbitrio, $fechaVencimiento, $predioInfo) {
    try {
        // Obtener cajero activo
        $idCajero = 1; // Temporal
        
        // Obtener siguiente número de recibo
        $sqlNumeroRecibo = "SELECT numeracion_actual_recibo + 1 as siguiente 
                          FROM caj.cajero 
                          WHERE id = :id_cajero";
        
        $resultNumero = $this->modelo->query($sqlNumeroRecibo, ['id_cajero' => $idCajero]);
        $numeroRecibo = $resultNumero[0]['siguiente'] ?? 1;
        
        // Crear pago - ¡¡CORREGIDO!!
        $sqlPago = "INSERT INTO caj.pago 
                   (id_usuario, id_cajero, id_tipo_pago, fecha_pago, total, observaciones)
                   VALUES (
                       :id_contribuyente, :id_cajero, 1, CURRENT_DATE, :total,
                       CONCAT('Arbitrios - ', :tributo_nombre, ' - Predio: ', :predio_codigo)
                   ) RETURNING id";
        
        $tributoNombre = $this->getNombreTributo($idTributo);
        
        $pago = $this->modelo->query($sqlPago, [
            'id_contribuyente' => $predioInfo['id_contribuyente'],
            'id_cajero' => $idCajero,
            'total' => $datosArbitrio['monto_final'],
            'tributo_nombre' => $tributoNombre,
            'predio_codigo' => $predioInfo['codigo_catastral']
        ]);
        
        $idPago = $pago[0]['id'];
        
        // Buscar concepto de pago
        $sqlConcepto = "SELECT id FROM caj.concepto_pago 
                       WHERE descripcion ILIKE '%arbitrio%' 
                       LIMIT 1";
        
        $concepto = $this->modelo->query($sqlConcepto);
        $idConcepto = $concepto[0]['id'] ?? 1;
        
        // Crear detalle
        $sqlDetalle = "INSERT INTO caj.pago_detalle 
                      (id_pago, id_concepto_pago, cantidad, subtotal)
                      VALUES (:id_pago, :id_concepto, 1, :subtotal)";
        
        $this->modelo->query($sqlDetalle, [
            'id_pago' => $idPago,
            'id_concepto' => $idConcepto,
            'subtotal' => $datosArbitrio['monto_final']
        ]);
        
        // Generar recibo
        $sqlRecibo = "INSERT INTO caj.recibo 
                     (id_pago, id_cajero, numero_recibo, fecha_emision, total, estado)
                     VALUES (:id_pago, :id_cajero, :numero_recibo, CURRENT_DATE, :total, 'PENDIENTE')
                     RETURNING id";
        
        $recibo = $this->modelo->query($sqlRecibo, [
            'id_pago' => $idPago,
            'id_cajero' => $idCajero,
            'numero_recibo' => $numeroRecibo,
            'total' => $datosArbitrio['monto_final']
        ]);
        
        // Actualizar numeración
        $sqlActualizarCajero = "UPDATE caj.cajero 
                               SET numeracion_actual_recibo = :numero_recibo 
                               WHERE id = :id_cajero";
        
        $this->modelo->query($sqlActualizarCajero, [
            'numero_recibo' => $numeroRecibo,
            'id_cajero' => $idCajero
        ]);
        
        return $recibo[0]['id'];
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] Error en generarRegistroCaja: ' . $e->getMessage());
        throw new Exception('Error al generar recibo: ' . $e->getMessage());
    }
}

    // Método para generar recibos en caja (llamado desde JS)
public function generarRecibosCaja() {
    header('Content-Type: application/json');
    
    try {
        $input = file_get_contents('php://input');
        $data = json_decode($input, true);
        
        error_log('[ARBITRIOS] === GENERAR RECIBOS CAJA ===');
        error_log('[ARBITRIOS] Datos: ' . print_r($data, true));
        
        $predios = $data['predios'] ?? [];
        $idCajero = $data['id_cajero'] ?? 1;
        $fechaVencimiento = $data['fecha_vencimiento'] ?? date('Y-m-d');
        
        if (empty($predios)) {
            echo json_encode(['error' => 'No hay predios seleccionados']);
            exit;
        }
        
        $recibosGenerados = [];
        $totalGenerado = 0;
        
        foreach ($predios as $idPredio) {
            error_log('[ARBITRIOS] Buscando deudas para predio: ' . $idPredio);
            
            // Consulta más simple y segura
            $sqlDeudas = "SELECT 
                            ad.id_arbitrio_detalle,
                            ad.monto_final,
                            a.id_contribuyente,
                            p.codigo_catastral
                         FROM arb.arbitrio_detalle ad
                         INNER JOIN arb.arbitrio a ON a.id_arbitrio = ad.id_arbitrio
                         INNER JOIN gen.gen_predio p ON p.id = a.id_predio
                         WHERE a.id_predio = :id_predio
                         AND ad.monto_final > 0
                         LIMIT 10"; // Límite por seguridad
            
            $deudas = $this->modelo->query($sqlDeudas, ['id_predio' => $idPredio]);
            
            error_log('[ARBITRIOS] Deudas encontradas: ' . count($deudas));
            
            if (empty($deudas)) {
                error_log('[ARBITRIOS] No hay deudas para predio: ' . $idPredio);
                continue;
            }
            
            foreach ($deudas as $deuda) {
                error_log('[ARBITRIOS] Generando recibo para deuda ID: ' . $deuda['id_arbitrio_detalle']);
                
                // Generar recibo SIMPLIFICADO (sin auditoría problemática)
                $idRecibo = $this->generarReciboSimple($idCajero, $deuda, $fechaVencimiento);
                
                if ($idRecibo) {
                    $recibosGenerados[] = [
                        'id_recibo' => $idRecibo,
                        'predio' => $deuda['codigo_catastral'],
                        'monto' => $deuda['monto_final'],
                        'id_deuda' => $deuda['id_arbitrio_detalle']
                    ];
                    $totalGenerado += $deuda['monto_final'];
                }
            }
        }
        
        echo json_encode([
            'success' => true,
            'message' => 'Recibos generados exitosamente',
            'recibos_generados' => count($recibosGenerados),
            'total_generado' => $totalGenerado,
            'detalles' => $recibosGenerados,
            'debug' => [
                'predios_procesados' => count($predios),
                'cajero_id' => $idCajero
            ]
        ]);
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] ERROR generarRecibosCaja: ' . $e->getMessage());
        echo json_encode([
            'success' => false,
            'error' => 'Error: ' . $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ]);
    }
    
    exit;
}

// Método SIMPLIFICADO para generar recibo (sin problemas de auditoría)
private function generarReciboSimple($idCajero, $deuda, $fechaVencimiento) {
    try {
        // 1. Obtener número de recibo
        $sqlNumero = "SELECT numeracion_actual_recibo + 1 as siguiente 
                     FROM caj.cajero 
                     WHERE id = :id_cajero";
        
        $resultNumero = $this->modelo->query($sqlNumero, ['id_cajero' => $idCajero]);
        $numeroRecibo = $resultNumero[0]['siguiente'] ?? 1;
        
        // 2. Crear pago simple
        $sqlPago = "INSERT INTO caj.pago 
                   (id_usuario, id_cajero, id_tipo_pago, fecha_pago, total, observaciones)
                   VALUES (
                       :id_contribuyente, 
                       :id_cajero, 
                       1, 
                       CURRENT_DATE, 
                       :total,
                       CONCAT('Arbitrios - Predio: ', :predio_codigo)
                   ) RETURNING id";
        
        $pago = $this->modelo->query($sqlPago, [
            'id_contribuyente' => $deuda['id_contribuyente'],
            'id_cajero' => $idCajero,
            'total' => $deuda['monto_final'],
            'predio_codigo' => $deuda['codigo_catastral']
        ]);
        
        if (empty($pago)) {
            throw new Exception('No se pudo crear el pago');
        }
        
        $idPago = $pago[0]['id'];
        
        // 3. Crear recibo simple
        $sqlRecibo = "INSERT INTO caj.recibo 
                     (id_pago, id_cajero, numero_recibo, fecha_emision, total, estado)
                     VALUES (:id_pago, :id_cajero, :numero_recibo, CURRENT_DATE, :total, 'PENDIENTE')
                     RETURNING id";
        
        $recibo = $this->modelo->query($sqlRecibo, [
            'id_pago' => $idPago,
            'id_cajero' => $idCajero,
            'numero_recibo' => $numeroRecibo,
            'total' => $deuda['monto_final']
        ]);
        
        // 4. Actualizar numeración
        $sqlActualizarCajero = "UPDATE caj.cajero 
                               SET numeracion_actual_recibo = :numero_recibo 
                               WHERE id = :id_cajero";
        
        $this->modelo->query($sqlActualizarCajero, [
            'numero_recibo' => $numeroRecibo,
            'id_cajero' => $idCajero
        ]);
        
        error_log('[ARBITRIOS] Recibo generado: #' . $numeroRecibo . ' ID: ' . $recibo[0]['id']);
        
        return $recibo[0]['id'];
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] Error generarReciboSimple: ' . $e->getMessage());
        return null;
    }
}

    // Método para generar recibo individual (faltaba)
// Agrega este método en tu clase ArbitriosController
private function generarReciboIndividual($idCajero, $deuda, $fechaVencimiento) {
    error_log('[ARBITRIOS] generandoReciboIndividual para cajero: ' . $idCajero);
    
    try {
        // 1. Obtener siguiente número de recibo
        $sqlNumero = "SELECT numeracion_actual_recibo + 1 as siguiente 
                     FROM caj.cajero 
                     WHERE id = :id_cajero";
        
        $resultNumero = $this->modelo->query($sqlNumero, ['id_cajero' => $idCajero]);
        $numeroRecibo = $resultNumero[0]['siguiente'] ?? 1;
        
        error_log('[ARBITRIOS] Número recibo: ' . $numeroRecibo);
        
        // 2. Crear pago
        $sqlPago = "INSERT INTO caj.pago 
                   (id_usuario, id_cajero, id_tipo_pago, fecha_pago, total, observaciones)
                   VALUES (
                       :id_contribuyente, 
                       :id_cajero, 
                       1, 
                       CURRENT_DATE, 
                       :total,
                       CONCAT('Arbitrios - Predio: ', :predio_codigo, ' - Vence: ', :fecha_vencimiento)
                   ) RETURNING id";
        
        $pago = $this->modelo->query($sqlPago, [
            'id_contribuyente' => $deuda['id_contribuyente'],
            'id_cajero' => $idCajero,
            'total' => $deuda['monto_final'],
            'predio_codigo' => $deuda['codigo_catastral'],
            'fecha_vencimiento' => $fechaVencimiento
        ]);
        
        if (empty($pago)) {
            throw new Exception('No se pudo crear el pago');
        }
        
        $idPago = $pago[0]['id'];
        error_log('[ARBITRIOS] Pago creado ID: ' . $idPago);
        
        // 3. Buscar concepto de pago para arbitrios
        $sqlConcepto = "SELECT id FROM caj.concepto_pago 
                       WHERE descripcion ILIKE '%arbitrio%' 
                       LIMIT 1";
        
        $concepto = $this->modelo->query($sqlConcepto);
        $idConcepto = $concepto[0]['id'] ?? 1;
        
        // 4. Crear detalle del pago
        $sqlDetalle = "INSERT INTO caj.pago_detalle 
                      (id_pago, id_concepto_pago, cantidad, subtotal)
                      VALUES (:id_pago, :id_concepto, 1, :subtotal)";
        
        $this->modelo->query($sqlDetalle, [
            'id_pago' => $idPago,
            'id_concepto' => $idConcepto,
            'subtotal' => $deuda['monto_final']
        ]);
        
        // 5. Generar recibo
        $sqlRecibo = "INSERT INTO caj.recibo 
                     (id_pago, id_cajero, numero_recibo, fecha_emision, total, estado)
                     VALUES (:id_pago, :id_cajero, :numero_recibo, CURRENT_DATE, :total, 'PENDIENTE')
                     RETURNING id";
        
        $recibo = $this->modelo->query($sqlRecibo, [
            'id_pago' => $idPago,
            'id_cajero' => $idCajero,
            'numero_recibo' => $numeroRecibo,
            'total' => $deuda['monto_final']
        ]);
        
        if (empty($recibo)) {
            throw new Exception('No se pudo crear el recibo');
        }
        
        $idRecibo = $recibo[0]['id'];
        error_log('[ARBITRIOS] Recibo creado ID: ' . $idRecibo);
        
        // 6. Actualizar numeración del cajero
        $sqlActualizarCajero = "UPDATE caj.cajero 
                               SET numeracion_actual_recibo = :numero_recibo 
                               WHERE id = :id_cajero";
        
        $this->modelo->query($sqlActualizarCajero, [
            'numero_recibo' => $numeroRecibo,
            'id_cajero' => $idCajero
        ]);
        
        // 7. Registrar auditoría SIMPLIFICADA (sin el atributo problemático)
        try {
            $sqlAuditoria = "INSERT INTO caj.auditoria 
                           (tabla, operacion, registro_id, usuario_bd, fecha, descripcion)
                           VALUES ('recibo', 'INSERT', :id_recibo, CURRENT_USER, CURRENT_TIMESTAMP, :descripcion)";
            
            $this->modelo->query($sqlAuditoria, [
                'id_recibo' => $idRecibo,
                'descripcion' => json_encode([
                    'predio' => $deuda['codigo_catastral'],
                    // 'contribuyente' => OMITIDO TEMPORALMENTE,
                    'monto' => $deuda['monto_final'],
                    'fecha_vencimiento' => $fechaVencimiento,
                    'id_contribuyente' => $deuda['id_contribuyente']
                ])
            ]);
            
            error_log('[ARBITRIOS] Auditoría registrada para recibo: ' . $idRecibo);
            
        } catch (Exception $e) {
            // No romper si falla la auditoría
            error_log('[ARBITRIOS] Error en auditoría (no crítico): ' . $e->getMessage());
        }
        
        return $idRecibo;
        
    } catch (Exception $e) {
        error_log('[ARBITRIOS] Error en generarReciboIndividual: ' . $e->getMessage());
        return null;
    }
}
    // Método auxiliar para obtener nombre del tributo
    private function getNombreTributo($idTributo) {
        $tributos = [
            1 => 'Limpieza Pública',
            2 => 'Parques y Jardines',
            3 => 'Residuos Sólidos',
            4 => 'Serenazgo'
        ];
        
        return $tributos[$idTributo] ?? 'Arbitrios';
    }
}


?>