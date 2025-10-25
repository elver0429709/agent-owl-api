# Imagen base ligera
FROM python:3.10-slim

# Configurar entorno
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Establecer directorio de trabajo
WORKDIR /app

# Instalar git y herramientas básicas
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Copiar dependencias
COPY requirements.txt .

# Actualizar pip y wheel
RUN pip install --upgrade pip setuptools wheel

# Instalar dependencias normales primero
RUN pip install --no-cache-dir -r requirements.txt

# Instalar CAMEL manualmente sin git checkout
RUN git clone https://github.com/camel-ai/camel.git /tmp/camel \
    && pip install /tmp/camel/camel \
    && rm -rf /tmp/camel

# Instalar MCP manualmente si falla (opcional)
RUN git clone https://github.com/modelcontextprotocol/servers.git /tmp/mcp \
    && pip install /tmp/mcp/server-fetch \
    && rm -rf /tmp/mcp

# Copiar el código fuente
COPY . .

# Exponer puerto
EXPOSE 3000

# Comando de inicio
CMD ["python", "owl/webapp.py"]
