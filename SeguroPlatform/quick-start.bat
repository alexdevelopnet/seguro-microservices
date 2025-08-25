@echo off
echo ========================================
echo    SEGURO PLATFORM - QUICK START
echo ========================================
echo.

echo 🚀 Iniciando Seguro Platform...
echo.

echo 📦 Construindo imagens Docker...
docker-compose build --no-cache

echo.
echo 🚀 Iniciando serviços...
docker-compose up -d

echo.
echo ⏳ Aguardando serviços inicializarem...
timeout /t 15 /nobreak >nul

echo.
echo 📊 Verificando status dos serviços...
docker-compose ps

echo.
echo 🧪 Testando serviços...
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
echo 🎉 Setup concluído!
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
echo 💡 Use 'start-services.bat' para gerenciar os serviços
echo 💡 Use 'test-services.ps1' para testar tudo
echo.
pause
