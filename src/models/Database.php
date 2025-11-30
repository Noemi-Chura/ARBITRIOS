<?php
class Database {
    private $host = "postgres"; // nombre del servicio en docker-compose
    private $db_name = "sygt_data";
    private $username = "admin";
    private $password = "elpasswordesesis";
    public $conn;

    public function getConnection() {
        $this->conn = null;

        try {
            $this->conn = new PDO(
                "pgsql:host={$this->host};port=5432;dbname={$this->db_name}",
                $this->username,
                $this->password
            );
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            echo "Conectado a la base de datos correctamente.";
        } catch(PDOException $exception) {
            echo "Error de conexión: " . $exception->getMessage();
        }

        return $this->conn;
    }
}