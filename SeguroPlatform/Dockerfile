# Multi-stage build para otimizar o tamanho da imagem
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar arquivos de projeto
COPY ["src/PropostaService.API/PropostaService.API.csproj", "src/PropostaService.API/"]
COPY ["src/PropostaService.Application/PropostaService.Application.csproj", "src/PropostaService.Application/"]
COPY ["src/PropostaService.Domain/PropostaService.Domain.csproj", "src/PropostaService.Domain/"]
COPY ["src/PropostaService.Infrastructure/PropostaService.Infrastructure.csproj", "src/PropostaService.Infrastructure/"]

COPY ["src/ContratacaoService.API/ContratacaoService.API.csproj", "src/ContratacaoService.API/"]
COPY ["src/ContratacaoService.Application/ContratacaoService.Application.csproj", "src/ContratacaoService.Application/"]
COPY ["src/ContratacaoService.Domain/ContratacaoService.Domain.csproj", "src/ContratacaoService.Domain/"]
COPY ["src/ContratacaoService.Infrastructure/ContratacaoService.Infrastructure.csproj", "src/ContratacaoService.Infrastructure/"]

# Restaurar dependências
RUN dotnet restore "src/PropostaService.API/PropostaService.API.csproj"
RUN dotnet restore "src/ContratacaoService.API/ContratacaoService.API.csproj"

# Copiar código fonte
COPY . .

# Build das aplicações
RUN dotnet build "src/PropostaService.API/PropostaService.API.csproj" -c Release -o /app/build/proposta
RUN dotnet build "src/ContratacaoService.API/ContratacaoService.API.csproj" -c Release -o /app/build/contratacao

# Publish stage
FROM build AS publish
RUN dotnet publish "src/PropostaService.API/PropostaService.API.csproj" -c Release -o /app/publish/proposta
RUN dotnet publish "src/ContratacaoService.API/ContratacaoService.API.csproj" -c Release -o /app/publish/contratacao

# Runtime stage
FROM base AS final
WORKDIR /app

# Copiar aplicações publicadas
COPY --from=publish /app/publish/proposta ./proposta
COPY --from=publish /app/publish/contratacao ./contratacao

# Script para executar ambos os serviços
COPY ["start-services.sh", "./"]
RUN chmod +x start-services.sh

# Comando padrão
CMD ["./start-services.sh"]
