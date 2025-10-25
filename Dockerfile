# Imagen base
FROM python:3.10-slim

# Establecer directorio de trabajo
WORKDIR /app

# Copiar dependencias
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar carpetas principales del proyecto
COPY owl/ ./owl/
COPY licenses/ ./licenses/
COPY .container/assets/ ./assets/
COPY .container/assets/README_ja.md ./README_ja.md
COPY .container/assets/README_zh.md ./README_zh.md

# Exponer el puerto (ajústalo si es diferente)
EXPOSE 8000

# Comando principal para ejecutar OWL
CMD ["python", "-m", "owl"]
