@echo off
echo ========================================
echo    SEGURO PLATFORM - DOCKER SETUP
echo ========================================
echo.

:menu
echo Escolha uma opcao:
echo 1. Iniciar todos os servicos
echo 2. Parar todos os servicos
echo 3. Reiniciar todos os servicos
echo 4. Ver logs dos servicos
echo 5. Ver status dos containers
echo 6. Limpar tudo (containers + volumes)
echo 7. Sair
echo.
set /p choice="Digite sua escolha (1-7): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto stop
if "%choice%"=="3" goto restart
if "%choice%"=="4" goto logs
if "%choice%"=="5" goto status
if "%choice%"=="6" goto clean
if "%choice%"=="7" goto exit
echo Opcao invalida! Tente novamente.
echo.
goto menu

:start
echo.
echo 🚀 Iniciando todos os servicos...
docker-compose up -d
echo.
echo ✅ Servicos iniciados com sucesso!
echo.
echo 📱 PropostaService: http://localhost:5000
echo 📱 ContratacaoService: http://localhost:5001
echo 📚 Swagger PropostaService: http://localhost:5000/swagger
echo 📚 Swagger ContratacaoService: http://localhost:5001/swagger
echo 🗄️  PostgreSQL: localhost:5432
echo.
echo Aguarde alguns segundos para os servicos ficarem prontos...
echo.
goto menu

:stop
echo.
echo 🛑 Parando todos os servicos...
docker-compose down
echo ✅ Servicos parados com sucesso!
echo.
goto menu

:restart
echo.
echo 🔄 Reiniciando todos os servicos...
docker-compose down
docker-compose up -d
echo ✅ Servicos reiniciados com sucesso!
echo.
goto menu

:logs
echo.
echo 📋 Escolha qual servico ver os logs:
echo 1. PropostaService
echo 2. ContratacaoService
echo 3. PostgreSQL
echo 4. Todos os servicos
echo 5. Voltar ao menu
echo.
set /p logchoice="Digite sua escolha (1-5): "

if "%logchoice%"=="1" (
    echo 📋 Logs do PropostaService:
    docker-compose logs -f proposta-service
) else if "%logchoice%"=="2" (
    echo 📋 Logs do ContratacaoService:
    docker-compose logs -f contratacao-service
) else if "%logchoice%"=="3" (
    echo 📋 Logs do PostgreSQL:
    docker-compose logs -f postgres
) else if "%logchoice%"=="4" (
    echo 📋 Logs de todos os servicos:
    docker-compose logs -f
) else if "%logchoice%"=="5" (
    goto menu
) else (
    echo Opcao invalida!
)
echo.
goto menu

:status
echo.
echo 📊 Status dos containers:
docker-compose ps
echo.
echo 📊 Status dos health checks:
docker-compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"
echo.
goto menu

:clean
echo.
echo ⚠️  ATENCAO: Esta operacao ira remover TODOS os containers e volumes!
echo.
set /p confirm="Tem certeza que deseja continuar? (s/N): "
if /i "%confirm%"=="s" (
    echo 🧹 Limpando tudo...
    docker-compose down -v --remove-orphans
    docker system prune -f
    echo ✅ Limpeza concluida!
) else (
    echo ❌ Operacao cancelada!
)
echo.
goto menu

:exit
echo.
echo 👋 Obrigado por usar o Seguro Platform!
echo.
pause
