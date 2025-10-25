FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=0 \
    PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple \
    PLAYWRIGHT_DOWNLOAD_HOST=https://npmmirror.com/mirrors/playwright \
    PLAYWRIGHT_BROWSERS_PATH=/root/.cache/ms-playwright \
    DEBIAN_FRONTEND=noninteractive \
    PATH="/app/.venv/bin:$PATH"

# Set working directory
WORKDIR /app

# Install system dependencies (combine into one RUN command to reduce layers)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git ffmpeg libsm6 libxext6 xvfb xauth x11-utils \
    build-essential python3-dev vim\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install uv tool
RUN pip install uv

# Copy project build files
COPY pyproject.toml .
COPY README.md .
# Create README.md if it doesn't exist
RUN if [ ! -f "README.md" ]; then echo -e "# OWL Project\n\nThis is the Docker environment for the OWL project." > README.md; fi

# Create virtual environment and install dependencies
RUN uv venv .venv --python=3.10 && \
    . .venv/bin/activate && \
    uv pip install -e .

# Copy project runtime files
COPY licenses/ ./licenses/
FROM node:20

WORKDIR /app

# Copia los assets directamente
FROM node:20

WORKDIR /app

# Copia los assets directamente desde container/assets
COPY container/README_zh.md ./README_zh.md
COPY container/README_ja.md ./README_ja.md
COPY container/assets/owl-favicon.ico ./owl-favicon.ico
COPY container/assets/owl-architecture.png ./owl-architecture.png

COPY . .

RUN npm install
CMD ["npm", "start"]

# Copia el resto del proyecto
COPY . .

RUN npm install
CMD ["npm", "start"]



# Create startup script
RUN printf '#!/bin/bash\nxvfb-run --auto-servernum --server-args="-screen 0 1280x960x24" python "$@"' > /usr/local/bin/xvfb-python && \
    chmod +x /usr/local/bin/xvfb-python

# Create welcome script
RUN printf '#!/bin/bash\necho "Welcome to the OWL Project Docker environment!"\necho "Welcome to OWL Project Docker environment!"\necho ""\necho "Available scripts:"\nls -1 *.py | grep -v "__" | sed "s/^/- /"\necho ""\necho "Run examples:"\necho "  xvfb-python run.py                     # Run default script"\necho "  xvfb-python run_deepseek_example.py      # Run DeepSeek example"\necho ""\necho "Or use custom query:"\necho "  xvfb-python run.py \"Your question\""\necho ""' > /usr/local/bin/owl-welcome && \
    chmod +x /usr/local/bin/owl-welcome

# Set working directory
WORKDIR /app/owl

# Add health check
# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
# CMD python -c 'import sys;exit(0 if (import_("owl").path.exists(/app/owl) else 1))'

# Container startup command
CMD ["/bin/bash", "./run_in_docker.sh"]
