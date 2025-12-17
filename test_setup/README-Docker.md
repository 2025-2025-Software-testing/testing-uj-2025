# Gutenberg con Docker - Configuración Local

Esta configuración automatiza la instalación y despliegue de Gutenberg con soporte completo para impresión usando Docker Compose V2.

## Archivos incluidos

- **Dockerfile**: Imagen base con todas las dependencias + build de webapp
- **Dockerfile.simple**: Imagen más simple sin build de webapp (recomendado para empezar)
- **docker-compose.yaml**: Orquestación de servicios (Docker Compose V2)
- **docker-entrypoint.sh**: Script de inicialización
- **nginx.conf**: Configuración de Nginx

## Requisitos previos

- Docker Engine 20.10+ con Docker Compose V2
- **No se necesita configurar nada en el sistema host**

**Verificar Docker Compose V2:**
```bash
docker compose version
# Debe mostrar: Docker Compose version v2.x.x
```

## Dos opciones de instalación

### Opción A: Dockerfile simple (recomendado para empezar)

Usa `Dockerfile.simple` que no construye la webapp, solo el backend:

```bash
# En docker-compose.yaml, cambiar:
# dockerfile: Dockerfile
# por:
# dockerfile: Dockerfile.simple
```

### Opción B: Dockerfile completo

Usa `Dockerfile` que intenta construir la webapp (puede tener problemas con binarios nativos).

## Instalación paso a paso

### 1. Crear estructura de directorios

```bash
mkdir gutenberg-docker
cd gutenberg-docker

# Crear directorios necesarios
mkdir -p data/media data/static secrets backend/gutenberg/settings
```

### 2. Guardar los archivos de configuración

Guarda estos archivos en `gutenberg-docker/`:
- `Dockerfile` (con build de webapp)
- `Dockerfile.simple` (sin build de webapp - recomendado)
- `docker-compose.yaml`
- `docker-entrypoint.sh`
- `nginx.conf`

### 3. Generar secretos

**Ya no es necesario** - ahora usa variables de entorno directamente. Las contraseñas están hardcoded en docker-compose.yaml para desarrollo local.

**Para producción**, cámbialas editando las variables de entorno en `docker-compose.yaml`:
```yaml
environment:
  - POSTGRES_PASSWORD=tu_password_segura_aqui
  - DJANGO_SECRET_KEY=tu_clave_secreta_aqui
```

O crea un archivo `.env` (opcional):
```bash
cp .env.example .env
nano .env  # Edita las contraseñas
```

### 4. Crear usuario del sistema (para CUPS)

**Ya no es necesario** - CUPS se ejecuta completamente dentro del contenedor Docker.

### 5. Construir e iniciar servicios

```bash
# Construir imágenes (usa Dockerfile.simple por defecto)
docker compose build

# Iniciar todos los servicios
docker compose up -d

# Ver logs en tiempo real
docker compose logs -f
```

### 6. Configurar Django

```bash
# Esperar a que los servicios inicien (30 segundos)
sleep 30

# Copiar y editar configuración
docker compose cp backend:/app/backend/gutenberg/settings/docker_settings.py.example \
  ./backend/gutenberg/settings/docker_settings.py

# Editar el archivo
nano backend/gutenberg/settings/docker_settings.py
```

**Configuración mínima en `docker_settings.py`:**

```python
# Leer secretos desde variables de entorno
import os

SECRET_KEY = os.getenv('DJANGO_SECRET_KEY', 'change-this-to-a-random-secret-key-in-production')
DEBUG = False
ALLOWED_HOSTS = ['127.0.0.1', 'localhost', 'backend']
CSRF_TRUSTED_ORIGINS = [
    'http://127.0.0.1:3000',
    'http://localhost:3000',
    'http://127.0.0.1:8000',
    'http://localhost:8000',
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'gutenberg',
        'USER': 'gutenberg',
        'PASSWORD': os.getenv('POSTGRES_PASSWORD', 'gutenberg_change_me_in_production'),
        'HOST': 'db',
        'PORT': '5432',
    }
}

CELERY_BROKER_URL = 'redis://redis:6379/0'
CELERY_RESULT_BACKEND = 'redis://redis:6379/0'

# Configuración de CUPS (interno al contenedor)
CUPS_SERVERNAME = 'localhost'
```

### 7. Reiniciar servicios con la nueva configuración

```bash
# Reiniciar para aplicar la configuración
docker compose restart backend celery

# Verificar que todo funciona
docker compose ps
```

### 8. Crear superusuario

```bash
docker compose exec backend uv run ./manage.py createsuperuser
```

## Acceso a servicios

- **Aplicación web**: http://localhost:3000
- **API Django**: http://localhost:8000
- **Admin Django**: http://localhost:3000/admin
- **CUPS Web Interface**: http://localhost:631 (opcional)

## Configuración de impresoras

CUPS se ejecuta completamente dentro del contenedor Docker. No necesitas configurar nada en el sistema host.

### Acceder a la interfaz web de CUPS

Visita: http://localhost:631

### Configurar desde la línea de comandos

```bash
# Acceder al contenedor
docker compose exec backend bash

# Listar impresoras disponibles
lpinfo -v

# Agregar una impresora de red
lpadmin -p MiImpresora -v socket://192.168.1.100:9100 -m everywhere

# Establecer como predeterminada
lpoptions -d MiImpresora

# Probar impresión
echo "Prueba de impresión desde Gutenberg" | lp
```

### Verificar configuración de impresoras

```bash
# Ver estado de impresoras
docker compose exec backend lpstat -t

# Ver trabajos en cola
docker compose exec backend lpq -a

# Probar impresión
echo "Hola desde Docker" | docker compose exec -T backend lp
```

## Comandos útiles

### Gestión de servicios

```bash
# Ver estado de todos los servicios
docker compose ps

# Ver logs de un servicio específico
docker compose logs -f backend
docker compose logs -f celery

# Reiniciar un servicio
docker compose restart backend

# Detener todos los servicios
docker compose down

# Detener y eliminar volúmenes
docker compose down -v
```

### Administración de Django

```bash
# Ejecutar migraciones
docker compose exec backend uv run ./manage.py migrate

# Crear superusuario
docker compose exec backend uv run ./manage.py createsuperuser

# Acceder al shell de Django
docker compose exec backend uv run ./manage.py shell

# Recolectar archivos estáticos
docker compose exec backend uv run ./manage.py collectstatic
```

### Verificar dependencias de impresión

```bash
docker compose exec backend bash -c "
  echo '=== Verificando dependencias ==='
  command -v libreoffice && echo '✓ LibreOffice instalado' || echo '✗ LibreOffice falta'
  command -v convert && echo '✓ ImageMagick instalado' || echo '✗ ImageMagick falta'
  command -v gs && echo '✓ Ghostscript instalado' || echo '✗ Ghostscript falta'
  command -v bwrap && echo '✓ Bubblewrap instalado' || echo '✗ Bubblewrap falta'
  echo '=== Estado de CUPS ==='
  lpstat -r || echo 'CUPS no disponible'
"
```

## Solución de problemas

### Error al construir webapp (oxc-parser)

Si ves errores como "Cannot find native binding" o problemas con `oxc-parser`:

```bash
# Solución: Usar Dockerfile.simple
# En docker-compose.yaml, cambiar:
# dockerfile: Dockerfile
# por:
# dockerfile: Dockerfile.simple

# Reconstruir
docker compose build --no-cache
```

La webapp se puede construir en desarrollo o acceder directamente al backend en puerto 8000.

### Error: "lp: Unauthorized"

Si ves este error, CUPS necesita reiniciarse:

```bash
# Reiniciar el contenedor backend
docker compose restart backend

# O reiniciar CUPS manualmente
docker compose exec backend sudo cupsd
```

### Las impresoras no aparecen

```bash
# Verificar que /run/cups está montado correctamente
docker compose exec backend ls -la /run/cups/

# Debe mostrar cups.sock si está bien montado
# Si ves directorios vacíos, Docker Desktop no puede montar /run
```

### Error de conexión a PostgreSQL

```bash
# Ver estado de la base de datos
docker compose ps db

# Ver logs
docker compose logs db

# Verificar conexión desde el backend
docker compose exec backend nc -zv db 5432
```

### Celery no procesa tareas

```bash
# Ver logs del worker
docker compose logs -f celery

# Verificar conexión a Redis
docker compose exec celery nc -zv redis 6379

# Reiniciar Celery
docker compose restart celery
```

### Reconstruir desde cero

```bash
# Detener y eliminar todo
docker compose down -v

# Eliminar imágenes
docker compose rm -f
docker rmi gutenberg-docker-backend gutenberg-docker-celery

# Reconstruir
docker compose build --no-cache
docker compose up -d
```

## Desarrollo local

Para desarrollo con hot-reload:

1. Modifica `docker_settings.py`:
```python
DEBUG = True
```

2. Usa el servidor de desarrollo de Nuxt:
```bash
docker compose exec backend bash
cd /app/webapp
export GUTENBERG_DEV_DJANGO_URL=http://localhost:8000/
pnpm run dev
```

## Respaldo y restauración

### Respaldar base de datos

```bash
docker compose exec db pg_dump -U gutenberg gutenberg > backup-$(date +%Y%m%d).sql
```

### Restaurar base de datos

```bash
docker compose exec -T db psql -U gutenberg gutenberg < backup-20241217.sql
```

### Respaldar archivos multimedia

```bash
tar -czf media-backup-$(date +%Y%m%d).tar.gz data/media/
```

## Estructura de archivos final

```
gutenberg-docker/
├── Dockerfile (opcional, con build de webapp)
├── Dockerfile.simple (usado por defecto)
├── docker-compose.yaml
├── docker-entrypoint.sh
├── nginx.conf
├── .env.example (opcional)
├── README-Docker.md
├── backend/
│   └── gutenberg/
│       └── settings/
│           └── docker_settings.py
└── data/
    ├── media/
    └── static/
```

## Seguridad

- ✅ Nunca commitear los archivos en `secrets/`
- ✅ Cambiar `ALLOWED_HOSTS` en producción
- ✅ Usar HTTPS con certificados SSL en producción
- ✅ Mantener Docker y las imágenes actualizadas
- ✅ Restringir acceso a puertos expuestos con firewall

## Recursos adicionales

- [Documentación oficial de Gutenberg](https://github.com/KSIUJ/gutenberg)
- [Docker Compose V2 documentation](https://docs.docker.com/compose/)
- [CUPS documentation](https://www.cups.org/documentation.html)

## Licencia

Este proyecto usa Gutenberg de KSIUJ. Consulta el repositorio original para información sobre la licencia.
