using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using PropostaService.Application.Services;
using PropostaService.Application.Ports;
using PropostaService.Infrastructure.Persistence;
using PropostaService.Infrastructure.Repositories;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(o =>
{
    o.SwaggerDoc("v1", new OpenApiInfo { Title = "PropostaService API", Version = "v1" });
});

var connStr = Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection")
              ?? builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<PropostaDbContext>(opt => opt.UseNpgsql(connStr));
builder.Services.AddScoped<IPropostaServicePort, PropostaAppService>();
builder.Services.AddScoped<IPropostaRepositoryPort, PropostaRepository>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "PropostaService API v1"));
}

// aplica migrations automaticamente
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<PropostaDbContext>();
    db.Database.Migrate();
}

// Health check endpoint
app.MapGet("/health", () => Results.Ok(new { status = "healthy", service = "PropostaService" }));

// Remover HTTPS redirection para desenvolvimento
// app.UseHttpsRedirection();

app.MapControllers();

// Forçar binding para 0.0.0.0 para funcionar no Docker
app.Run("http://0.0.0.0:5000");
