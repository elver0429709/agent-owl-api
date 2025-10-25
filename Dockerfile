# Imagen base de Python
FROM python:3.10

# Establecer directorio de trabajo
WORKDIR /app

# Copiar los archivos de requerimientos e instalarlos
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo el código fuente
COPY . .

# Exponer el puerto
EXPOSE 3000

# Comando de inicio
CMD ["python", "owl/webapp.py"]
