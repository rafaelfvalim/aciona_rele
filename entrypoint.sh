#!/bin/sh
# Script de entrada para substituir variáveis de ambiente no HTML

# Define valores padrão se não estiverem definidos
API_KEY="${API_KEY:-}"
LOGIN_USER="${LOGIN_USER:-}"
LOGIN_PASSWORD="${LOGIN_PASSWORD:-}"

# Debug: mostra o que foi lido (sem expor senhas completas)
echo "=== Iniciando entrypoint.sh ==="
if [ -n "$LOGIN_USER" ]; then
  echo "✓ LOGIN_USER encontrado: ${LOGIN_USER}"
else
  echo "✗ LOGIN_USER não está configurado!"
fi

if [ -n "$LOGIN_PASSWORD" ]; then
  echo "✓ LOGIN_PASSWORD encontrado (tamanho: ${#LOGIN_PASSWORD} caracteres)"
else
  echo "✗ LOGIN_PASSWORD não está configurado!"
fi

if [ -n "$API_KEY" ]; then
  echo "✓ API_KEY encontrado (tamanho: ${#API_KEY} caracteres)"
else
  echo "✗ API_KEY não está configurado!"
fi

# Escapa caracteres especiais para o sed
LOGIN_USER_ESCAPED=$(echo "$LOGIN_USER" | sed 's/[[\.*^$()+?{|]/\\&/g')
LOGIN_PASSWORD_ESCAPED=$(echo "$LOGIN_PASSWORD" | sed 's/[[\.*^$()+?{|]/\\&/g')
API_KEY_ESCAPED=$(echo "$API_KEY" | sed 's/[[\.*^$()+?{|]/\\&/g')

# Substitui placeholders no HTML
sed -i "s|__API_KEY__|${API_KEY_ESCAPED}|g" /usr/share/nginx/html/index.html
sed -i "s|__LOGIN_USER__|${LOGIN_USER_ESCAPED}|g" /usr/share/nginx/html/index.html
sed -i "s|__LOGIN_PASSWORD__|${LOGIN_PASSWORD_ESCAPED}|g" /usr/share/nginx/html/index.html

# Verifica se a substituição funcionou
if grep -q "__API_KEY__" /usr/share/nginx/html/index.html 2>/dev/null; then
  echo "AVISO: Placeholder __API_KEY__ ainda presente no HTML!"
fi

if grep -q "__LOGIN_USER__" /usr/share/nginx/html/index.html 2>/dev/null; then
  echo "AVISO: Placeholder __LOGIN_USER__ ainda presente no HTML!"
fi

if grep -q "__LOGIN_PASSWORD__" /usr/share/nginx/html/index.html 2>/dev/null; then
  echo "AVISO: Placeholder __LOGIN_PASSWORD__ ainda presente no HTML!"
fi

echo "=== Iniciando nginx ==="

# Inicia o nginx
exec nginx -g "daemon off;"
