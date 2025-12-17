# Clonar y construir
# Guardar los archivos aquí
docker compose build
docker compose up -d

# Configurar impresora
docker compose exec web lpadmin -p MiImpresora -v socket://IP:9100 -m everywhere

# Probar impresión
#echo "Hola" | docker-compose exec -T web lp
