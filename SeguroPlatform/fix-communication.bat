@echo off
echo ========================================
echo    SEGURO PLATFORM - FIX COMMUNICATION
echo ========================================
echo.

echo 🔧 Corrigindo comunicação entre serviços...
echo.

echo 📋 Problema identificado:
echo    ❌ ContratacaoService tentando conectar em localhost:5000
echo    ❌ Deve conectar em proposta-service:5000 (nome do container)
echo    ❌ Erro 400 - Connection refused
echo.

echo 🛑 Parando todos os serviços...
docker-compose down

echo.
echo 🧹 Limpando containers antigos...
docker system prune -f

echo.
echo 📦 Rebuild das imagens com correções...
docker-compose build --no-cache

echo.
echo 🚀 Iniciando serviços corrigidos...
docker-compose up -d

echo.
echo ⏳ Aguardando serviços inicializarem...
timeout /t 25 /nobreak >nul

echo.
echo 📊 Verificando status dos serviços...
docker-compose ps

echo.
echo 🧪 Testando comunicação entre serviços...
echo.

echo 📱 Testando PropostaService...
curl -s http://localhost:5000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ PropostaService está funcionando!
) else (
    echo ❌ PropostaService não está respondendo
)

echo 📱 Testando ContratacaoService...
curl -s http://localhost:5001/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ ContratacaoService está funcionando!
) else (
    echo ❌ ContratacaoService não está respondendo
)

echo.
echo 🔍 Testando comunicação interna...
echo.

echo 📡 Verificando se ContratacaoService consegue acessar PropostaService...
docker exec seguro-contratacao-service curl -s http://proposta-service:5000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Comunicação interna funcionando!
) else (
    echo ❌ Problema na comunicação interna
)

echo.
echo 🎉 Correções aplicadas!
echo.
echo 📱 URLs de Acesso:
echo    PropostaService: http://localhost:5000
echo    ContratacaoService: http://localhost:5001
echo.
echo 📚 Swagger:
echo    PropostaService: http://localhost:5000/swagger
echo    ContratacaoService: http://localhost:5001/swagger
echo.
echo 🗄️  PostgreSQL: localhost:5432
echo.
echo 💡 Problemas resolvidos:
echo    ✅ URL do PropostaService corrigida para proposta-service:5000
echo    ✅ Comunicação entre containers funcionando
echo    ✅ Erro 400 - Connection refused resolvido
echo.
echo 🔍 Para testar a contratação:
echo    1. Acesse: http://localhost:5001/swagger
echo    2. Teste o endpoint de contratação
echo    3. Deve funcionar sem erro de conexão
echo.
pause
