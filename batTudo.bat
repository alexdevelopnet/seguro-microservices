@echo off
SET SOLUTION_NAME=SeguroPlatform
SET SERVICE1=PropostaService
SET SERVICE2=ContratacaoService

echo ====================================================
echo Criando solucao %SOLUTION_NAME% com microservicos...
echo ====================================================

REM Criar pasta raiz e src
mkdir %SOLUTION_NAME%
cd %SOLUTION_NAME%
mkdir src

REM Criar solution
dotnet new sln -n %SOLUTION_NAME%

REM ==============================
REM Criar estrutura do PropostaService
REM ==============================
echo Criando %SERVICE1%...
dotnet new classlib -n %SERVICE1%.Domain -o src\%SERVICE1%.Domain
dotnet new classlib -n %SERVICE1%.Application -o src\%SERVICE1%.Application
dotnet new classlib -n %SERVICE1%.Infrastructure -o src\%SERVICE1%.Infrastructure
dotnet new webapi -n %SERVICE1%.API -o src\%SERVICE1%.API

REM Criar subpastas para Domain
mkdir src\%SERVICE1%.Domain\Entities
mkdir src\%SERVICE1%.Domain\Repositories
mkdir src\%SERVICE1%.Domain\ValueObjects

REM Criar subpastas para Application
mkdir src\%SERVICE1%.Application\UseCases
mkdir src\%SERVICE1%.Application\DTOs

REM Criar subpastas para Infrastructure
mkdir src\%SERVICE1%.Infrastructure\Persistence
mkdir src\%SERVICE1%.Infrastructure\Repositories

REM Criar subpastas para API
mkdir src\%SERVICE1%.API\Controllers

REM Adicionar projetos PropostaService à solution
dotnet sln add src\%SERVICE1%.Domain\%SERVICE1%.Domain.csproj
dotnet sln add src\%SERVICE1%.Application\%SERVICE1%.Application.csproj
dotnet sln add src\%SERVICE1%.Infrastructure\%SERVICE1%.Infrastructure.csproj
dotnet sln add src\%SERVICE1%.API\%SERVICE1%.API.csproj

REM Adicionar referencias PropostaService
dotnet add src\%SERVICE1%.Application\%SERVICE1%.Application.csproj reference src\%SERVICE1%.Domain\%SERVICE1%.Domain.csproj
dotnet add src\%SERVICE1%.Infrastructure\%SERVICE1%.Infrastructure.csproj reference src\%SERVICE1%.Domain\%SERVICE1%.Domain.csproj
dotnet add src\%SERVICE1%.API\%SERVICE1%.API.csproj reference src\%SERVICE1%.Application\%SERVICE1%.Application.csproj
dotnet add src\%SERVICE1%.API\%SERVICE1%.API.csproj reference src\%SERVICE1%.Infrastructure\%SERVICE1%.Infrastructure.csproj

REM ==============================
REM Criar estrutura do ContratacaoService
REM ==============================
echo Criando %SERVICE2%...
dotnet new classlib -n %SERVICE2%.Domain -o src\%SERVICE2%.Domain
dotnet new classlib -n %SERVICE2%.Application -o src\%SERVICE2%.Application
dotnet new classlib -n %SERVICE2%.Infrastructure -o src\%SERVICE2%.Infrastructure
dotnet new webapi -n %SERVICE2%.API -o src\%SERVICE2%.API

REM Criar subpastas para Domain
mkdir src\%SERVICE2%.Domain\Entities
mkdir src\%SERVICE2%.Domain\Repositories
mkdir src\%SERVICE2%.Domain\ValueObjects

REM Criar subpastas para Application
mkdir src\%SERVICE2%.Application\UseCases
mkdir src\%SERVICE2%.Application\DTOs

REM Criar subpastas para Infrastructure
mkdir src\%SERVICE2%.Infrastructure\Persistence
mkdir src\%SERVICE2%.Infrastructure\Repositories

REM Criar subpastas para API
mkdir src\%SERVICE2%.API\Controllers

REM Adicionar projetos ContratacaoService à solution
dotnet sln add src\%SERVICE2%.Domain\%SERVICE2%.Domain.csproj
dotnet sln add src\%SERVICE2%.Application\%SERVICE2%.Application.csproj
dotnet sln add src\%SERVICE2%.Infrastructure\%SERVICE2%.Infrastructure.csproj
dotnet sln add src\%SERVICE2%.API\%SERVICE2%.API.csproj

REM Adicionar referencias ContratacaoService
dotnet add src\%SERVICE2%.Application\%SERVICE2%.Application.csproj reference src\%SERVICE2%.Domain\%SERVICE2%.Domain.csproj
dotnet add src\%SERVICE2%.Infrastructure\%SERVICE2%.Infrastructure.csproj reference src\%SERVICE2%.Domain\%SERVICE2%.Domain.csproj
dotnet add src\%SERVICE2%.API\%SERVICE2%.API.csproj reference src\%SERVICE2%.Application\%SERVICE2%.Application.csproj
dotnet add src\%SERVICE2%.API\%SERVICE2%.API.csproj reference src\%SERVICE2%.Infrastructure\%SERVICE2%.Infrastructure.csproj

echo ====================================================
echo Estrutura COMPLETA criada com sucesso!
echo Caminho: %CD%
echo Abra %SOLUTION_NAME%.sln no Visual Studio ou VS Code.
echo ====================================================
pause
