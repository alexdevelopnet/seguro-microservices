# Script PowerShell para verificar bancos de dados do Seguro Platform
Write-Host "🗄️ SEGURO PLATFORM - DATABASE CHECKER" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Função para executar comando Docker
function Invoke-DockerCommand {
    param([string]$Command)
    try {
        $result = Invoke-Expression $Command 2>&1
        return $result
    }
    catch {
        return "Erro: $($_.Exception.Message)"
    }
}

# Verificar status do PostgreSQL
Write-Host "📊 Status do PostgreSQL:" -ForegroundColor Yellow
$postgresStatus = Invoke-DockerCommand "docker ps --filter 'name=seguro-postgres' --format 'table {{.Name}}\t{{.Status}}\t{{.Ports}}'"
Write-Host $postgresStatus -ForegroundColor White

Write-Host ""

# Verificar bancos disponíveis
Write-Host "🔍 Bancos de dados disponíveis:" -ForegroundColor Yellow
$databases = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d postgres -c '\l' -t"
Write-Host $databases -ForegroundColor White

Write-Host ""

# Menu interativo
do {
    Write-Host "📋 Escolha uma opção:" -ForegroundColor Cyan
    Write-Host "1. Ver dados do PropostaService (propostadb)" -ForegroundColor White
    Write-Host "2. Ver dados do ContratacaoService (contratacaodb)" -ForegroundColor White
    Write-Host "3. Ver todas as tabelas de todos os bancos" -ForegroundColor White
    Write-Host "4. Executar consulta personalizada" -ForegroundColor White
    Write-Host "5. Ver logs do PostgreSQL" -ForegroundColor White
    Write-Host "6. Sair" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Digite sua escolha (1-6)"
    
    switch ($choice) {
        "1" {
            Write-Host ""
            Write-Host "📊 Verificando banco propostadb..." -ForegroundColor Green
            $tables = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d propostadb -c '\dt' -t"
            Write-Host "Tabelas encontradas:" -ForegroundColor Yellow
            Write-Host $tables -ForegroundColor White
            
            Write-Host ""
            Write-Host "📋 Dados da tabela Propostas:" -ForegroundColor Green
            $data = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d propostadb -c 'SELECT * FROM \"Propostas\";' -t"
            Write-Host $data -ForegroundColor White
        }
        
        "2" {
            Write-Host ""
            Write-Host "📊 Verificando banco contratacaodb..." -ForegroundColor Green
            $tables = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d contratacaodb -c '\dt' -t"
            Write-Host "Tabelas encontradas:" -ForegroundColor Yellow
            Write-Host $tables -ForegroundColor White
            
            Write-Host ""
            Write-Host "📋 Dados da tabela Contratacoes:" -ForegroundColor Green
            $data = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d contratacaodb -c 'SELECT * FROM \"Contratacoes\";' -t"
            Write-Host $data -ForegroundColor White
        }
        
        "3" {
            Write-Host ""
            Write-Host "📊 Verificando todas as tabelas..." -ForegroundColor Green
            
            Write-Host "Tabelas do propostadb:" -ForegroundColor Yellow
            $tables1 = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d propostadb -c '\dt' -t"
            Write-Host $tables1 -ForegroundColor White
            
            Write-Host "Tabelas do contratacaodb:" -ForegroundColor Yellow
            $tables2 = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d contratacaodb -c '\dt' -t"
            Write-Host $tables2 -ForegroundColor White
        }
        
        "4" {
            Write-Host ""
            Write-Host "🔍 Consulta personalizada:" -ForegroundColor Green
            $database = Read-Host "Digite o nome do banco (propostadb/contratacaodb)"
            $query = Read-Host "Digite sua consulta SQL"
            
            $result = Invoke-DockerCommand "docker exec seguro-postgres psql -U postgres -d $database -c '$query' -t"
            Write-Host "Resultado:" -ForegroundColor Yellow
            Write-Host $result -ForegroundColor White
        }
        
        "5" {
            Write-Host ""
            Write-Host "📋 Logs do PostgreSQL (últimas 30 linhas):" -ForegroundColor Green
            $logs = Invoke-DockerCommand "docker logs seguro-postgres --tail 30"
            Write-Host $logs -ForegroundColor White
        }
        
        "6" {
            Write-Host ""
            Write-Host "👋 Saindo..." -ForegroundColor Cyan
            break
        }
        
        default {
            Write-Host "❌ Opção inválida!" -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Write-Host "Pressione Enter para continuar..." -ForegroundColor Gray
    Read-Host
    
} while ($choice -ne "6")

Write-Host ""
Write-Host "Pressione qualquer tecla para sair..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
