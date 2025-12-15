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
}
?>