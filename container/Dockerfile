# Imagen base de Python
FROM python:3.10

# Establecer directorio de trabajo
WORKDIR /app

# Copiar todo el repositorio (no solo /container)
COPY ../ ./

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Exponer puerto (ajusta si usas otro)
EXPOSE 3000

# Ejecutar el módulo principal de OWL
CMD ["python", "owl/main.py"]
