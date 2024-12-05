from elasticsearch import Elasticsearch
import warnings
from urllib3.exceptions import InsecureRequestWarning

# Suprimir avisos de certificado inseguro
warnings.filterwarnings("ignore", category=InsecureRequestWarning)

# Configurações do Elasticsearch
ELASTIC_IP = "192.168.86.142"
ELASTIC_PORT = 9200
USERNAME = "elastic"
PASSWORD = "XXXX"

es = Elasticsearch(
    f"https://{ELASTIC_IP}:{ELASTIC_PORT}",
    basic_auth=(USERNAME, PASSWORD),
    verify_certs=False  # Ignora a verificação do certificado SSL
)

try:
    if es.ping():
        print("Conexão bem-sucedida com o Elasticsearch!")
        # Obtendo informações básicas do cluster
        cluster_info = es.info()
        print("Informações do cluster:")
        print(cluster_info)
    else:
        print("Não foi possível conectar ao Elasticsearch. Verifique as configurações.")
except Exception as e:
    print(f"Erro ao conectar ao Elasticsearch: {e}")
