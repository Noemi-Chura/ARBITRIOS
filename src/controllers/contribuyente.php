<?php
require_once(__DIR__ . "/../models/Database.php");

class ContribuyenteController {

    private $modelo;

    public function __construct() {
        $this->modelo = new Modelo();
    }

    // Mostrar lista de contribuyentes
    public function index() {
        $dato = $this->modelo->mostrar("gen.gen_contribuyente", "1=1");
        require_once(__DIR__ . "/../views/contribuyente/contribuyente.php");
    }

    // Mostrar formulario para nuevo contribuyente
    public function nuevo() {
        require_once(__DIR__ . "/../views/contribuyente/nuevoContribuyente.php");
    }

    // Guardar nuevo contribuyente
    public function guardar() {
        // Reemplazar valores vacíos por null
        $dni = $_POST["dni"] ?? null;
        if ($dni === '') $dni = null;

        $ruc = $_POST["ruc"] ?? null;
        if ($ruc === '') $ruc = null;

        $otro_documento = $_POST["otro_documento_identidad"] ?? null;
        if ($otro_documento === '') $otro_documento = null;

        $nro_documento = $_POST["nro_documento_identidad"] ?? null;
        if ($nro_documento === '') $nro_documento = null;

        $fecha_nacimiento = $_POST["fecha_nacimiento"] ?? null;
        if ($fecha_nacimiento === '') $fecha_nacimiento = null;

        $domicilio = $_POST["domicilio_fiscal"] ?? null;
        if ($domicilio === '') $domicilio = null;

        $telefono_celular = $_POST["telefono_celular"] ?? null;
        if ($telefono_celular === '') $telefono_celular = null;

        $email = $_POST["email"] ?? null;
        if ($email === '') $email = null;

        $observaciones = $_POST["observaciones"] ?? null;
        if ($observaciones === '') $observaciones = null;

        // Columnas a insertar
        $columnas = [
            "nombre",
            "genero",
            "tipo_persona",
            "estado",
            "dni",
            "ruc",
            "otro_documento_identidad",
            "nro_documento_identidad",
            "fecha_nacimiento",
            "domicilio_fiscal",
            "telefono_celular",
            "email",
            "observaciones"
        ];

        // Valores a insertar
        $valores = [
            $_POST["nombre"],
            $_POST["genero"],
            $_POST["tipo_persona"],
            $_POST["estado"],
            $dni,
            $ruc,
            $otro_documento,
            $nro_documento,
            $fecha_nacimiento,
            $domicilio,
            $telefono_celular,
            $email,
            $observaciones
        ];

        // Insertar en la base de datos
        $this->modelo->insertar("gen.gen_contribuyente", $columnas, $valores);

        // Redirigir después de insertar
        header("Location: index.php?c=contribuyente&m=index");
        exit;
    }

    // Mostrar formulario para editar
    public function editar() {
        $id = $_GET["id"];
        $dato = $this->modelo->mostrarUno("gen.gen_contribuyente", "id='$id'");

        if (!$dato) {
            die("<main><h3>Error: el contribuyente no existe o hubo un error.</h3></main>");
        }

        require_once(__DIR__ . "/../views/contribuyente/editarContribuyente.php");
    }

    // Actualizar contribuyente
    public function actualizar() {
        $id = $_POST["id"];

        // Reemplazar valores vacíos por null
        $dni = $_POST["dni"] ?? null;
        if ($dni === '') $dni = null;

        $ruc = $_POST["ruc"] ?? null;
        if ($ruc === '') $ruc = null;

        $otro_documento = $_POST["otro_documento_identidad"] ?? null;
        if ($otro_documento === '') $otro_documento = null;

        $nro_documento = $_POST["nro_documento_identidad"] ?? null;
        if ($nro_documento === '') $nro_documento = null;

        $fecha_nacimiento = $_POST["fecha_nacimiento"] ?? null;
        if ($fecha_nacimiento === '') $fecha_nacimiento = null;

        $domicilio = $_POST["domicilio_fiscal"] ?? null;
        if ($domicilio === '') $domicilio = null;

        $telefono_celular = $_POST["telefono_celular"] ?? null;
        if ($telefono_celular === '') $telefono_celular = null;

        $email = $_POST["email"] ?? null;
        if ($email === '') $email = null;

        $observaciones = $_POST["observaciones"] ?? null;
        if ($observaciones === '') $observaciones = null;

        // Datos a actualizar
        $data = [
            "nombre" => $_POST["nombre"],
            "genero" => $_POST["genero"],
            "tipo_persona" => $_POST["tipo_persona"],
            "estado" => $_POST["estado"],
            "dni" => $dni,
            "ruc" => $ruc,
            "otro_documento_identidad" => $otro_documento,
            "nro_documento_identidad" => $nro_documento,
            "fecha_nacimiento" => $fecha_nacimiento,
            "domicilio_fiscal" => $domicilio,
            "telefono_celular" => $telefono_celular,
            "email" => $email,
            "observaciones" => $observaciones
        ];

        $this->modelo->actualizar("gen.gen_contribuyente", $data, "id='$id'");

        header("Location: index.php?c=contribuyente&m=index");
        exit;
    }

    // Eliminar contribuyente
    public function eliminar() {
        $id = $_GET["id"];
        $this->modelo->eliminar("gen.gen_contribuyente", "id='$id'");

        header("Location: index.php?c=contribuyente&m=index");
        exit;
    }
}
?>