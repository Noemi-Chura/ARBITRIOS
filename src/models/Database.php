<?php
class Modelo {
    private $db;

    public function __construct() {
        try {
            // Conexión al servicio postgres en la red Docker
            $this->db = new PDO(
                "pgsql:host=postgres;
                port=5432;
                dbname=sygt_data",
                "admin",
                "elpasswordesesis"
            );
            $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Error de conexión: " . $e->getMessage());
        }
    }

    // INSERTAR REGISTRO
    public function insertar($tabla, $columnas, $valores) {
        $cols = implode(",", $columnas);
        $marcadores = rtrim(str_repeat('?,', count($valores)), ',');

        $sql = "INSERT INTO $tabla ($cols) VALUES ($marcadores)";

        try {
            $stmt = $this->db->prepare($sql);
            return $stmt->execute($valores);
        } catch (PDOException $e) {
            echo "Error al insertar: " . $e->getMessage();
            return false;
        }
    }

    // MOSTRAR TODO
    public function mostrar($tabla, $condicion = "1=1") {
        $sql = "SELECT * FROM $tabla WHERE $condicion";
        try {
            $stmt = $this->db->query($sql);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Error al mostrar: " . $e->getMessage();
            return [];
        }
    }

    // MOSTRAR UNO
    public function mostrarUno($tabla, $condicion) {
        $sql = "SELECT * FROM $tabla WHERE $condicion LIMIT 1";
        try {
            $stmt = $this->db->query($sql);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Error al mostrar uno: " . $e->getMessage();
            return false;
        }
    }

    // ACTUALIZAR
    public function actualizar($tabla, $data, $condicion) {
        $campos = [];
        foreach ($data as $col => $val) {
            $campos[] = "$col = ?";
        }

        $sql = "UPDATE $tabla SET " . implode(", ", $campos) . " WHERE $condicion";

        try {
            $stmt = $this->db->prepare($sql);
            return $stmt->execute(array_values($data));
        } catch (PDOException $e) {
            echo "Error al actualizar: " . $e->getMessage();
            return false;
        }
    }

    // ELIMINAR
    public function eliminar($tabla, $condicion) {
        $sql = "DELETE FROM $tabla WHERE $condicion";
        try {
            return $this->db->exec($sql) !== false;
        } catch (PDOException $e) {
            echo "Error al eliminar: " . $e->getMessage();
            return false;
        }
    }

    // CONSULTA DIRECTA
    public function consultaPersonalizada($sql) {
        try {
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Error en consulta: " . $e->getMessage();
        }
        return [];
    }

    public function getConexion() {
        return $this->db;
    }

    public function query($sql, $params = []) {
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>