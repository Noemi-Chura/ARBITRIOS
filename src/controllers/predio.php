<?php
require_once(__DIR__ . "/../models/Database.php");

class PredioController {

    private $modelo;

    public function __construct() {
        $this->modelo = new Modelo();
    }

    
    public function index() {
        $dato = $this->modelo->mostrar("gen.gen_predio", "1=1");
        require_once(__DIR__ . "/../views/predio/predio.php");
    }

    
    public function nuevo() {
        
        $vias = $this->modelo->mostrar("gen.gen_via", "estado='Activo'");
        $sectores = $this->modelo->mostrar("gen.gen_sector", "estado='Activo'");
        $habilitaciones = $this->modelo->mostrar("gen.gen_habilitacion_urbana", "estado='Activo'");
        $tipos_interior = $this->modelo->mostrar("gen.gen_tipo_interior", "1=1");
        
        
        $departamentos = $this->modelo->mostrar("gen.gen_departamento", "1=1");
        $provincias = $this->modelo->mostrar("gen.gen_provincia", "1=1");
        $distritos = $this->modelo->mostrar("gen.gen_distrito", "1=1");

        require_once(__DIR__ . "/../views/predio/nuevoPredio.php");
    }

    
    public function guardar() {
        
        function toNullIfEmpty($value) {
            return ($value === '' || $value === null) ? null : $value;
        }
        
        
        $id_via = toNullIfEmpty($_POST["id_via"] ?? '');
        $id_sector = toNullIfEmpty($_POST["id_sector"] ?? '');
        $id_habilitacion_urbana = toNullIfEmpty($_POST["id_habilitacion_urbana"] ?? '');
        $id_tipo_interior = toNullIfEmpty($_POST["id_tipo_interior"] ?? '');
        $id_departamento = toNullIfEmpty($_POST["id_departamento"] ?? '');
        $id_provincia = toNullIfEmpty($_POST["id_provincia"] ?? '');
        $id_distrito = toNullIfEmpty($_POST["id_distrito"] ?? '');

        $columnas = [
            "estado",
            "id_via",
            "id_sector",
            "id_habilitacion_urbana",
            "numero",
            "letra",
            "nombre_predio",
            "id_tipo_interior",
            "nro_interior",
            "manzana",
            "lote",
            "sublote",
            "bloque",
            "edificio",
            "piso",
            "otra_numeracion",
            "nro_partida",
            "id_departamento",
            "id_provincia",
            "id_distrito"
        ];

        $valores = [
            $_POST["estado"] ?? 'Activo',
            $id_via,
            $id_sector,
            $id_habilitacion_urbana,
            toNullIfEmpty($_POST["numero"] ?? ''),
            toNullIfEmpty($_POST["letra"] ?? ''),
            $_POST["nombre_predio"] ?? null,
            $id_tipo_interior,
            toNullIfEmpty($_POST["nro_interior"] ?? ''),
            toNullIfEmpty($_POST["manzana"] ?? ''),
            toNullIfEmpty($_POST["lote"] ?? ''),
            toNullIfEmpty($_POST["sublote"] ?? ''),
            toNullIfEmpty($_POST["bloque"] ?? ''),
            toNullIfEmpty($_POST["edificio"] ?? ''),
            toNullIfEmpty($_POST["piso"] ?? ''),
            toNullIfEmpty($_POST["otra_numeracion"] ?? ''),
            toNullIfEmpty($_POST["nro_partida"] ?? ''),
            $id_departamento,
            $id_provincia,
            $id_distrito
        ];

        
        if (empty($_POST["nombre_predio"]) || !$id_habilitacion_urbana || !$id_departamento || !$id_provincia || !$id_distrito) {
            $_SESSION['flash_message'] = "Error: Campos requeridos faltantes";
            $_SESSION['flash_type'] = 'error';
            header("Location: index.php?c=predio&m=nuevo");
            exit;
        }

        try {
            
            $cols = implode(", ", $columnas);
            $placeholders = rtrim(str_repeat('?, ', count($valores)), ', ');
            
            $sql = "INSERT INTO gen.gen_predio ($cols) VALUES ($placeholders)";
            
            $stmt = $this->modelo->getConexion()->prepare($sql);
            $resultado = $stmt->execute($valores);
            
            if ($resultado) {
                $_SESSION['flash_message'] = "Predio creado exitosamente";
                $_SESSION['flash_type'] = 'success';
                header("Location: index.php?c=predio&m=index");
                exit;
            } else {
                $_SESSION['flash_message'] = "Error al crear el predio";
                $_SESSION['flash_type'] = 'error';
                header("Location: index.php?c=predio&m=nuevo");
                exit;
            }
        } catch (Exception $e) {
            $_SESSION['flash_message'] = "Error: " . $e->getMessage();
            $_SESSION['flash_type'] = 'error';
            header("Location: index.php?c=predio&m=nuevo");
            exit;
        }
    }

    
    public function editar() {
        $id = $_GET["id"] ?? '';
        if (!$id) {
            die("<main><h3>Error: ID de predio no especificado</h3></main>");
        }

        $dato = $this->modelo->mostrarUno("gen.gen_predio", "id='$id'");

        if (!$dato) {
            die("<main><h3>Error: el predio no existe o hubo un error.</h3></main>");
        }

        $vias = $this->modelo->mostrar("gen.gen_via", "estado='Activo'");
        $sectores = $this->modelo->mostrar("gen.gen_sector", "estado='Activo'");
        $habilitaciones = $this->modelo->mostrar("gen.gen_habilitacion_urbana", "estado='Activo'");
        $tipos_interior = $this->modelo->mostrar("gen.gen_tipo_interior", "1=1");
        
        
        $departamentos = $this->modelo->mostrar("gen.gen_departamento", "1=1");
        $provincias = $this->modelo->mostrar("gen.gen_provincia", "1=1");
        $distritos = $this->modelo->mostrar("gen.gen_distrito", "1=1");

        require_once(__DIR__ . "/../views/predio/editarPredio.php");
    }

    
    public function actualizar() {
        
        function toNullIfEmpty($value) {
            return ($value === '' || $value === null) ? null : $value;
        }
        
        $id = $_POST["id"] ?? '';
        if (!$id) {
            $_SESSION['flash_message'] = "Error: ID de predio no especificado";
            $_SESSION['flash_type'] = 'error';
            header("Location: index.php?c=predio&m=index");
            exit;
        }

        
        $id_via = toNullIfEmpty($_POST["id_via"] ?? '');
        $id_sector = toNullIfEmpty($_POST["id_sector"] ?? '');
        $id_habilitacion_urbana = toNullIfEmpty($_POST["id_habilitacion_urbana"] ?? '');
        $id_tipo_interior = toNullIfEmpty($_POST["id_tipo_interior"] ?? '');
        $id_departamento = toNullIfEmpty($_POST["id_departamento"] ?? '');
        $id_provincia = toNullIfEmpty($_POST["id_provincia"] ?? '');
        $id_distrito = toNullIfEmpty($_POST["id_distrito"] ?? '');

        $data = [
            "estado" => $_POST["estado"] ?? 'Activo',
            "id_via" => $id_via,
            "id_sector" => $id_sector,
            "id_habilitacion_urbana" => $id_habilitacion_urbana,
            "numero" => toNullIfEmpty($_POST["numero"] ?? ''),
            "letra" => toNullIfEmpty($_POST["letra"] ?? ''),
            "nombre_predio" => $_POST["nombre_predio"] ?? null,
            "id_tipo_interior" => $id_tipo_interior,
            "nro_interior" => toNullIfEmpty($_POST["nro_interior"] ?? ''),
            "manzana" => toNullIfEmpty($_POST["manzana"] ?? ''),
            "lote" => toNullIfEmpty($_POST["lote"] ?? ''),
            "sublote" => toNullIfEmpty($_POST["sublote"] ?? ''),
            "bloque" => toNullIfEmpty($_POST["bloque"] ?? ''),
            "edificio" => toNullIfEmpty($_POST["edificio"] ?? ''),
            "piso" => toNullIfEmpty($_POST["piso"] ?? ''),
            "otra_numeracion" => toNullIfEmpty($_POST["otra_numeracion"] ?? ''),
            "nro_partida" => toNullIfEmpty($_POST["nro_partida"] ?? ''),
            "id_departamento" => $id_departamento,
            "id_provincia" => $id_provincia,
            "id_distrito" => $id_distrito
        ];

        
        if (empty($_POST["nombre_predio"]) || !$id_habilitacion_urbana || !$id_departamento || !$id_provincia || !$id_distrito) {
            $_SESSION['flash_message'] = "Error: Campos requeridos faltantes";
            $_SESSION['flash_type'] = 'error';
            header("Location: index.php?c=predio&m=editar&id=" . urlencode($id));
            exit;
        }

        try {
            $resultado = $this->modelo->actualizar("gen.gen_predio", $data, "id='$id'");
            
            if ($resultado) {
                $_SESSION['flash_message'] = "Predio actualizado exitosamente";
                $_SESSION['flash_type'] = 'success';
                header("Location: index.php?c=predio&m=index");
                exit;
            } else {
                $_SESSION['flash_message'] = "Error al actualizar el predio";
                $_SESSION['flash_type'] = 'error';
                header("Location: index.php?c=predio&m=editar&id=" . urlencode($id));
                exit;
            }
        } catch (Exception $e) {
            $_SESSION['flash_message'] = "Error: " . $e->getMessage();
            $_SESSION['flash_type'] = 'error';
            header("Location: index.php?c=predio&m=editar&id=" . urlencode($id));
            exit;
        }
    }

    
    public function eliminar() {
        $id = $_GET["id"] ?? '';
        if (!$id) {
            $_SESSION['flash_message'] = "Error: ID de predio no especificado";
            $_SESSION['flash_type'] = 'error';
            header("Location: index.php?c=predio&m=index");
            exit;
        }

        try {
            $resultado = $this->modelo->eliminar("gen.gen_predio", "id='$id'");
            
            if ($resultado) {
                $_SESSION['flash_message'] = "Predio eliminado exitosamente";
                $_SESSION['flash_type'] = 'success';
            } else {
                $_SESSION['flash_message'] = "Error al eliminar el predio";
                $_SESSION['flash_type'] = 'error';
            }
        } catch (Exception $e) {
            $_SESSION['flash_message'] = "Error: " . $e->getMessage();
            $_SESSION['flash_type'] = 'error';
        }
        
        header("Location: index.php?c=predio&m=index");
        exit;
    }
}
?>

