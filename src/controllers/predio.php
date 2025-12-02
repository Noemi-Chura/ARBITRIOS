<?php
require_once(__DIR__ . "/../models/Database.php");

class PredioController {

    private $modelo;

    public function __construct() {
        $this->modelo = new Modelo();
    }

    // Listar predios
    public function index() {
        $dato = $this->modelo->mostrar("gen.gen_predio", "1=1");
        require_once(__DIR__ . "/../views/predio/predio.php");
    }

    // Formulario nuevo predio
    public function nuevo() {
        // Para selects
        $vias = $this->modelo->mostrar("gen.gen_via", "estado='Activo'");
        $sectores = $this->modelo->mostrar("gen.gen_sector", "estado='Activo'");
        $habilitaciones = $this->modelo->mostrar("gen.gen_tipo_habilitacion_urbana", "1=1");
        $tipos_interior = $this->modelo->mostrar("gen.gen_tipo_interior", "1=1");

        require_once(__DIR__ . "/../views/predio/nuevoPredio.php");
    }

    // Guardar nuevo predio
    public function guardar() {
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
            $_POST["id_via"] ?? null,
            $_POST["id_sector"] ?? null,
            $_POST["id_habilitacion_urbana"] ?? null,
            $_POST["numero"] ?? null,
            $_POST["letra"] ?? null,
            $_POST["nombre_predio"] ?? null,
            $_POST["id_tipo_interior"] ?? null,
            $_POST["nro_interior"] ?? null,
            $_POST["manzana"] ?? null,
            $_POST["lote"] ?? null,
            $_POST["sublote"] ?? null,
            $_POST["bloque"] ?? null,
            $_POST["edificio"] ?? null,
            $_POST["piso"] ?? null,
            $_POST["otra_numeracion"] ?? null,
            $_POST["nro_partida"] ?? null,
            $_POST["id_departamento"] ?? null,
            $_POST["id_provincia"] ?? null,
            $_POST["id_distrito"] ?? null
        ];

        $this->modelo->insertar("gen.gen_predio", $columnas, $valores);

        header("Location: index.php?c=predio&m=index");
        exit;
    }

    // Formulario editar predio
    public function editar() {
        $id = $_GET["id"];
        $dato = $this->modelo->mostrarUno("gen.gen_predio", "id='$id'");

        if (!$dato) {
            die("<main><h3>Error: el predio no existe o hubo un error.</h3></main>");
        }

        $vias = $this->modelo->mostrar("gen.gen_via", "estado='Activo'");
        $sectores = $this->modelo->mostrar("gen.gen_sector", "estado='Activo'");
        $habilitaciones = $this->modelo->mostrar("gen.gen_tipo_habilitacion_urbana", "1=1");
        $tipos_interior = $this->modelo->mostrar("gen.gen_tipo_interior", "1=1");

        require_once(__DIR__ . "/../views/predio/editarPredio.php");
    }

    // Actualizar predio
    public function actualizar() {
        $id = $_POST["id"];

        $data = [
            "estado" => $_POST["estado"] ?? 'Activo',
            "id_via" => $_POST["id_via"] ?? null,
            "id_sector" => $_POST["id_sector"] ?? null,
            "id_habilitacion_urbana" => $_POST["id_habilitacion_urbana"] ?? null,
            "numero" => $_POST["numero"] ?? null,
            "letra" => $_POST["letra"] ?? null,
            "nombre_predio" => $_POST["nombre_predio"] ?? null,
            "id_tipo_interior" => $_POST["id_tipo_interior"] ?? null,
            "nro_interior" => $_POST["nro_interior"] ?? null,
            "manzana" => $_POST["manzana"] ?? null,
            "lote" => $_POST["lote"] ?? null,
            "sublote" => $_POST["sublote"] ?? null,
            "bloque" => $_POST["bloque"] ?? null,
            "edificio" => $_POST["edificio"] ?? null,
            "piso" => $_POST["piso"] ?? null,
            "otra_numeracion" => $_POST["otra_numeracion"] ?? null,
            "nro_partida" => $_POST["nro_partida"] ?? null,
            "id_departamento" => $_POST["id_departamento"] ?? null,
            "id_provincia" => $_POST["id_provincia"] ?? null,
            "id_distrito" => $_POST["id_distrito"] ?? null
        ];

        $this->modelo->actualizar("gen.gen_predio", $data, "id='$id'");

        header("Location: index.php?c=predio&m=index");
        exit;
    }

    // Eliminar predio
    public function eliminar() {
        $id = $_GET["id"];
        $this->modelo->eliminar("gen.gen_predio", "id='$id'");

        header("Location: index.php?c=predio&m=index");
        exit;
    }
}
?>