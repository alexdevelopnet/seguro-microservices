using ContratacaoService.Application.Ports;
using ContratacaoService.Application.Services;
using ContratacaoService.Infrastructure.Adapters;
using ContratacaoService.Infrastructure.Persistence;
using ContratacaoService.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Configurar serviços
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "ContratacaoService API",
        Version = "v1",
        Description = "Microserviço responsável por contratar propostas de seguro"
    });
});

// Registrar HttpClient e ContratacaoAppService
builder.Services.AddHttpClient<IPropostaServicePort, PropostaServiceHttpAdapter>();
builder.Services.AddScoped<IContratacaoRepositoryPort, ContratacaoRepository>();
builder.Services.AddScoped<IContratacaoServicePort, ContratacaoAppService>();

// Configurar DbContext para PostgreSQL
var connStr = Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection")
              ?? builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ContratacaoDbContext>(options =>
    options.UseNpgsql(connStr));

var app = builder.Build();

// Configurar Swagger no ambiente Development
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "ContratacaoService API v1");
        c.RoutePrefix = "swagger";
    });
}

// aplica migrations automaticamente
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<ContratacaoDbContext>();
    db.Database.Migrate();
}

// Remover HTTPS redirection para desenvolvimento
// app.UseHttpsRedirection();

app.UseAuthorization();
app.MapControllers();

// Health check endpoint
app.MapGet("/health", () => Results.Ok(new { status = "healthy", service = "ContratacaoService" }));

// Forçar binding para 0.0.0.0 para funcionar no Docker
app.Run("http://0.0.0.0:5001");
