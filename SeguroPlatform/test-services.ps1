# Script PowerShell para testar os serviços do Seguro Platform
# Execute este script após iniciar os serviços com Docker

Write-Host "🧪 TESTANDO SEGURO PLATFORM" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Função para testar endpoint
function Test-Endpoint {
    param(
        [string]$Url,
        [string]$ServiceName
    )
    
    try {
        $response = Invoke-WebRequest -Uri $Url -Method GET -TimeoutSec 10 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-Host "✅ $ServiceName está funcionando!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ $ServiceName retornou status $($response.StatusCode)" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "❌ $ServiceName não está respondendo: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Função para testar health check
function Test-HealthCheck {
    param(
        [string]$Url,
        [string]$ServiceName
    )
    
    try {
        $response = Invoke-WebRequest -Uri $Url -Method GET -TimeoutSec 10 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            $health = $response.Content | ConvertFrom-Json
            Write-Host "✅ $ServiceName Health Check: $($health.status)" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ $ServiceName Health Check falhou" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "❌ $ServiceName Health Check não está respondendo" -ForegroundColor Red
        return $false
    }
}

# Função para testar Swagger
function Test-Swagger {
    param(
        [string]$Url,
        [string]$ServiceName
    )
    
    try {
        $response = Invoke-WebRequest -Uri $Url -Method GET -TimeoutSec 10 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-Host "✅ $ServiceName Swagger está funcionando!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ $ServiceName Swagger retornou status $($response.StatusCode)" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host "❌ $ServiceName Swagger não está respondendo" -ForegroundColor Red
        return $false
    }
}

# Aguardar um pouco para os serviços inicializarem
Write-Host "⏳ Aguardando serviços inicializarem..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host ""
Write-Host "🔍 TESTANDO SERVIÇOS..." -ForegroundColor Yellow
Write-Host ""

# Testar PropostaService
Write-Host "📱 Testando PropostaService..." -ForegroundColor Blue
$propostaHealth = Test-HealthCheck "http://localhost:5000/health" "PropostaService"
$propostaSwagger = Test-Swagger "http://localhost:5000/swagger" "PropostaService"

Write-Host ""

# Testar ContratacaoService
Write-Host "📱 Testando ContratacaoService..." -ForegroundColor Blue
$contratacaoHealth = Test-HealthCheck "http://localhost:5001/health" "ContratacaoService"
$contratacaoSwagger = Test-Swagger "http://localhost:5001/swagger" "ContratacaoService"

Write-Host ""

# Testar PostgreSQL (via Docker)
Write-Host "🗄️ Testando PostgreSQL..." -ForegroundColor Blue
try {
    $postgresStatus = docker ps --filter "name=seguro-postgres" --format "{{.Status}}" --no-trunc
    if ($postgresStatus -like "*Up*") {
        Write-Host "✅ PostgreSQL está rodando!" -ForegroundColor Green
        $postgresOk = $true
    } else {
        Write-Host "❌ PostgreSQL não está rodando" -ForegroundColor Red
        $postgresOk = $false
    }
} catch {
    Write-Host "❌ Erro ao verificar PostgreSQL" -ForegroundColor Red
    $postgresOk = $false
}

Write-Host ""
Write-Host "📊 RESUMO DOS TESTES" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan

if ($propostaHealth -and $propostaSwagger) {
    Write-Host "✅ PropostaService: FUNCIONANDO" -ForegroundColor Green
} else {
    Write-Host "❌ PropostaService: PROBLEMAS" -ForegroundColor Red
}

if ($contratacaoHealth -and $contratacaoSwagger) {
    Write-Host "✅ ContratacaoService: FUNCIONANDO" -ForegroundColor Green
} else {
    Write-Host "❌ ContratacaoService: PROBLEMAS" -ForegroundColor Red
}

if ($postgresOk) {
    Write-Host "✅ PostgreSQL: FUNCIONANDO" -ForegroundColor Green
} else {
    Write-Host "❌ PostgreSQL: PROBLEMAS" -ForegroundColor Red
}

Write-Host ""

# Verificar se todos os serviços estão funcionando
if ($propostaHealth -and $propostaSwagger -and $contratacaoHealth -and $contratacaoSwagger -and $postgresOk) {
    Write-Host "🎉 TODOS OS SERVIÇOS ESTÃO FUNCIONANDO!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📱 URLs de Acesso:" -ForegroundColor Cyan
    Write-Host "   PropostaService: http://localhost:5000" -ForegroundColor White
    Write-Host "   ContratacaoService: http://localhost:5001" -ForegroundColor White
    Write-Host ""
    Write-Host "📚 Swagger:" -ForegroundColor Cyan
    Write-Host "   PropostaService: http://localhost:5000/swagger" -ForegroundColor White
    Write-Host "   ContratacaoService: http://localhost:5001/swagger" -ForegroundColor White
    Write-Host ""
    Write-Host "🗄️ PostgreSQL: localhost:5432" -ForegroundColor White
} else {
    Write-Host "⚠️ ALGUNS SERVIÇOS ESTÃO COM PROBLEMAS" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🔧 Para resolver:" -ForegroundColor Cyan
    Write-Host "   1. Verifique os logs: docker-compose logs" -ForegroundColor White
    Write-Host "   2. Reinicie os serviços: docker-compose restart" -ForegroundColor White
    Write-Host "   3. Aguarde mais tempo para inicialização" -ForegroundColor White
}

Write-Host ""
Write-Host "Pressione qualquer tecla para sair..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
