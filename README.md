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
  -e API_KEY=XCYtkWPr9rAEaSiSlNItD5rJg6hRYWfe \
  -e LOGIN_USER=toor \
  -e LOGIN_PASSWORD=r4f43l11 \
  controle-rele
```

Acesse em: http://localhost:8080

### Deploy no Easypanel

1. Conecte seu repositório Git ao Easypanel
2. Configure o serviço para usar o Dockerfile
3. A porta padrão é 80 (o Easypanel geralmente mapeia automaticamente)
4. Configure as variáveis de ambiente obrigatórias:
   * `API_KEY`: Chave de autenticação da API
   * `LOGIN_USER`: Usuário para login
   * `LOGIN_PASSWORD`: Senha para login

## Estrutura

* `index.html` - Página principal com botão de acionamento
* `Dockerfile` - Configuração do container Docker
* `nginx.conf` - Configuração do servidor web nginx
* `entrypoint.sh` - Script que injeta variáveis de ambiente no HTML
* `.dockerignore` - Arquivos ignorados no build

## Variáveis de Ambiente

O dashboard utiliza variáveis de ambiente para configuração:

* **API_KEY** (obrigatório): Chave de autenticação da API
   * Esta chave será injetada automaticamente no HTML durante a inicialização do container
* **LOGIN_USER** (obrigatório): Usuário para autenticação no sistema
* **LOGIN_PASSWORD** (obrigatório): Senha para autenticação no sistema

### Configuração no Easypanel

No painel do Easypanel, adicione as variáveis de ambiente na seção de configuração do serviço:

```
API_KEY=XCYtkWPr9rAEaSiSlNItD5rJg6hRYWfe
LOGIN_USER=toor
LOGIN_PASSWORD=r4f43l11
```

**Nota:** As variáveis são injetadas no HTML na inicialização do container através do `entrypoint.sh`. Se você alterar as variáveis, será necessário reiniciar o container.

**Segurança:** As credenciais de login são validadas no cliente. Para maior segurança em produção, considere implementar autenticação no servidor.

## API

A aplicação faz requisições POST para o endpoint do automator para gerar um pico falso e acionar o relé:

```
POST https://sites-automator.aal5pu.easypanel.host/update
Headers:
  Content-Type: application/json
Body:
{
  "api_key": "{API_KEY}",
  "field1": 12.4,
  "field2": 100,
  "field3": 7,
  "field4": 0.98,
  "status": "pms5003"
}
```

## Tecnologias

* HTML5 + CSS3 + JavaScript (vanilla)
* Nginx (servidor web)
* Docker (containerização)
