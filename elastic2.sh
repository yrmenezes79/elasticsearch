#Atualize o índice de pacotes:
sudo apt update

#Instale as dependências:
sudo apt install apt-transport-https ca-certificates wget

#Adicione a chave pública do repositório Elasticsearch:
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

#Adicione o repositório do Elasticsearch ao seu sistema:
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list

#Atualize o índice de pacotes:
sudo apt update

#Instale o Elasticsearch:
sudo apt install elasticsearch jq
exit 0
#########
cluster.name: elastic
node.name: 192.168.86.144
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: 192.168.86.144
http.port: 9200
cluster.initial_master_nodes: ["192.168.86.144"]

xpack.security.enabled: true
xpack.security.enrollment.enabled: true

xpack.security.http.ssl:
  enabled: true
  keystore.path: certs/http.p12

xpack.security.transport.ssl:
  enabled: true
  verification_mode: certificate
  keystore.path: certs/transport.p12
  truststore.path: certs/transport.p12

http.host: 0.0.0.0

#######################
start elasticsearch

cd /usr/share/elasticsearch/bin/
./elasticsearch-reset-password -u elastic

https://192.168.86.144:9200/

