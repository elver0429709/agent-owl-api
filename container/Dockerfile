# Imagen base de Python
FROM python:3.10

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de requisitos (desde raíz del repo)
COPY ./requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo el proyecto (desde raíz, no solo /container)
COPY . .

# Exponer puerto (ajústalo si tu app usa otro)
EXPOSE 3000

# Comando de ejecución (ajustado)
CMD ["python", "owl/main.py"]
