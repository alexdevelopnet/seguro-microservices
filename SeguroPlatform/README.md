# 🏦 SeguroPlatform - Plataforma de Microserviços para Seguros

## 📋 Descrição

O **SeguroPlatform** é uma solução de microserviços para uma plataforma de seguros, implementada em **.NET 9** seguindo os princípios da **Arquitetura Hexagonal (Ports & Adapters)**, **Clean Architecture** e **Domain-Driven Design (DDD)**.

## 🎯 Objetivo

Desenvolver um sistema simples que permita gerenciar propostas de seguro e efetuar sua contratação, utilizando:
- ✅ Arquitetura Hexagonal (Ports & Adapters)
- ✅ Abordagem baseada em microserviços (APIs REST)
- ✅ Banco de dados relacional (PostgreSQL)
- ✅ Boas práticas de Clean Code, DDD, SOLID e design patterns
- ✅ Testes unitários automatizados

## 🏗️ Arquitetura

### Estrutura dos Microserviços

```
┌─────────────────────────────────────────────────────────────────┐
│                        SeguroPlatform                          │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐    ┌─────────────────┐                   │
│  │ PropostaService │    │ContratacaoService│                   │
│  │                 │    │                 │                   │
│  │ ┌─────────────┐ │    │ ┌─────────────┐ │                   │
│  │ │     API     │ │    │ │     API     │ │                   │
│  │ ├─────────────┤ │    │ ├─────────────┤ │                   │
│  │ │Application  │ │    │ │Application  │ │                   │
│  │ ├─────────────┤ │    │ ├─────────────┤ │                   │
│  │ │   Domain    │ │    │ │   Domain    │ │                   │
│  │ ├─────────────┤ │    │ ├─────────────┤ │                   │
│  │ │Infrastructure│ │    │ │Infrastructure│ │                   │
│  │ └─────────────┘ │    │ └─────────────┘ │                   │
│  └─────────────────┘    └─────────────────┘                   │
└─────────────────────────────────────────────────────────────────┘
```

### Arquitetura Hexagonal (Ports & Adapters)

```
                    ┌─────────────────────────────────────┐
                    │           Application               │
                    │  ┌─────────────────────────────┐   │
                    │  │      Use Cases              │   │
                    │  │   (Application Services)    │   │
                    │  └─────────────────────────────┘   │
                    └─────────────────────────────────────┘
                                │
                    ┌─────────────────────────────────────┐
                    │            Ports                    │
                    │  ┌─────────────────────────────┐   │
                    │  │    IPropostaServicePort     │   │
                    │  │   IPropostaRepositoryPort   │   │
                    │  │   IContratacaoServicePort   │   │
                    │  │  IContratacaoRepositoryPort │   │
                    │  └─────────────────────────────┘   │
                    └─────────────────────────────────────┘
                                │
        ┌───────────────────────┼───────────────────────┐
        │                       │                       │
┌───────▼────────┐    ┌─────────▼─────────┐    ┌───────▼────────┐
│   Domain       │    │   Infrastructure  │    │   External     │
│                │    │                   │    │                │
│ ┌───────────┐  │    │ ┌─────────────┐   │    │ ┌───────────┐  │
│ │ Entities  │  │    │ │ Repositories│   │    │ │ HTTP      │  │
│ │ Value     │  │    │ │ DbContexts  │   │    │ │ Clients   │  │
│ │ Objects   │  │    │ │ Adapters    │   │    │ │           │  │
│ └───────────┘  │    │ └─────────────┘   │    │ └───────────┘  │
└────────────────┘    └───────────────────┘    └────────────────┘
```

## 🚀 Funcionalidades

### 1. PropostaService
- ✅ Criar proposta de seguro
- ✅ Listar propostas
- ✅ Obter proposta por ID
- ✅ Alterar status da proposta (Em Análise, Aprovada, Rejeitada)
- ✅ Expor API REST

### 2. ContratacaoService
- ✅ Contratar uma proposta (somente se Aprovada)
- ✅ Armazenar informações da contratação
- ✅ Comunicar-se com PropostaService via HTTP REST
- ✅ Expor API REST

## 🛠️ Tecnologias Utilizadas

- **.NET 9** com ASP.NET Core
- **Entity Framework Core** para ORM
- **PostgreSQL** como banco de dados
- **Swagger/OpenAPI** para documentação
- **xUnit** para testes unitários
- **Dependency Injection** nativo do .NET

## 📋 Pré-requisitos

- [.NET 9 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
- [PostgreSQL](https://www.postgresql.org/download/) (versão 12 ou superior)
- [Visual Studio 2022](https://visualstudio.microsoft.com/) ou [VS Code](https://code.visualstudio.com/)

## 🚀 Como Executar

### 1. Configurar Banco de Dados

Certifique-se de que o PostgreSQL está rodando e crie os bancos:

```sql
-- Conectar ao PostgreSQL
psql -U postgres

-- Criar bancos de dados
CREATE DATABASE propostadb;
CREATE DATABASE contratacaodb;

-- Verificar se foram criados
\l
```

### 2. Configurar Connection Strings

Os arquivos `appsettings.json` já estão configurados com as seguintes strings de conexão:

- **PropostaService**: `propostadb`
- **ContratacaoService**: `contratacaodb`

**Usuário**: `postgres`  
**Senha**: `TMKTtmkt123`  
**Porta**: `5432`

### 3. Restaurar Dependências

```bash
cd SeguroPlatform
dotnet restore
```

### 4. Executar Migrations

As migrations são aplicadas automaticamente ao iniciar os serviços.

**PropostaService**: Migrations já existem e são aplicadas automaticamente.
**ContratacaoService**: Migrations criadas e aplicadas automaticamente.

**Design-Time Factory**: Criada para permitir geração de novas migrações.

### 5. Executar os Microserviços

#### Opção 1: Executar Individualmente

**Terminal 1 - PropostaService**
```bash
cd src/PropostaService.API
dotnet run
```

**Terminal 2 - ContratacaoService**
```bash
cd src/ContratacaoService.API
dotnet run
```

#### Opção 2: Executar com Docker (Recomendado)

```bash
# Executar todos os serviços
docker-compose up -d

# Ver logs
docker-compose logs -f

# Parar serviços
docker-compose down
```

#### Opção 3: Executar com Script

```bash
# Linux/Mac
./start-services.sh

# Windows
start-services.bat
```

### 6. Acessar as APIs

- **PropostaService**: http://localhost:5000
- **ContratacaoService**: http://localhost:5001
- **Swagger**: http://localhost:5000/swagger e http://localhost:5001/swagger

**⚠️ Importante**: As portas estão fixas e configuradas para evitar conflitos de comunicação entre os serviços.

## 🧪 Executar Testes

```bash
# Executar todos os testes
dotnet test

# Executar testes de um projeto específico
dotnet test src/PropostaService.Tests/PropostaService.Tests.csproj
```

## 📚 Endpoints da API

### PropostaService

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `POST` | `/api/propostas` | Criar nova proposta |
| `GET` | `/api/propostas` | Listar todas as propostas |
| `GET` | `/api/propostas/{id}` | Obter proposta por ID |
| `PATCH` | `/api/propostas/{id}/status` | Alterar status da proposta |

### ContratacaoService

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `POST` | `/api/contratacoes` | Contratar proposta |
| `GET` | `/api/contratacoes` | Listar contratações |

## 🔄 Fluxo de Negócio

1. **Criar Proposta**: Usuário cria proposta com status "Em Análise"
2. **Analisar Proposta**: Analista altera status para "Aprovada" ou "Rejeitada"
3. **Contratar**: Sistema permite contratação apenas de propostas "Aprovadas"
4. **Validação**: ContratacaoService verifica status via HTTP com PropostaService

## 🏗️ Estrutura do Projeto

```
SeguroPlatform/
├── src/
│   ├── PropostaService.Domain/           # Entidades e regras de negócio
│   ├── PropostaService.Application/      # Casos de uso e serviços
│   ├── PropostaService.Infrastructure/   # Implementações concretas
│   ├── PropostaService.API/              # Controllers e configuração
│   ├── ContratacaoService.Domain/        # Entidades e regras de negócio
│   ├── ContratacaoService.Application/   # Casos de uso e serviços
│   ├── ContratacaoService.Infrastructure/# Implementações concretas
│   ├── ContratacaoService.API/           # Controllers e configuração
│   └── PropostaService.Tests/            # Testes unitários
├── docker-compose.yml                    # Orquestração dos serviços
├── Dockerfile                           # Containerização
├── start-services.sh                    # Script de inicialização
├── create-databases.sql                 # Script de criação dos bancos
├── SeguroPlatform.sln                   # Solution file
└── README.md                            # Este arquivo
```

## 🧪 Cobertura de Testes

- **PropostaService**: 4 testes unitários
  - ✅ Criar proposta com status "Em Análise"
  - ✅ Alterar status para "Aprovada"
  - ✅ Alterar status para "Rejeitada"
  - ✅ Validar status inválido

**Testes executados com sucesso**: `dotnet test` passando em todos os cenários.

## 🔧 Padrões Implementados

- **Clean Architecture**: Separação clara de responsabilidades
- **DDD**: Entidades, Value Objects e Repositories
- **SOLID**: Princípios de design orientado a objetos
- **Repository Pattern**: Abstração de acesso a dados
- **Dependency Injection**: Inversão de controle
- **Ports & Adapters**: Arquitetura hexagonal
- **Factory Pattern**: Design-time factory para migrações
- **Adapter Pattern**: HTTP adapter para comunicação entre serviços

## 🚀 Próximos Passos

- [ ] Implementar autenticação e autorização
- [ ] Adicionar logging estruturado
- [ ] Implementar health checks
- [ ] Adicionar métricas e monitoramento
- [ ] Implementar cache (Redis)
- [ ] Adicionar validações com FluentValidation
- [ ] Implementar testes de integração
- [x] ✅ Criar Dockerfile e docker-compose
- [ ] Implementar CI/CD pipeline

## 📝 Licença

Este projeto é de uso educacional e demonstração de arquitetura.

## 👥 Contribuição

Contribuições são bem-vindas! Por favor, abra uma issue ou pull request.

---

**Desenvolvido com ❤️ seguindo as melhores práticas de arquitetura de software**
