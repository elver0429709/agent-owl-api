# Imagen base estable
FROM python:3.10-slim

# Variables de entorno para mejor desempeño
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Directorio de trabajo
WORKDIR /app

# Copiar archivo de dependencias
COPY requirements.txt .

# Actualizar pip y wheel antes de instalar
RUN pip install --upgrade pip setuptools wheel

# Instalar dependencias del proyecto
RUN pip install --no-cache-dir -r requirements.txt

# Instalar manualmente el paquete Camel (Render no soporta subcarpetas en pip)
RUN pip install "git+https://github.com/camel-ai/camel.git@main#egg=camel&subdirectory=camel"

# Copiar todo el código fuente
COPY . .

# Exponer el puerto (Render usa 10000 o 3000 según config)
EXPOSE 3000

# Comando de inicio
CMD ["python", "owl/webapp.py"]
