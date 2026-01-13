# Usa nginx alpine (imagem leve)
FROM nginx:alpine

# Remove a página padrão do nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia o arquivo HTML para o diretório do nginx
COPY index.html /usr/share/nginx/html/

# Copia a configuração customizada do nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia e configura o script de entrada
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expõe a porta 80
EXPOSE 80

# Usa o script de entrada que injeta variáveis de ambiente
ENTRYPOINT ["/entrypoint.sh"]
