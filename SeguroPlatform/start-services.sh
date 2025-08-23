#!/bin/bash

# Script para executar ambos os microserviços
echo "🚀 Iniciando SeguroPlatform..."

# Função para executar um serviço em background
start_service() {
    local service_name=$1
    local service_path=$2
    local port=$3
    
    echo "📡 Iniciando $service_name na porta $port..."
    cd "$service_path" && dotnet run --urls "http://localhost:$port" &
    echo "✅ $service_name iniciado com sucesso!"
}

# Iniciar PropostaService na porta 5000
start_service "PropostaService" "./proposta" "5000"

# Aguardar um pouco para o primeiro serviço inicializar
sleep 3

# Iniciar ContratacaoService na porta 5001
start_service "ContratacaoService" "./contratacao" "5001"

echo "🎉 Ambos os microserviços foram iniciados!"
echo "📱 PropostaService: http://localhost:5000"
echo "📱 ContratacaoService: http://localhost:5001"
echo "📚 Swagger PropostaService: http://localhost:5000/swagger"
echo "📚 Swagger ContratacaoService: http://localhost:5001/swagger"

# Manter o container rodando
echo "⏳ Pressione Ctrl+C para parar os serviços..."
wait
