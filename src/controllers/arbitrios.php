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
        $estados = ['Activo', 'Anulado', 'Subdividido'];
        require_once(__DIR__ . "/../views/arbitrios/index.php");
    }
}

?>
