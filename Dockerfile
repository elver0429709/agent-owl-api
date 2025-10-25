# Imagen base
FROM python:3.10-slim

# Variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema (para compilar paquetes)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Copiar dependencias
COPY requirements.txt .

# Instalar pip actualizado
RUN pip install --upgrade pip setuptools wheel

# Instalar dependencias base
RUN pip install --no-cache-dir -r requirements.txt

# Instalar CAMEL manualmente desde GitHub (sin usar subcarpeta)
RUN git clone https://github.com/camel-ai/camel.git /tmp/camel \
    && pip install /tmp/camel/camel \
    && rm -rf /tmp/camel

# Copiar el resto del código
COPY . .

# Exponer el puerto
EXPOSE 3000

# Comando de inicio
CMD ["python", "owl/webapp.py"]
