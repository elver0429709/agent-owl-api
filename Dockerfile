# Imagen base oficial de Python
FROM python:3.10-slim

# Evita que Python guarde archivos .pyc (optimiza el contenedor)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de dependencias primero (para aprovechar la caché de Docker)
COPY requirements.txt .

# Instala las dependencias del proyecto
RUN pip install --no-cache-dir -r requirements.txt

# Instala manualmente Camel desde GitHub (Render no soporta subdirectorios en pip)
RUN pip install "git+https://github.com/camel-ai/camel.git@main#egg=camel&subdirectory=camel"

# Copia todo el código fuente del proyecto al contenedor
COPY . .

# Expone el puerto donde se ejecutará la app
EXPOSE 3000

# Comando por defecto al iniciar el contenedor
CMD ["python", "owl/webapp.py"]
