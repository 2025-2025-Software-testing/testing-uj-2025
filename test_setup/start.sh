mkdir -p data/media data/static backend/gutenberg/settings

# Construir e iniciar
docker compose build
docker compose up -d

# Configurar impresora
docker compose exec backend lpadmin -p MiImpresora -v socket://192.168.1.100:9100 -m everywhere

# Acceder a CUPS web
# http://localhost:631
