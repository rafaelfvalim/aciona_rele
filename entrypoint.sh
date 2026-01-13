#!/bin/sh
# Script de entrada para substituir variáveis de ambiente no HTML

# Define valores padrão se não estiverem definidos
API_BASE_URL="${API_BASE_URL:-}"
API_KEY="${API_KEY:-}"

# Substitui placeholders no HTML
sed -i "s|__API_BASE_URL__|${API_BASE_URL}|g" /usr/share/nginx/html/index.html
sed -i "s|__API_KEY__|${API_KEY}|g" /usr/share/nginx/html/index.html

# Inicia o nginx
exec nginx -g "daemon off;"
