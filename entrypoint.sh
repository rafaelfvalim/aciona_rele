#!/bin/sh
# Script de entrada para substituir variáveis de ambiente no HTML

echo "=== Iniciando entrypoint.sh ==="

# Define valores padrão se não estiverem definidos
API_BASE_URL="${API_BASE_URL:-}"
API_KEY="${API_KEY:-}"

# Debug: mostra o que foi lido (sem expor a chave completa)
if [ -n "$API_BASE_URL" ]; then
  echo "✓ API_BASE_URL encontrada: ${API_BASE_URL:0:30}..."
else
  echo "✗ API_BASE_URL não está configurada!"
fi

if [ -n "$API_KEY" ]; then
  KEY_LEN=${#API_KEY}
  echo "✓ API_KEY encontrada (tamanho: ${KEY_LEN} caracteres)"
else
  echo "✗ API_KEY não está configurada!"
fi

# Verifica se o arquivo HTML existe
if [ ! -f "/usr/share/nginx/html/index.html" ]; then
  echo "ERRO: Arquivo index.html não encontrado!"
  exit 1
fi

# Substitui placeholders no HTML
echo "Substituindo placeholders no HTML..."

# Escapa caracteres especiais para o sed
API_BASE_URL_ESCAPED=$(echo "$API_BASE_URL" | sed 's/[[\.*^$()+?{|]/\\&/g')
API_KEY_ESCAPED=$(echo "$API_KEY" | sed 's/[[\.*^$()+?{|]/\\&/g')

# Substitui os placeholders
sed -i "s|__API_BASE_URL__|${API_BASE_URL_ESCAPED}|g" /usr/share/nginx/html/index.html
sed -i "s|__API_KEY__|${API_KEY_ESCAPED}|g" /usr/share/nginx/html/index.html

# Verifica se a substituição funcionou
if grep -q "__API_BASE_URL__" /usr/share/nginx/html/index.html 2>/dev/null; then
  echo "AVISO: Placeholder __API_BASE_URL__ ainda presente no HTML!"
fi

if grep -q "__API_KEY__" /usr/share/nginx/html/index.html 2>/dev/null; then
  echo "AVISO: Placeholder __API_KEY__ ainda presente no HTML!"
fi

echo "=== Iniciando nginx ==="

# Inicia o nginx
exec nginx -g "daemon off;"
