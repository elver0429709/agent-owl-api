# Imagen base de Python
FROM python:3.10

# Establecer directorio de trabajo
WORKDIR /app

# Copiar los archivos de requerimientos
COPY requirements.txt ./

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo el código fuente
COPY . .

# Exponer el puerto (ajústalo si tu app usa otro)
EXPOSE 3000

# Comando de inicio (ejecuta el main.py dentro de la carpeta owl)
CMD ["python", "owl/webapp.py"]
