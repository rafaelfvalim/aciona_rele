#!/bin/bash
# Script para rodar localmente

echo "=== Build da imagem Docker ==="
docker build -t controle-rele-local .

echo ""
echo "=== Parando container anterior (se existir) ==="
docker stop controle-rele-local 2>/dev/null || true
docker rm controle-rele-local 2>/dev/null || true

echo ""
echo "=== Iniciando container ==="
docker run -d \
  --name controle-rele-local \
  -p 8080:80 \
  -e API_BASE_URL=https://sites-api-rele.aal5pu.easypanel.host \
  -e API_KEY=XCYtkWPr9rAEaSiSlNItD5rJg6hRYWfe \
  controle-rele-local

echo ""
echo "=== Container iniciado! ==="
echo "Acesse: http://localhost:8080"
echo ""
echo "Para ver os logs: docker logs -f controle-rele-local"
echo "Para parar: docker stop controle-rele-local"
