# Use uma imagem base oficial do Python. A 'slim' é um bom equilíbrio entre tamanho e compatibilidade.
#--FROM python:3.11-slim
# Usei a versão mais recente do alpine, na aula usado FROM python:3.13.4-alpine3.22, no site https://hub.docker.com/_/python, mais atual abaixo.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir: Desabilita o cache para reduzir o tamanho da imagem
# --upgrade pip: Garante que estamos usando a versão mais recente do pip
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para o mundo fora deste contêiner
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner for iniciado
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload" ]