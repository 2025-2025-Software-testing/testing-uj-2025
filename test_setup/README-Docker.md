# Gutenberg con Docker

Este conjunto de archivos automatiza la instalación y configuración de Gutenberg con soporte completo para impresión.

## Archivos incluidos

- **Dockerfile**: Imagen base con todas las dependencias
- **docker-compose.yaml**: Orquestación de servicios
- **docker-entrypoint.sh**: Script de inicialización
- **nginx.conf**: Configuración de Nginx para producción

## Requisitos previos

- Docker Engine 20.10+
- Docker Compose 2.0+

## Instalación rápida

1. **Crear la estructura de directorios:**

```bash
mkdir gutenberg-docker
cd gutenberg-docker
```

2. **Guardar los archivos:**
   - Dockerfile
   - docker-compose.yaml
   - docker-entrypoint.sh
   - nginx.conf

3. **Configurar la aplicación:**

```bash
# Crear directorios para datos
mkdir -p data/media data/static

# Copiar el archivo de configuración
docker-compose run --rm web bash -c "cd /app/backend && cp production_settings.py.example production_settings.py"

# Editar la configuración
nano backend/production_settings.py
```

4. **Iniciar los servicios:**

```bash
# Construir las imágenes
docker-compose build

# Iniciar todos los servicios
docker-compose up -d

# Ver los logs
docker-compose logs -f
```

## Configuración de impresoras

### Acceder a la interfaz web de CUPS

Visita: `http://localhost:631`

### Agregar una impresora desde la línea de comandos

```bash
# Acceder al contenedor
docker-compose exec web bash

# Listar impresoras disponibles
lpinfo -v

# Agregar una impresora
lpadmin -p MiImpresora -v socket://192.168.1.100:9100 -m everywhere

# Establecer como predeterminada
lpoptions -d MiImpresora

# Probar la impresión
echo "Prueba de impresión" | lp
```

## Servicios disponibles

- **Web (Django)**: http://localhost:11111
- **Nginx**: http://localhost:80
- **CUPS**: http://localhost:631
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

## Comandos útiles

### Gestión de servicios

```bash
# Iniciar servicios
docker-compose up -d

# Detener servicios
docker-compose down

# Reiniciar un servicio específico
docker-compose restart web

# Ver logs de un servicio
docker-compose logs -f celery_worker
```

### Administración de Django

```bash
# Crear superusuario
docker-compose exec web uv run manage.py createsuperuser

# Ejecutar migraciones
docker-compose exec web uv run manage.py migrate

# Acceder al shell de Django
docker-compose exec web uv run manage.py shell
```

### Verificar dependencias

```bash
docker-compose exec web bash -c "
  command -v libreoffice && echo '✓ LibreOffice OK' || echo '✗ LibreOffice falta'
  command -v convert && echo '✓ ImageMagick OK' || echo '✗ ImageMagick falta'
  command -v gs && echo '✓ Ghostscript OK' || echo '✗ Ghostscript falta'
  command -v bwrap && echo '✓ Bubblewrap OK' || echo '✗ Bubblewrap falta'
"
```

### Probar impresión

```bash
# Probar con un archivo de texto
docker-compose exec web bash -c "echo 'Hola mundo' | lp"

# Listar trabajos de impresión
docker-compose exec web lpq

# Verificar estado de impresoras
docker-compose exec web lpstat -t
```

## Configuración de producción

### Variables de entorno importantes

Edita `backend/production_settings.py`:

```python
# Base de datos
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'gutenberg',
        'USER': 'gutenberg',
        'PASSWORD': 'tu_password_seguro',
        'HOST': 'db',
        'PORT': '5432',
    }
}

# Redis/Celery
CELERY_BROKER_URL = 'redis://redis:6379/0'

# Seguridad
SECRET_KEY = 'genera-una-clave-secreta-aqui'
DEBUG = False
ALLOWED_HOSTS = ['tu-dominio.com', 'localhost']
```

### Usar uWSGI en producción

Para usar uWSGI en lugar del servidor de desarrollo:

1. Instalar uWSGI en el Dockerfile
2. Crear configuración uwsgi.ini
3. Modificar el comando en docker-entrypoint.sh

## Solución de problemas

### Las impresoras no aparecen

```bash
# Verificar que CUPS esté corriendo
docker-compose exec web cupsd -f

# Verificar permisos
docker-compose exec web ls -la /var/run/cups
```

### Error de conexión a la base de datos

```bash
# Verificar que PostgreSQL esté corriendo
docker-compose ps db

# Ver logs de la base de datos
docker-compose logs db
```

### Problemas con Celery

```bash
# Ver logs del worker
docker-compose logs -f celery_worker

# Reiniciar el worker
docker-compose restart celery_worker
```

## Desarrollo local

Para desarrollo, modifica `docker-compose.yaml`:

```yaml
environment:
  - GUTENBERG_ENV=local
  - DJANGO_SETTINGS_MODULE=gutenberg.settings.local_settings
```

Y usa el servidor de desarrollo de Nuxt:

```bash
docker-compose exec web bash
cd /app/webapp
export GUTENBERG_DEV_DJANGO_URL=http://localhost:11111/
pnpm run dev
```

## Respaldo y restauración

### Respaldar la base de datos

```bash
docker-compose exec db pg_dump -U gutenberg gutenberg > backup.sql
```

### Restaurar la base de datos

```bash
docker-compose exec -T db psql -U gutenberg gutenberg < backup.sql
```

## Seguridad

- Cambia todas las contraseñas predeterminadas
- Usa HTTPS en producción (configura certificados SSL)
- Restringe el acceso a CUPS (puerto 631)
- Mantén Docker y las imágenes actualizadas

## Licencia

Este proyecto usa Gutenberg de KSIUJ. Consulta el repositorio original para información sobre la licencia.
