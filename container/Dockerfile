# Imagen base de Python
FROM python:3.10

# Establecer directorio de trabajo
WORKDIR /app

# Copiar los archivos de requerimientos e instalarlos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del proyecto
COPY . .

# Exponer el puerto (ajusta si tu app usa otro)
EXPOSE 3000

# Comando de ejecución (ajusta según tu punto de entrada)
CMD ["python", "-m", "owl.main"]
