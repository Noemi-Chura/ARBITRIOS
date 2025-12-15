# ARBITRIOS - Sistema de Arbitrios Municipales

Sistema web para la gestión de arbitrios municipales desarrollado con PHP MVC, PostgreSQL y Docker.

---

## 📋 Requisitos previos

Antes de comenzar, asegúrate de tener instalado lo siguiente en tu PC:

### Windows 10/11
- **WSL2** (Windows Subsystem for Linux 2)
- **Docker Desktop** para Windows
- **Git** para Windows
- **Visual Studio Code** (recomendado)

### Verificar instalaciones

```powershell
# Verificar WSL2
wsl --version

# Verificar Docker
docker --version
docker compose version

# Verificar Git
git --version
```

---

## 🚀 Instalación desde cero

### Paso 1: Instalar WSL2 (si no lo tienes)

```powershell
# Ejecutar como Administrador en PowerShell
wsl --install
```

Reinicia tu PC después de la instalación.

### Paso 2: Instalar Docker Desktop

1. Descarga Docker Desktop desde: https://www.docker.com/products/docker-desktop
2. Instala y asegúrate de habilitar la integración con WSL2
3. Abre Docker Desktop y verifica que esté corriendo

### Paso 3: Instalar Git

1. Descarga Git desde: https://git-scm.com/download/win
2. Instala con las opciones por defecto

---

## 📁 Estructura del proyecto

```
ARBITRIOS/
├── docker/
│   ├── docker-compose.yml          # Configuración de contenedores
│   ├── init_data.sql               # Script inicial de BD
│   ├── sygt_data.sql               # Backup de la base de datos
│   ├── nginx/
│   │   └── default.conf            # Configuración de Nginx
│   └── php/
│       └── Dockerfile              # Imagen personalizada de PHP
├── src/
│   ├── config.php                  # Configuración de la aplicación
│   ├── index.php                   # Punto de entrada
│   ├── controllers/                # Controladores MVC
│   │   ├── arbitrios.php
│   │   ├── contribuyente.php
│   │   └── predio.php
│   ├── models/
│   │   └── Database.php            # Clase de conexión a BD
│   └── views/                      # Vistas de la aplicación
├── postgres-data/                  # Datos persistentes de PostgreSQL
├── composer.json                   # Dependencias PHP
└── README.md                       # Este archivo
```

---

## 🔧 Configuración e instalación

### 1. Clonar el repositorio

```powershell
# Abre PowerShell o Windows Terminal
cd C:\
git clone https://github.com/TU_USUARIO/ARBITRIOS.git
cd ARBITRIOS
```

### 2. Preparar el backup de la base de datos

**IMPORTANTE:** Debes colocar el archivo `sygt_data.sql` dentro de la carpeta `docker/`

```powershell
# Verifica que el archivo exista
dir docker\sygt_data.sql
```

Si no tienes el archivo, solicítalo al administrador del proyecto.

### 3. Levantar los contenedores Docker

```powershell
# Navega a la carpeta docker
cd docker

# Inicia los contenedores en segundo plano
docker compose up -d
```

Esto creará y levantará 3 contenedores:
- **php_app**: Servidor PHP 8.1 con extensiones
- **nginx_app**: Servidor web Nginx
- **postgres_local**: Base de datos PostgreSQL 15

### 4. Verificar que los contenedores estén corriendo

```powershell
# Ver contenedores activos
docker ps

# Deberías ver 3 contenedores con estado "Up"
```

### 5. Restaurar la base de datos

```powershell
# Asegúrate de estar en la carpeta docker
cd C:\ARBITRIOS\docker

# Restaurar el backup SQL
Get-Content sygt_data.sql -Raw | docker exec -i postgres_local psql -U admin -d sygt_data
```

**Nota:** Este proceso puede tardar varios minutos dependiendo del tamaño del archivo.

### 6. Verificar la conexión a la base de datos

```powershell
# Conectarse al contenedor de PostgreSQL
docker exec -it postgres_local psql -U admin -d sygt_data

# Dentro de PostgreSQL, verifica las tablas
\dt arb.*
\dt gen.*
\dt caj.*

# Salir de PostgreSQL
\q
```

### 7. Probar la aplicación

Abre tu navegador y accede a:

```
http://localhost:8080
```

Si ves la página principal del sistema, ¡la instalación fue exitosa! 🎉

---

## 🛠️ Comandos útiles para desarrollo

### Gestión de contenedores

```powershell
# Iniciar los contenedores
docker compose up -d

# Detener los contenedores
docker compose down

# Ver logs en tiempo real
docker compose logs -f

# Ver logs de un servicio específico
docker compose logs -f php_app
docker compose logs -f nginx_app
docker compose logs -f postgres_local

# Reiniciar un servicio específico
docker compose restart php_app
docker compose restart nginx_app
```

### Acceso a contenedores

```powershell
# Acceder al contenedor PHP
docker exec -it php_app bash

# Acceder al contenedor de PostgreSQL
docker exec -it postgres_local psql -U admin -d sygt_data

# Ejecutar comandos SQL desde PowerShell
docker exec -it postgres_local psql -U admin -d sygt_data -c "SELECT * FROM gen.gen_contribuyente LIMIT 5;"
```

### Backup y restore de la base de datos

```powershell
# Crear un backup
docker exec postgres_local pg_dump -U admin sygt_data > backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').sql

# Restaurar desde backup
Get-Content backup_20241215_143000.sql -Raw | docker exec -i postgres_local psql -U admin -d sygt_data
```

### Limpiar y reconstruir

```powershell
# Detener y eliminar contenedores, redes e imágenes
docker compose down --rmi all

# Eliminar volúmenes (CUIDADO: borra los datos de PostgreSQL)
docker compose down -v

# Reconstruir las imágenes
docker compose build --no-cache

# Levantar todo de nuevo
docker compose up -d
```

---

## 🔍 Solución de problemas comunes

### Problema: Puerto 8080 ya está en uso

```powershell
# Ver qué está usando el puerto
netstat -ano | findstr :8080

# Cambiar el puerto en docker-compose.yml
# Busca la línea: "8080:80" y cámbiala a "8081:80"
```

### Problema: Docker no inicia

1. Verifica que Docker Desktop esté corriendo
2. Asegúrate de que WSL2 esté habilitado:
   ```powershell
   wsl --set-default-version 2
   ```
3. Reinicia Docker Desktop

### Problema: Error al restaurar la base de datos

```powershell
# Verifica que el archivo existe
Test-Path docker\sygt_data.sql

# Verifica la codificación del archivo (debe ser UTF-8)
# Abre el archivo en VSCode y verifica la codificación en la barra inferior

# Intenta restaurar con el comando completo
docker exec -i postgres_local psql -U admin -d sygt_data < docker\sygt_data.sql
```

### Problema: No se ven los cambios en el código

```powershell
# Reinicia el contenedor PHP
docker compose restart php_app

# Limpia la caché del navegador (Ctrl + Shift + R)
```

### Problema: Error de permisos en postgres-data

```powershell
# En Windows, elimina la carpeta postgres-data
Remove-Item -Recurse -Force postgres-data

# Levanta de nuevo los contenedores
docker compose up -d
```

---

## 📊 Configuración de la base de datos

### Credenciales por defecto

```
Host: localhost (desde Windows) / postgres (desde contenedores)
Puerto: 5432
Base de datos: sygt_data
Usuario: admin
Contraseña: elpasswordesesis
```

### Esquemas principales

- **arb**: Arbitrios (arbitrio, arbitrio_detalle, tipo_beneficio, tributo)
- **gen**: General (gen_contribuyente, gen_predio, gen_via)
- **caj**: Caja (pago, recibo, cajero, concepto_pago)

---

## 🔐 Seguridad

**IMPORTANTE para producción:**

1. Cambia las credenciales de la base de datos en `docker-compose.yml`
2. Usa variables de entorno para datos sensibles
3. No subas credenciales al repositorio
4. Configura un firewall adecuado
5. Usa HTTPS con certificados SSL

---

## 📝 Desarrollo

### Agregar nuevas dependencias PHP

```powershell
# Acceder al contenedor
docker exec -it php_app bash

# Dentro del contenedor
composer require nombre-paquete
```

### Modificar la configuración de Nginx

1. Edita: `docker/nginx/default.conf`
2. Reinicia el contenedor:
   ```powershell
   docker compose restart nginx_app
   ```

### Modificar la configuración de PHP

1. Edita: `docker/php/Dockerfile`
2. Reconstruye la imagen:
   ```powershell
   docker compose build php_app
   docker compose up -d
   ```

---

## 📚 Recursos adicionales

- [Documentación de Docker](https://docs.docker.com/)
- [Documentación de PostgreSQL](https://www.postgresql.org/docs/)
- [Documentación de Nginx](https://nginx.org/en/docs/)
- [PHP Manual](https://www.php.net/manual/es/)

---

## 🤝 Contribuir

1. Haz un fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Haz commit de tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crea un Pull Request

---

## ⚠️ Notas importantes

- **Persistencia de datos:** Los datos de PostgreSQL se guardan en la carpeta `postgres-data/`. Si eliminas esta carpeta, perderás todos los datos.
- **Entorno local:** Todo CRUD que hagas dentro de Docker solo afecta a la copia local de la BD. La BD original en el servidor no se verá modificada.
- **Actualizaciones:** Después de actualizar el código desde Git, reinicia los contenedores:
  ```powershell
  git pull origin main
  docker compose restart
  ```

---

## 📞 Soporte

Si encuentras problemas, revisa:
1. Los logs de Docker: `docker compose logs`
2. La sección de solución de problemas
3. Los issues en GitHub

---

## 📄 Licencia

[Especifica tu licencia aquí]

---

**Última actualización:** 15 de diciembre de 2025