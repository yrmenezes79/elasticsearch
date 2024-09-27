curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic.gpg

echo "deb [signed-by=/usr/share/keyrings/elastic.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

sudo apt update

sudo apt install elasticsearch net-tools

vi /etc/elasticsearch/elasticsearch.yml

#Alterar o seguintes parâmetros:
#			network.host: <IP LOCAL>
#			http.port: 9200
#			discovery.seed_hosts: <IP LOCAL>
	


