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
        $estados = ['activo', 'anulado', 'subdividido'];
        
        // Obtener estadísticas para mostrar en la interfaz
        $stats = $this->modelo->consultaPersonalizada(
            "SELECT 
                (SELECT COUNT(*) FROM arb.arbitrio WHERE id_contribuyente = '" . addslashes($id) . "') as total_arbitrios,
                (SELECT COUNT(*) FROM arb.licencia_funcionamiento WHERE id_contribuyente = '" . addslashes($id) . "' AND estado = 'activo') as licencias_activas,
                (SELECT COUNT(*) FROM arb.declaracion_jurada WHERE id_contribuyente = '" . addslashes($id) . "') as declaraciones
            "
        )[0];
        
        require_once(__DIR__ . "/../views/arbitrios/index.php");
    }

    // ============ NUEVOS MÉTODOS PARA IMPORTACIÓN ============
    
    // Obtener licencias de funcionamiento para un contribuyente
    public function getLicencias() {
        $idContribuyente = $_GET['id'] ?? null;
        
        if (!$idContribuyente) {
            echo json_encode(['error' => 'Falta ID del contribuyente']);
            exit;
        }
        
        $sql = "SELECT 
                    l.id_licencia as id,
                    l.nro_licencia as codigo,
                    CONCAT(p.nombre_predio, ' - ', COALESCE(v.nombre, '') || ' ' || COALESCE(p.numero, '') || ' ' || COALESCE(p.letra, '')) as direccion,
                    CONCAT('Licencia: ', l.nro_licencia, ' | Categoría: ', COALESCE(c.denominacion, 'Sin categoría'), ' | Estado: ', l.estado) as adicional,
                    p.id as id_predio
                FROM arb.licencia_funcionamiento l
                INNER JOIN gen.gen_predio p ON p.id = l.id_predio
                LEFT JOIN gen.gen_via v ON v.id = p.id_via
                LEFT JOIN arb.categoria c ON c.id_categoria = l.id_categoria
                WHERE l.id_contribuyente = :id_contribuyente
                AND l.estado = 'activo'
                ORDER BY l.fecha_emision DESC";
        
        $licencias = $this->modelo->query($sql, ['id_contribuyente' => $idContribuyente]);
        
        header('Content-Type: application/json');
        echo json_encode(['success' => true, 'data' => $licencias]);
        exit;
    }

    // Obtener declaraciones juradas para un contribuyente
    public function getDeclaraciones() {
        $idContribuyente = $_GET['id'] ?? null;
        
        if (!$idContribuyente) {
            echo json_encode(['error' => 'Falta ID del contribuyente']);
            exit;
        }
        
        $sql = "SELECT 
                    d.id_declaracion_jurada as id,
                    CONCAT('DDJJ-', d.anio, '-', LPAD(d.id_declaracion_jurada::text, 3, '0')) as codigo,
                    CONCAT(p.nombre_predio, ' - ', COALESCE(v.nombre, '') || ' ' || COALESCE(p.numero, '') || ' ' || COALESCE(p.letra, '')) as direccion,
                    CONCAT('Año: ', d.anio, ' | Predio: ', p.id) as adicional,
                    p.id as id_predio
                FROM arb.declaracion_jurada d
                INNER JOIN gen.gen_predio p ON p.id = d.id_predio
                LEFT JOIN gen.gen_via v ON v.id = p.id_via
                WHERE d.id_contribuyente = :id_contribuyente
                ORDER BY d.anio DESC, d.id_declaracion_jurada DESC";
        
        $declaraciones = $this->modelo->query($sql, ['id_contribuyente' => $idContribuyente]);
        
        header('Content-Type: application/json');
        echo json_encode(['success' => true, 'data' => $declaraciones]);
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
            $errors = [];
            
            foreach ($predios as $predio) {
                // Verificar si el predio ya existe en arbitrios para este contribuyente
                $sqlCheck = "SELECT COUNT(*) as existe FROM arb.arbitrio 
                            WHERE id_contribuyente = :id_contribuyente 
                            AND id_predio = :id_predio";
                
                $existe = $this->modelo->query($sqlCheck, [
                    'id_contribuyente' => $idContribuyente,
                    'id_predio' => $predio['id_predio']
                ]);
                
                if ($existe[0]['existe'] == 0) {
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
                                 anio, estado, usuario_actualizado, fecha_actualizado)
                                VALUES (:id_arbitrio, :id_contribuyente, :id_predio, :id_tipo_registro_origen, 
                                        :anio, 'activo', :usuario, CURRENT_TIMESTAMP)";
                    
                    $this->modelo->query($sqlInsert, [
                        'id_arbitrio' => $nextId,
                        'id_contribuyente' => $idContribuyente,
                        'id_predio' => $predio['id_predio'],
                        'id_tipo_registro_origen' => $idTipoRegistro,
                        'anio' => date('Y'),
                        'usuario' => 'ADMIN' // En producción, usar $_SESSION['usuario']
                    ]);
                    
                    $importados++;
                } else {
                    $errors[] = "Predio {$predio['codigo']} ya está registrado en arbitrios";
                }
            }
            
            echo json_encode([
                'success' => true,
                'message' => "Se importaron {$importados} predios correctamente",
                'importados' => $importados,
                'errors' => $errors
            ]);
            
        } catch (Exception $e) {
            echo json_encode(['error' => 'Error al importar: ' . $e->getMessage()]);
        }
        
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
}
?>