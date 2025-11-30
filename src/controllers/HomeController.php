<?php
require_once __DIR__ . '/../models/Database.php';

class HomeController {

    public function index() {
        $db = new Database();
        $conexion = $db->getConnection();

        $query = $conexion->query("SELECT 'Conectado a PostgreSQL remoto!' AS msg");
        $row = $query->fetch();

        require_once __DIR__ . '/../views/home.php';
    }
}