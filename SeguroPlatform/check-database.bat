@echo off
echo ========================================
echo    SEGURO PLATFORM - CHECK DATABASE
echo ========================================
echo.

echo 🗄️ Verificando bancos de dados...
echo.

echo 📊 Status do PostgreSQL:
docker ps --filter "name=seguro-postgres" --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"

echo.
echo 🔍 Verificando bancos disponíveis...
docker exec seguro-postgres psql -U postgres -d postgres -c "\l"

echo.
echo 📋 Escolha uma opção:
echo 1. Ver dados do PropostaService (propostadb)
echo 2. Ver dados do ContratacaoService (contratacaodb)
echo 3. Entrar no psql interativo
echo 4. Ver logs do PostgreSQL
echo 5. Sair
echo.
set /p choice="Digite sua escolha (1-5): "

if "%choice%"=="1" goto check-propostas
if "%choice%"=="2" goto check-contratacoes
if "%choice%"=="3" goto psql-interactive
if "%choice%"=="4" goto view-logs
if "%choice%"=="5" goto exit
echo Opcao invalida!
goto menu

:check-propostas
echo.
echo 📊 Verificando banco propostadb...
docker exec seguro-postgres psql -U postgres -d propostadb -c "\dt"
echo.
echo 📋 Dados da tabela Propostas:
docker exec seguro-postgres psql -U postgres -d propostadb -c "SELECT * FROM \"Propostas\";"
echo.
pause
goto menu

:check-contratacoes
echo.
echo 📊 Verificando banco contratacaodb...
docker exec seguro-postgres psql -U postgres -d contratacaodb -c "\dt"
echo.
echo 📋 Dados da tabela Contratacoes:
docker exec seguro-postgres psql -U postgres -d contratacaodb -c "SELECT * FROM \"Contratacoes\";"
echo.
pause
goto menu

:psql-interactive
echo.
echo 🔧 Entrando no psql interativo...
echo Para sair digite: \q
echo.
docker exec -it seguro-postgres psql -U postgres -d postgres
goto menu

:view-logs
echo.
echo 📋 Logs do PostgreSQL (últimas 50 linhas):
docker logs seguro-postgres --tail 50
echo.
pause
goto menu

:exit
echo.
echo 👋 Saindo...
echo.
pause
