# Como rodar localmente

## Pré-requisitos
- Docker instalado e rodando

## Opção 1: Usando o script (Windows)
```bash
run-local.bat
```

## Opção 2: Comandos manuais

### 1. Build da imagem
```bash
docker build -t controle-rele-local .
```

### 2. Parar container anterior (se existir)
```bash
docker stop controle-rele-local
docker rm controle-rele-local
```

### 3. Rodar o container
```bash
docker run -d \
  --name controle-rele-local \
  -p 8080:80 \
  -e API_BASE_URL=https://sites-api-rele.aal5pu.easypanel.host \
  -e API_KEY=XCYtkWPr9rAEaSiSlNItD5rJg6hRYWfe \
  controle-rele-local
```

### 4. Acessar
Abra no navegador: http://localhost:8080

### 5. Ver logs
```bash
docker logs -f controle-rele-local
```

### 6. Parar o container
```bash
docker stop controle-rele-local
```

## Opção 3: Rodar sem Docker (apenas para teste rápido)

Se você tiver Python instalado, pode usar um servidor HTTP simples:

```bash
# No diretório do projeto
python -m http.server 8080
```

**Nota:** Esta opção NÃO substitui as variáveis de ambiente. Os placeholders permanecerão no HTML.

## Debug

Para verificar se as variáveis foram substituídas:

1. Abra http://localhost:8080
2. Pressione F12 para abrir o DevTools
3. Vá na aba Console
4. Verifique os logs de debug
5. Vá na aba Elements/Inspector
6. Procure pelos elementos `<input id="apiBase">` e `<input id="apiKey">`
7. Verifique se os valores foram substituídos

## Verificar logs do container

```bash
docker logs controle-rele-local
```

Você deve ver algo como:
```
=== Iniciando entrypoint.sh ===
✓ API_BASE_URL encontrada: https://sites-api-rele.aal5pu...
✓ API_KEY encontrada (tamanho: 32 caracteres)
Substituindo placeholders no HTML...
=== Iniciando nginx ===
```
