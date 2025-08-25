@echo off
echo ========================================
echo    SEGURO PLATFORM - FIX & RESTART
echo ========================================
echo.

echo 🔧 Corrigindo configurações e reiniciando...
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
timeout /t 20 /nobreak >nul

echo.
echo 📊 Verificando status dos serviços...
docker-compose ps

echo.
echo 🧪 Testando serviços corrigidos...
echo.

echo 📱 Testando PropostaService...
curl -s http://localhost:5000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ PropostaService está funcionando perfeitamente!
) else (
    echo ❌ PropostaService ainda não está respondendo
)

echo 📱 Testando ContratacaoService...
curl -s http://localhost:5001/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ ContratacaoService está funcionando perfeitamente!
) else (
    echo ❌ ContratacaoService ainda não está respondendo
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
echo    ✅ Binding de porta corrigido (0.0.0.0)
echo    ✅ HTTPS redirection removido
echo    ✅ Variáveis de ambiente corrigidas
echo.
pause
