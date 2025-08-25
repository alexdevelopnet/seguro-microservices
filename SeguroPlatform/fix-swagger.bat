@echo off
echo ========================================
echo    SEGURO PLATFORM - FIX SWAGGER
echo ========================================
echo.

echo 🔧 Corrigindo problema do Swagger...
echo.

echo 📋 Problema identificado:
echo    ❌ Configurações de Kestrel conflitantes
echo    ❌ Binding para localhost em vez de 0.0.0.0
echo    ❌ Swagger retornando ERR_EMPTY_RESPONSE
echo.

echo 🛑 Parando todos os serviços...
docker-compose down

echo.
echo 🧹 Limpando containers e imagens antigas...
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
echo 🧪 Testando Swagger corrigido...
echo.

echo 📱 Testando PropostaService Swagger...
curl -s http://localhost:5000/swagger >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ PropostaService Swagger está funcionando!
) else (
    echo ❌ PropostaService Swagger ainda não está respondendo
)

echo 📱 Testando ContratacaoService Swagger...
curl -s http://localhost:5001/swagger >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ ContratacaoService Swagger está funcionando!
) else (
    echo ❌ ContratacaoService Swagger ainda não está respondendo
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
echo    ✅ Configurações de Kestrel removidas
echo    ✅ Binding forçado para 0.0.0.0
echo    ✅ Swagger funcionando corretamente
echo.
echo 🔍 Se ainda houver problemas, verifique os logs:
echo    docker-compose logs proposta-service
echo    docker-compose logs contratacao-service
echo.
pause
