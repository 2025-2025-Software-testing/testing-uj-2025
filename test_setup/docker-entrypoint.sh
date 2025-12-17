#!/bin/bash
set -e

cd /app/backend

# Función para esperar a que un servicio esté disponible
wait_for_service() {
    local host=$1
    local port=$2
    local service=$3
    
    echo "Esperando a que ${service} esté listo..."
    while ! nc -z ${host} ${port}; do
        sleep 0.1
    done
    echo "${service} está listo!"
}

# Ejecutar el comando apropiado según el argumento
case "$1" in
    web)
        # Esperar a que la base de datos esté lista
        wait_for_service db 5432 "PostgreSQL"
        
        # Iniciar CUPS en el contenedor
        echo "Iniciando CUPS..."
        sudo cupsd || echo "CUPS ya está corriendo o falló al iniciar"
        
        # Ejecutar migraciones
        echo "Ejecutando migraciones..."
        uv run ./manage.py migrate --noinput
        
        # Recolectar archivos estáticos
        echo "Recolectando archivos estáticos..."
        uv run ./manage.py collectstatic --noinput || true
        
        # Probar el comando lp
        echo "Probando comando lp..."
        lpstat -r || echo "CUPS iniciando..."
        sleep 2
        lpstat -p -d || echo "No hay impresoras configuradas todavía"
        
        # Verificar comandos requeridos
        echo "Verificando comandos requeridos..."
        command -v libreoffice >/dev/null 2>&1 && echo "✓ libreoffice disponible" || echo "✗ libreoffice no disponible"
        command -v convert >/dev/null 2>&1 && echo "✓ convert (imagemagick) disponible" || echo "✗ convert no disponible"
        command -v gs >/dev/null 2>&1 && echo "✓ gs (ghostscript) disponible" || echo "✗ gs no disponible"
        command -v bwrap >/dev/null 2>&1 && echo "✓ bwrap (bubblewrap) disponible" || echo "✗ bwrap no disponible"
        
        echo "Iniciando servidor Django..."
        exec uv run ./manage.py runserver 0.0.0.0:8000
        ;;
    celery)
        # Esperar a servicios necesarios
        wait_for_service db 5432 "PostgreSQL"
        wait_for_service redis 6379 "Redis"
        
        echo "Iniciando Celery worker con beat..."
        exec uv run celery -A gutenberg worker -B -l INFO
        ;;
    *)
        exec "$@"
        ;;
esac
