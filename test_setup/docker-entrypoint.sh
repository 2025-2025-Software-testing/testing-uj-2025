#!/bin/bash
set -e

cd /app/backend

# Esperar a que la base de datos esté lista
echo "Esperando a que PostgreSQL esté listo..."
while ! nc -z db 5432; do
  sleep 0.1
done
echo "PostgreSQL está listo!"

# Ejecutar migraciones
echo "Ejecutando migraciones..."
uv run manage.py migrate --noinput

# Recolectar archivos estáticos
echo "Recolectando archivos estáticos..."
uv run manage.py collectstatic --noinput || true

# Iniciar CUPS si es necesario
if [ ! -f /var/run/cups/cupsd.pid ]; then
    echo "Iniciando CUPS..."
    cupsd
fi

# Probar el comando lp
echo "Probando comando lp..."
lpstat -p -d || echo "No hay impresoras configuradas todavía"

# Verificar comandos requeridos
echo "Verificando comandos requeridos..."
command -v libreoffice >/dev/null 2>&1 && echo "✓ libreoffice disponible" || echo "✗ libreoffice no disponible"
command -v convert >/dev/null 2>&1 && echo "✓ convert (imagemagick) disponible" || echo "✗ convert no disponible"
command -v gs >/dev/null 2>&1 && echo "✓ gs (ghostscript) disponible" || echo "✗ gs no disponible"
command -v bwrap >/dev/null 2>&1 && echo "✓ bwrap (bubblewrap) disponible" || echo "✗ bwrap no disponible"

# Ejecutar el comando apropiado según el argumento
case "$1" in
    web)
        echo "Iniciando servidor web Django..."
        exec uv run manage.py runserver 0.0.0.0:11111
        ;;
    celery)
        echo "Iniciando Celery worker..."
        exec uv run celery -A gutenberg worker -l INFO
        ;;
    beat)
        echo "Iniciando Celery beat..."
        exec uv run celery -A gutenberg beat -l INFO
        ;;
    *)
        exec "$@"
        ;;
esac
