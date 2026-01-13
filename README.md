# Controle de Relé

Interface web simples para acionar um relé via API REST.

## Build e Deploy

### Build local da imagem Docker

```bash
docker build -t controle-rele .
```

### Executar localmente

```bash
docker run -p 8080:80 \
  -e API_BASE_URL=https://sites-api-rele.aal5pu.easypanel.host \
  -e API_KEY=sua-chave-secreta \
  controle-rele
```

Acesse em: http://localhost:8080

### Deploy no Easypanel

1. Conecte seu repositório Git ao Easypanel
2. Configure o serviço para usar o Dockerfile
3. A porta padrão é 80 (o Easypanel geralmente mapeia automaticamente)
4. Configure as variáveis de ambiente obrigatórias:
   * `API_BASE_URL`: URL base da API (ex: `https://sites-api-rele.aal5pu.easypanel.host`)
   * `API_KEY`: Chave de autenticação da API

## Estrutura

* `index.html` - Página principal com botão de acionamento
* `Dockerfile` - Configuração do container Docker
* `nginx.conf` - Configuração do servidor web nginx
* `entrypoint.sh` - Script que injeta variáveis de ambiente no HTML
* `.dockerignore` - Arquivos ignorados no build

## Variáveis de Ambiente

O dashboard utiliza variáveis de ambiente para configuração:

* **API_BASE_URL** (obrigatório): URL base da API
   * Exemplo: `https://sites-api-rele.aal5pu.easypanel.host`
* **API_KEY** (obrigatório): Chave de autenticação da API
   * Esta chave será injetada automaticamente no HTML durante o build

### Configuração no Easypanel

No painel do Easypanel, adicione as variáveis de ambiente na seção de configuração do serviço:

```
API_BASE_URL=https://sites-api-rele.aal5pu.easypanel.host
API_KEY=sua-chave-secreta
```

**Nota:** As variáveis são injetadas no HTML na inicialização do container. Se você alterar as variáveis, será necessário reiniciar o container.

## API

A aplicação faz requisições POST para o endpoint:

```
POST {API_BASE_URL}/rele
Headers:
  Content-Type: application/json
  X-API-Key: {API_KEY}
```

## Tecnologias

* HTML5 + CSS3 + JavaScript (vanilla)
* Nginx (servidor web)
* Docker (containerização)
