echo "Atualize o indice de pacotes"

apt update

echo "Instale as dependencias"

apt install apt-transport-https ca-certificates wget jq -y

echo "Adicione a chave publica do repositorio Elasticsearch"

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "Adicione o repositorio do Elasticsearch ao seu sistema"

echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list

echo "Atualize o índice de pacotes"

 apt update

echo "Instale o Elasticsearch"

apt install elasticsearch

echo "Backup arquivo de configuracao"

cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.old

echo "Alteracao das configuracoes"

IP=`hostname -I`

echo "cluster.name: elastic
node.name: $IP
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: $IP
http.port: 9200
cluster.initial_master_nodes: ["$IP"]

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
" > /etc/elasticsearch/elasticsearch.yml

echo "Start Elastic"

systemctl start elasticsearch

echo "Gerando senha"

cd /usr/share/elasticsearch/bin/
./elasticsearch-reset-password -u elastic

