# Use uma imagem base oficial do Python.
# Alpine é uma boa escolha por ser leve.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
# (Assumindo que você tem um arquivo requirements.txt)
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir reduz o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta que a aplicação vai rodar
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]