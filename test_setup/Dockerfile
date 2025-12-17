FROM debian:bookworm-slim

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    GUTENBERG_ENV=production \
    DJANGO_SETTINGS_MODULE=gutenberg.settings.production_settings

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    # Herramientas básicas
    curl \
    git \
    vim \
    # CUPS para impresión
    cups \
    cups-client \
    cups-bsd \
    # Dependencias de Gutenberg
    libreoffice-core-nogui \
    libreoffice-writer-nogui \
    imagemagick \
    ghostscript \
    bubblewrap \
    # Node.js y npm
    nodejs \
    npm \
    # Dependencias de Python
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Instalar uv (gestor de paquetes Python) usando pip
RUN pip3 install --break-system-packages uv

# Verificar instalación de uv
RUN uv --version

# Crear directorio de trabajo
WORKDIR /app

# Clonar el repositorio de Gutenberg
RUN git clone https://github.com/KSIUJ/gutenberg.git /app

# Configurar el backend
WORKDIR /app/backend
RUN uv sync

# Copiar configuración de ejemplo y crear configuración de producción
RUN cp production_settings.py.example production_settings.py

# Configurar la webapp
WORKDIR /app/webapp
RUN pnpm install && pnpm run build

# Volver al directorio principal
WORKDIR /app/backend

# Ejecutar migraciones (se hará en el entrypoint)
# RUN uv run manage.py migrate

# Configurar CUPS
RUN mkdir -p /var/run/cups && \
    chmod 755 /var/run/cups

# Exponer puertos
EXPOSE 11111 631

# Script de inicio
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["web"]
