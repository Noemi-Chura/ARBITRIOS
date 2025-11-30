<?php

class Router {

    public function run() {
        $url = $_GET['url'] ?? 'home';

        if ($url === 'home') {
            $controller = new HomeController();
            $controller->index();
            return;
        }

        http_response_code(404);
        echo "Página no encontrada";
    }
}