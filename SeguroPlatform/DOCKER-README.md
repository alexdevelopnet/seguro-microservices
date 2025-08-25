# 🐳 Seguro Platform - Docker Setup

Este documento contém instruções detalhadas para executar a plataforma de seguros usando Docker.

## 🚀 Início Rápido

### Pré-requisitos
- Docker Desktop instalado e rodando
- Docker Compose disponível
- Portas 5000, 5001 e 5432 disponíveis

### Executar com Script (Recomendado)
```bash
# Windows
start-services.bat

# Linux/Mac
./start-services.sh
```

### Executar Manualmente
```bash
# Construir e iniciar todos os serviços
docker-compose up -d --build

# Ver logs
docker-compose logs -f

# Parar serviços
docker-compose down
```

## 🔧 Correções Aplicadas

### Problemas Resolvidos
- ✅ **Binding de porta**: Corrigido para usar `0.0.0.0` em vez de `localhost`
- ✅ **HTTPS redirection**: Removido para evitar avisos em desenvolvimento
- ✅ **Variáveis de ambiente**: Configuradas corretamente para Docker
- ✅ **Health checks**: Funcionando perfeitamente

### Script de Correção
Se encontrar problemas, use:
```bash
# Windows
fix-and-restart.bat

# Este script corrige e reinicia tudo automaticamente
```

## 🏗️ Arquitetura dos Serviços

### 1. PostgreSQL Database
- **Porta**: 5432
- **Usuário**: postgres
- **Senha**: TMKTtmkt123
- **Databases**: propostadb, contratacaodb

### 2. PropostaService
- **Porta**: 5000
- **Swagger**: http://localhost:5000/swagger
- **Health Check**: http://localhost:5000/health

### 3. ContratacaoService
- **Porta**: 5001
- **Swagger**: http://localhost:5001/swagger
- **Health Check**: http://localhost:5001/health

## 📋 Comandos Úteis

### Gerenciar Serviços
```bash
# Ver status dos containers
docker-compose ps

# Ver logs de um serviço específico
docker-compose logs -f proposta-service
docker-compose logs -f contratacao-service
docker-compose logs -f postgres

# Reiniciar um serviço
docker-compose restart proposta-service

# Parar e remover tudo
docker-compose down -v
```

### Debug e Troubleshooting
```bash
# Entrar no container
docker exec -it seguro-proposta-service /bin/bash
docker exec -it seguro-contratacao-service /bin/bash
docker exec -it seguro-postgres psql -U postgres

# Ver uso de recursos
docker stats

# Ver logs em tempo real
docker-compose logs -f --tail=100
```

## 🔧 Configurações

### Variáveis de Ambiente
- `ASPNETCORE_ENVIRONMENT`: Development
- `ASPNETCORE_URLS`: Configurado automaticamente
- `ConnectionStrings__DefaultConnection`: Configurado automaticamente

### Health Checks
- **PostgreSQL**: Verifica se o banco está respondendo
- **PropostaService**: Endpoint `/health` retorna status
- **ContratacaoService**: Endpoint `/health` retorna status

### Dependências
- ContratacaoService depende do PropostaService
- Ambos dependem do PostgreSQL estar saudável

## 🐛 Solução de Problemas

### Serviço não inicia
```bash
# Ver logs detalhados
docker-compose logs [nome-do-servico]

# Verificar se as portas estão disponíveis
netstat -an | findstr :5000
netstat -an | findstr :5001
netstat -an | findstr :5432
```

### Banco não conecta
```bash
# Verificar se o PostgreSQL está rodando
docker-compose ps postgres

# Testar conexão
docker exec -it seguro-postgres psql -U postgres -d postgres
```

### Swagger não carrega
- Verificar se o serviço está rodando: `docker-compose ps`
- Verificar logs: `docker-compose logs [servico]`
- Aguardar alguns segundos após o start (health checks)

### Problemas de Binding de Porta
Se ver avisos sobre "Overriding address(es)", execute:
```bash
# Windows
fix-and-restart.bat

# Ou manualmente
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## 📊 Monitoramento

### Status dos Containers
```bash
docker-compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"
```

### Health Checks
```bash
# Verificar health do PropostaService
curl http://localhost:5000/health

# Verificar health do ContratacaoService
curl http://localhost:5001/health
```

### Logs em Tempo Real
```bash
# Todos os serviços
docker-compose logs -f

# Serviço específico
docker-compose logs -f proposta-service
```

## 🧹 Limpeza

### Limpar Containers e Volumes
```bash
# Parar e remover containers
docker-compose down

# Parar e remover containers + volumes
docker-compose down -v

# Limpeza completa (cuidado!)
docker-compose down -v --remove-orphans
docker system prune -f
```

## 🔄 Atualizações

### Rebuild após mudanças no código
```bash
# Rebuild e restart
docker-compose down
docker-compose up -d --build

# Ou apenas rebuild de um serviço
docker-compose build proposta-service
docker-compose up -d proposta-service
```

## 📱 URLs de Acesso

| Serviço | URL | Swagger |
|----------|-----|---------|
| PropostaService | http://localhost:5000 | http://localhost:5000/swagger |
| ContratacaoService | http://localhost:5001 | http://localhost:5001/swagger |
| PostgreSQL | localhost:5432 | - |

## 🎯 Próximos Passos

1. ✅ Serviços rodando
2. ✅ Banco de dados conectado
3. ✅ Swagger funcionando
4. 🔄 Testar endpoints
5. 🔄 Implementar funcionalidades
6. 🔄 Adicionar testes

## 🚨 Problemas Comuns e Soluções

### Aviso: "Overriding address(es)"
**Sintoma**: Logs mostram "Overriding address(es) 'http://0.0.0.0:5000'"
**Solução**: Execute `fix-and-restart.bat`

### Aviso: "Failed to determine the https port for redirect"
**Sintoma**: Logs mostram erro de HTTPS redirection
**Solução**: Já corrigido automaticamente

### Serviço não responde externamente
**Sintoma**: Funciona localmente mas não de fora do container
**Solução**: Verificar se está usando `0.0.0.0` em vez de `localhost`

---

**Dica**: Use o script `start-services.bat` (Windows) ou `start-services.sh` (Linux/Mac) para facilitar o gerenciamento dos serviços!

**Para correções rápidas**: Use `fix-and-restart.bat` que resolve automaticamente os problemas mais comuns!
