# ARBITRIOS
Arbitrios municipales modulo

# Proyecto ARBITRIOS - Docker + PHP MVC + PostgreSQL

Este repositorio contiene el proyecto **ARBITRIOS** usando **Docker** para un entorno aislado de desarrollo, con PHP (MVC), Nginx y PostgreSQL.

---

## Requisitos previos

- Windows 10/11 con **WSL2** instalado
- Docker Desktop
- VSCode
- Git
- Archivo de la base de datos `sygt_data.dump` (SQL plano o Custom)

---

## Estructura del proyecto


---

## 1. Clonar el repositorio

```bash
git clone https://github.com/TU_USUARIO/ARBITRIOS.git
cd ARBITRIOS/docker

```
## 2. DEBES SACAR EL BACKUP DE LA BD SYGT_DATA dentro de la carpeta docker
- dentro de la carpeta docker

## 3. Levantar los contenedores Docker
- Desde PowerShell o CMD (dentro de la carpeta docker):
```bash
docker compose up -d
```
Esto levantará los servicios:
PHP (php_app)
Nginx (nginx_app)
PostgreSQL (postgres_local)
El contenedor de PostgreSQL usará la carpeta postgres-data para persistir los datos.

## 4. Restaurar la base de datos en Docker
```bash
Get-Content sygt_data.sql -Raw | docker exec -i postgres_local psql -U admin -d sygt_data
```

## 5. Verificar la base de datos

```bash
docker exec -it postgres_local psql -U admin -d sygt_data
```

## 6. robar la conexión desde navegador

```bash
http://localhost:8080/test.php
```
Deberías ver: Conectado a la base de datos correctamente.

## 8. Notas importantes

Todo CRUD que hagas dentro de Docker solo afecta a la copia de la BD (sygt_data en postgres_local).
La BD original en el VPS o pgAdmin no se verá modificada.
Los datos se persisten gracias a la carpeta postgres-data.