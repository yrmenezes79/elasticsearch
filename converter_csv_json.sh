#!/bin/bash

# Caminho para o arquivo CSV
csv_file="seu_arquivo.csv"

# Loop sobre cada linha do arquivo CSV
while IFS=',' read -r produto data quantidade preco
do
  # Cria o JSON com os dados
  json=$(jq -n \
            --arg produto "$produto" \
            --arg data "$data" \
            --arg quantidade "$quantidade" \
            --arg preco "$preco" \
            '{produto: $produto, data: $data, quantidade: ($quantidade|tonumber), preco: ($preco|tonumber)}')
  
  # Envia para o Elasticsearch
  curl -k -u elastic:SENHA -X POST "https://192.168.86.144:9200/produtos/_doc/" \
  -H 'Content-Type: application/json' \
  -d "$json"

done < "$csv_file"
