<?php
ob_start(); // Iniciar buffer de salida
error_reporting(E_ALL);
ini_set('display_errors', 0); // No mostrar errores en salida, solo en logs
ini_set('log_errors', 1);

require_once(__DIR__ . "/config.php");

$c = $_GET['c'] ?? '';
$m = $_GET['m'] ?? '';

if (empty($c) && empty($m)) {
    require_once(__DIR__ . "/views/layout/header.php");
    require_once(__DIR__ . "/views/layout/menu.php");
    echo "<main><h2>Bienvenido al sistema !</h2></main>";
    exit;
}

$controladorArchivo = __DIR__ . "/controllers/" . $c . ".php";

if (file_exists($controladorArchivo)) {
    require_once($controladorArchivo);

    $claseControlador = ucfirst($c) . "Controller";

    if (class_exists($claseControlador)) {
        $controlador = new $claseControlador();

        if (method_exists($controlador, $m)) {
            $controlador->$m();
        } else {
            echo "<main>Error: método <b>$m</b> no encontrado en <b>$claseControlador</b>.</main>";
        }
    } else {
        echo "<main>Error: clase controlador <b>$claseControlador</b> no encontrada.</main>";
    }
} else {
    echo "<main>Error: archivo de controlador <b>$c</b> no encontrado.</main>";
}
?>