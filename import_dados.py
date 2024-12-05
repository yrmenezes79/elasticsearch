from elasticsearch import Elasticsearch
import csv

# Configurações do Elasticsearch
ELASTIC_HOST = "https://192.168.86.142:9200"
ELASTIC_USER = "elastic"
ELASTIC_PASSWORD = "XXXXXXX"
INDEX_NAME = "contatos"

# Conexão com o Elasticsearch
es = Elasticsearch(
    [ELASTIC_HOST],
    basic_auth=(ELASTIC_USER, ELASTIC_PASSWORD),
    verify_certs=False
)

# Função para criar índice com mapeamento personalizado
def criar_indice():
    if not es.indices.exists(index=INDEX_NAME):
        mapping = {
            "mappings": {
                "properties": {
                    "nome": {"type": "text"},
                    "numero_telefone": {"type": "keyword"},
                    "email": {"type": "keyword"},
                    "endereco_ip": {"type": "ip"},
                    "perfil_redes_sociais": {"type": "keyword"},
                    "genero": {"type": "keyword"}
                }
            }
        }
        es.indices.create(index=INDEX_NAME, body=mapping)
        print(f"Índice '{INDEX_NAME}' criado com sucesso.")
    else:
        print(f"Índice '{INDEX_NAME}' já existe.")

# Função para importar dados do arquivo para o Elasticsearch
def importar_dados(arquivo):
    with open(arquivo, 'r') as file:
        leitor = csv.reader(file)
        for linha in leitor:
            if len(linha) == 6:  # Certifique-se de que todos os campos existem
                doc = {
                    "nome": linha[0],
                    "numero_telefone": linha[1],
                    "email": linha[2],
                    "endereco_ip": linha[3],
                    "perfil_redes_sociais": linha[4],
                    "genero": linha[5]
                }
                es.index(index=INDEX_NAME, body=doc)
                print(f"Documento inserido: {doc}")
        print("Importação concluída.")

# Criar o índice e importar os dados
try:
    criar_indice()
    importar_dados("dados.txt")
except Exception as e:
    print(f"Erro ao executar o script: {e}")
